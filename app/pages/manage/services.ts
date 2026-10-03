import { sql, tx } from "@elements/app";
import {
  Listing,
  ListingForm,
  getListingByToken,
  saveLogo,
  validateListing,
} from "#app/shared/services/listings";
import { listingPurchase, startListingCheckout } from "#app/shared/checkout";

/** @rpc */
export function updateListing(token: string, form: ListingForm): Listing {
  let listing = getListingByToken(token);

  // The email is where the edit link lives; it is not editable from the link.
  form.employerEmail = listing.employerEmail;
  validateListing(form);

  tx(() => {
    let logoId = form.logo ? saveLogo(form.logo) : null;

    sql(`
      update listings
         set companyName = ${form.companyName},
             companyUrl = ${form.companyUrl},
             logoId = coalesce(${logoId}::uuid, logoId),
             title = ${form.title},
             category = ${form.category},
             jobType = ${form.jobType},
             location = ${form.location},
             salaryMin = ${form.salaryMin * 1000},
             salaryMax = ${form.salaryMax * 1000},
             description = ${form.description},
             applyUrl = ${form.applyUrl}
       where editToken = ${token}
    `);
  });

  return getListingByToken(token);
}

/**
 * Starts checkout for whatever the listing can buy right now: a draft or an
 * expired listing publishes (and may add the feature), a live one can only
 * add the feature.
 * @rpc
 */
export async function payForListing(token: string, feature: boolean): Promise<string> {
  return await startListingCheckout(listingPurchase(token, feature));
}
