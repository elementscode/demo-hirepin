import { ForbiddenError, sql } from "@elements/app";
import { listingPurchase, purchaseTotal, recordPayment } from "#app/shared/checkout";
import { testCheckout } from "#app/shared/stripe";

/**
 * Pays on the test checkout. Development without a Stripe key only. Records
 * through the same recordPayment a Stripe payment uses, so the listing goes
 * live, the receipt email goes out and every open board updates.
 * @rpc
 */
export function payTestListing(token: string, feature: boolean): string {
  if (!testCheckout()) {
    throw new ForbiddenError("The test checkout is off.");
  }

  let purchase = listingPurchase(token, feature);
  let count = sql<{ n: number }>(`
    select count(*)::int as n
      from payments
     where listingId = ${purchase.listingId}
  `).firstOrThrow().n;

  recordPayment({
    sessionId: `test_${purchase.listingId}_${count + 1}`,
    listingId: purchase.listingId,
    publish: purchase.publish,
    feature: purchase.feature,
    amountTotal: purchaseTotal(purchase),
    currency: "usd",
  });

  return `/manage/${token}?paid=1`;
}
