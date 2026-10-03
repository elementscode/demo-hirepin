import { ValidationError, getAppUrl, sql, tx } from "@elements/app";
import config from "#config";
import { stripe, testCheckout } from "#app/shared/stripe";
import { ensureWebhook } from "#app/shared/stripe-webhook";
import { getListingByToken } from "#app/shared/services/listings";
import { SendListingEmailJob } from "#app/jobs/send-listing-email";

export interface ListingPurchase {
  listingId: string;
  editToken: string;
  title: string;
  companyName: string;
  employerEmail: string;
  logoUrl: string | null;
  publish: boolean;
  feature: boolean;
}

export interface PurchaseLine {
  name: string;
  detail: string;
  amount: number;
}

/**
 * What a listing can buy right now: a draft or an expired listing publishes
 * (and may add the feature), a live one can only add the feature. Read from
 * the database, never from the browser. Throws when nothing is left to buy.
 */
export function listingPurchase(token: string, wantFeature: boolean): ListingPurchase {
  let listing = getListingByToken(token);
  let publish = listing.status === "draft" || listing.status === "expired";
  let feature = wantFeature && !listing.featured;

  if (!publish && !feature) {
    throw new ValidationError(listing.featured ? "This listing is already live and featured." : "This listing is already live.");
  }

  return {
    listingId: listing.id,
    editToken: token,
    title: listing.title,
    companyName: listing.companyName,
    employerEmail: listing.employerEmail,
    logoUrl: listing.logoUrl,
    publish,
    feature,
  };
}

export function purchaseLines(purchase: ListingPurchase): PurchaseLine[] {
  let lines: PurchaseLine[] = [];

  if (purchase.publish) {
    lines.push({
      name: `Job listing, ${config.hirepin.listingDays} days`,
      detail: `${purchase.title} at ${purchase.companyName}`,
      amount: config.hirepin.publishCents,
    });
  }

  if (purchase.feature) {
    lines.push({
      name: "Featured upgrade",
      detail: purchase.publish
        ? `Pinned to the top of the board for ${config.hirepin.listingDays} days`
        : `${purchase.title}, pinned to the top of the board`,
      amount: config.hirepin.featureCents,
    });
  }

  return lines;
}

export function purchaseTotal(purchase: ListingPurchase): number {
  return purchaseLines(purchase).reduce((sum, line) => sum + line.amount, 0);
}

/**
 * Returns the url to send the employer to: Stripe Checkout, or the in-app
 * test checkout when no Stripe key is set in development.
 */
export async function startListingCheckout(purchase: ListingPurchase): Promise<string> {
  if (testCheckout()) {
    return `/checkout/test/${purchase.editToken}${purchase.feature ? "?feature=1" : ""}`;
  }

  await ensureWebhook();

  let checkout = await stripe().checkout.sessions.create({
    mode: "payment",
    customer_email: purchase.employerEmail,
    client_reference_id: purchase.listingId,
    metadata: {
      listingId: purchase.listingId,
      publish: purchase.publish ? "1" : "0",
      feature: purchase.feature ? "1" : "0",
    },
    line_items: purchaseLines(purchase).map((line) => ({
      quantity: 1,
      price_data: {
        currency: "usd",
        unit_amount: line.amount,
        product_data: { name: line.name, description: line.detail },
      },
    })),
    success_url: `${getAppUrl()}/checkout/return?session_id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${getAppUrl()}/manage/${purchase.editToken}`,
  });

  return checkout.url!;
}

export interface Fulfillment {
  paid: boolean;
  listingId: string | null;
}

/**
 * Records a paid session. Idempotent: the return page and the webhook both
 * call it, in either order, any number of times.
 */
export async function fulfillCheckout(sessionId: string): Promise<Fulfillment> {
  let checkout = await stripe().checkout.sessions.retrieve(sessionId);
  let listingId = checkout.metadata?.listingId ?? checkout.client_reference_id ?? null;

  if (checkout.payment_status !== "paid" || !listingId) {
    return { paid: false, listingId };
  }

  recordPayment({
    sessionId: checkout.id,
    listingId,
    publish: checkout.metadata?.publish === "1",
    feature: checkout.metadata?.feature === "1",
    amountTotal: checkout.amount_total ?? 0,
    currency: checkout.currency ?? "usd",
  });

  return { paid: true, listingId };
}

export interface PaymentRecord {
  sessionId: string;
  listingId: string;
  publish: boolean;
  feature: boolean;
  amountTotal: number;
  currency: string;
}

/**
 * The one place a payment is recorded, real or test, and the one place what
 * was bought is granted. Only the call that inserts the payment row changes
 * the listing and sends the email, so repeats do nothing.
 */
export function recordPayment(payment: PaymentRecord): boolean {
  return tx(() => {
    let recorded = sql(`
      insert into payments (stripeSessionId, listingId, publish, feature, amountTotal, currency)
           values (${payment.sessionId}, ${payment.listingId}, ${payment.publish}, ${payment.feature},
                   ${payment.amountTotal}, ${payment.currency})
      on conflict (stripeSessionId) do nothing
        returning id
    `).first();

    if (!recorded) {
      return false;
    }

    let days = `${config.hirepin.listingDays} days`;

    if (payment.publish) {
      sql(`
        update listings
           set status = 'live',
               featured = featured or ${payment.feature},
               publishedAt = now(),
               expiresAt = now() + ${days}::interval,
               reminderSentAt = null
         where id = ${payment.listingId} and status in ('draft', 'expired')
      `);
    } else if (payment.feature) {
      sql(`update listings set featured = true where id = ${payment.listingId}`);
    }

    new SendListingEmailJob({
      listingId: payment.listingId,
      kind: payment.publish ? "live" : "featured",
      amountCents: payment.amountTotal,
    }).schedule();

    return true;
  });
}
