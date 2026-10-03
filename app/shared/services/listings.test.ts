import { test, assert, equal, sql, ValidationError } from "@elements/app";
import { ListingForm, boardListings, getListingByToken, getLiveListing, validateListing } from "#app/shared/services/listings";
import { renderMarkdown } from "#app/shared/markdown";
import { formatSalary } from "#app/shared/format";
import { insertTestListing } from "#app/shared/services/test-helpers";

function goodForm(): ListingForm {
  return {
    companyName: " Testco ",
    companyUrl: "https://testco.example",
    title: "Backend Engineer",
    category: "engineering",
    jobType: "full-time",
    location: "Remote, worldwide",
    salaryMin: 100,
    salaryMax: 130,
    description: "We are hiring a backend engineer to own our ingest pipeline end to end.",
    applyUrl: "https://testco.example/apply",
    employerEmail: "Jobs@Testco.example",
    logo: null,
  };
}

function errorsOf(form: ListingForm): Record<string, string[]> {
  try {
    validateListing(form);
  } catch (err) {
    assert(err instanceof ValidationError, `got ${err}`);

    return (err as ValidationError).errors as Record<string, string[]>;
  }

  return {};
}

test("listings", () => {
  test("a valid form passes and is trimmed", () => {
    let form = goodForm();
    equal(errorsOf(form), {});
    equal(form.companyName, "Testco");
    equal(form.employerEmail, "jobs@testco.example");
  });

  test("each bad field gets its own error", () => {
    let form = goodForm();
    form.title = "";
    form.salaryMin = 200;
    form.applyUrl = "javascript:alert(1)";
    form.employerEmail = "nope";

    let errors = errorsOf(form);
    assert(errors.title !== undefined, "title");
    assert(errors.salaryMin !== undefined, "salary range");
    assert(errors.applyUrl !== undefined, "apply url");
    assert(errors.employerEmail !== undefined, "email");
    assert(errors.companyName === undefined, "company name was fine");
  });

  test("salaries are in thousands", () => {
    let form = goodForm();
    form.salaryMin = 100000;
    form.salaryMax = 120000;
    assert(errorsOf(form).salaryMin !== undefined);
  });

  test("the board holds live listings only", () => {
    let live = insertTestListing();
    let draft = insertTestListing({ status: "draft" });
    let view = boardListings.view();
    let ids = [...view].map((row) => row.id);

    assert(ids.includes(live.id), "live listing on the board");
    assert(!ids.includes(draft.id), "draft kept off the board");
  });

  test("a draft's job page is a 404 but its manage link works", () => {
    let draft = insertTestListing({ status: "draft" });
    let threw = false;

    try {
      getLiveListing(draft.id);
    } catch {
      threw = true;
    }

    assert(threw, "draft is not public");
    equal(getListingByToken(draft.editToken).id, draft.id);
  });

  test("a removed listing's manage link stops working", () => {
    let listing = insertTestListing();
    sql(`update listings set status = 'removed' where id = ${listing.id}`);

    let threw = false;
    try {
      getListingByToken(listing.editToken);
    } catch {
      threw = true;
    }

    assert(threw);
  });
});

test("markdown", () => {
  test("renders formatting", () => {
    let html = renderMarkdown("## Hi\n\n**bold** and [a link](https://example.com)");
    assert(html.includes("<h2>Hi</h2>"), html);
    assert(html.includes("<strong>bold</strong>"), html);
    assert(html.includes(`href="https://example.com"`), html);
  });

  test("escapes raw html and drops unsafe links", () => {
    let html = renderMarkdown(`<script>alert(1)</script>\n\n<img src=x onerror=alert(1)>\n\n[x](javascript:alert(1))`);
    assert(!html.includes("<script"), html);
    assert(!html.includes("<img"), html);
    assert(!html.includes("javascript:"), html);
  });
});

test("format", () => {
  equal(formatSalary(120000, 150000), "$120k – $150k");
  equal(formatSalary(90000, 90000), "$90k");
});
