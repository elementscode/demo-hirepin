import { test, assert, equal, sql, ValidationError } from "@elements/app";
import { createListing } from "#app/pages/post/services";
import { payForListing } from "#app/pages/manage/services";
import { payTestListing } from "./services";
import { testCheckout } from "#app/shared/stripe";
import { insertTestListing } from "#app/shared/services/test-helpers";
import { blankListingForm } from "#app/shared/templates/listing-fields";
import config from "#config";

interface ListingRow {
  id: string;
  status: string;
  featured: boolean;
  expiresAt: Date | null;
}

function listingByToken(token: string): ListingRow {
  return sql<ListingRow>(`
    select id, status, featured, expiresAt
      from listings
     where editToken = ${token}
  `).firstOrThrow();
}

function paymentsFor(listingId: string): { amountTotal: number; publish: boolean; feature: boolean; stripeSessionId: string }[] {
  return sql<{ amountTotal: number; publish: boolean; feature: boolean; stripeSessionId: string }>(`
    select amountTotal, publish, feature, stripeSessionId
      from payments
     where listingId = ${listingId}
     order by createdAt
  `).all();
}

function emailJobsFor(listingId: string, kind: string): number {
  return sql<{ n: number }>(`
    select count(*)::int as n
      from elements.jobs
     where fields->>'listingId' = ${listingId}
       and fields->>'kind' = ${kind}
  `).firstOrThrow().n;
}

function tokenFrom(url: string): string {
  return url.replace(/^\/checkout\/test\//, "").replace(/\?.*$/, "");
}

test("test checkout", () => {
  // Tests build with the development env. With a Stripe key in it, the pay
  // buttons go to real Stripe Checkout and the test checkout is off, so
  // these would create real sandbox sessions instead.
  if (!testCheckout()) {
    return;
  }

  test("posting a featured job pays through the test checkout and goes live", async () => {
    let form = blankListingForm();
    form.companyName = "Testco";
    form.title = "Platform Engineer";
    form.category = "engineering";
    form.salaryMin = 120;
    form.salaryMax = 150;
    form.description = "A description long enough to pass validation, about the role and the team.";
    form.applyUrl = "https://testco.example/apply";
    form.employerEmail = "jobs@testco.example";

    let result = await createListing(form, true);
    assert(result.redirectTo.startsWith("/checkout/test/"), `went to ${result.redirectTo}`);
    assert(result.redirectTo.endsWith("?feature=1"), "carries the feature choice");

    let token = tokenFrom(result.redirectTo);
    equal(listingByToken(token).status, "draft", "unpaid until Pay");

    let back = payTestListing(token, true);
    equal(back, `/manage/${token}?paid=1`);

    let listing = listingByToken(token);
    equal(listing.status, "live");
    equal(listing.featured, true);
    assert(listing.expiresAt !== null, "expiry set");

    let payments = paymentsFor(listing.id);
    equal(payments.length, 1);
    equal(payments[0].amountTotal, config.hirepin.publishCents + config.hirepin.featureCents);
    assert(payments[0].stripeSessionId.startsWith("test_"), "marked as a test session");
    equal(emailJobsFor(listing.id, "live"), 1, "receipt email scheduled");
  });

  test("a live listing buys only the feature", async () => {
    let listing = insertTestListing();

    let url = await payForListing(listing.editToken, true);
    equal(url, `/checkout/test/${listing.editToken}?feature=1`);

    payTestListing(listing.editToken, true);

    let row = listingByToken(listing.editToken);
    equal(row.featured, true);

    let payments = paymentsFor(listing.id);
    equal(payments.length, 1);
    equal(payments[0].amountTotal, config.hirepin.featureCents);
    equal(payments[0].publish, false);
    equal(emailJobsFor(listing.id, "featured"), 1, "featured email scheduled");
  });

  test("paying twice is refused once nothing is left to buy", () => {
    let listing = insertTestListing({ status: "draft" });
    payTestListing(listing.editToken, false);

    try {
      payTestListing(listing.editToken, false);
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof ValidationError, `got ${err}`);
    }

    equal(paymentsFor(listing.id).length, 1, "one payment");
  });

  test("an expired listing renews for another term", () => {
    let listing = insertTestListing({ publishedAgo: "40 days", expiresIn: "-10 days" });
    sql(`update listings set status = 'expired' where id = ${listing.id}`);
    payTestListing(listing.editToken, false);

    let row = listingByToken(listing.editToken);
    equal(row.status, "live");
    assert(+row.expiresAt! > Date.now() + 29 * 86400000, "a fresh 30 days");
  });
});
