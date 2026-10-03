import { test, assert, equal, sql, NotFoundError, ValidationError } from "@elements/app";
import { payForListing, updateListing } from "./services";
import { getListingByToken, ListingForm } from "#app/shared/services/listings";
import { insertTestListing } from "#app/shared/services/test-helpers";

function formFrom(token: string): ListingForm {
  let l = getListingByToken(token);

  return {
    companyName: l.companyName,
    companyUrl: l.companyUrl,
    title: l.title,
    category: l.category,
    jobType: l.jobType,
    location: l.location,
    salaryMin: l.salaryMin / 1000,
    salaryMax: l.salaryMax / 1000,
    description: l.description,
    applyUrl: l.applyUrl,
    employerEmail: l.employerEmail,
    logo: null,
  };
}

test("manage", () => {
  test("the edit link updates the listing", () => {
    let listing = insertTestListing();
    let form = formFrom(listing.editToken);
    form.title = "Staff Engineer";
    form.salaryMax = 190;
    form.employerEmail = "attacker@example.com";

    let saved = updateListing(listing.editToken, form);
    equal(saved.title, "Staff Engineer");
    equal(saved.salaryMax, 190000);
    equal(saved.employerEmail, "jobs@testco.example", "email is not editable from the link");
  });

  test("a wrong token finds nothing", () => {
    let listing = insertTestListing();

    try {
      updateListing("not-a-token", formFrom(listing.editToken));
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof NotFoundError, `got ${err}`);
    }
  });

  test("a live featured listing has nothing left to buy", async () => {
    let listing = insertTestListing();
    sql(`update listings set featured = true where id = ${listing.id}`);

    try {
      await payForListing(listing.editToken, true);
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof ValidationError, `got ${err}`);
    }
  });
});
