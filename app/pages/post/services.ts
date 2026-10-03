import { sql, tx } from "@elements/app";
import { ListingForm, saveLogo, validateListing } from "#app/shared/services/listings";
import { listingPurchase, startListingCheckout } from "#app/shared/checkout";
import { SendListingEmailJob } from "#app/jobs/send-listing-email";

export interface PostResult {
  /** Stripe Checkout, or the in-app test checkout when no Stripe key is set. */
  redirectTo: string;
}

/** @rpc */
export async function createListing(form: ListingForm, feature: boolean): Promise<PostResult> {
  validateListing(form);

  let listing = tx(() => {
    let logoId = form.logo ? saveLogo(form.logo) : null;

    let row = sql<{ id: string; editToken: string }>(`
      insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                            salaryMin, salaryMax, description, applyUrl, employerEmail)
           values (${form.companyName}, ${form.companyUrl}, ${logoId}, ${form.title}, ${form.category}, ${form.jobType}, ${form.location},
                   ${form.salaryMin * 1000}, ${form.salaryMax * 1000}, ${form.description}, ${form.applyUrl}, ${form.employerEmail})
        returning id, editToken
    `).firstOrThrow();

    // The edit link goes out now, so an employer who abandons checkout can
    // still come back and pay.
    new SendListingEmailJob({ listingId: row.id, kind: "draft" }).schedule();

    return row;
  });

  let url = await startListingCheckout(listingPurchase(listing.editToken, feature));

  return { redirectTo: url };
}
