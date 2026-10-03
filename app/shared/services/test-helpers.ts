import { sql } from "@elements/app";

export interface TestListing {
  id: string;
  editToken: string;
}

/** Inserts a listing for a test. Tests roll back, so nothing needs cleaning up. */
export function insertTestListing(overrides: { status?: string; expiresIn?: string; publishedAgo?: string; title?: string } = {}): TestListing {
  let status = overrides.status ?? "live";
  let published = status === "draft" ? null : overrides.publishedAgo ?? "1 day";
  let expiresIn = overrides.expiresIn ?? "29 days";

  return sql<TestListing>(`
    insert into listings (companyName, title, category, jobType, location, salaryMin, salaryMax,
                          description, applyUrl, employerEmail, status, publishedAt, expiresAt)
         values ('Testco', ${overrides.title ?? "Test Engineer"}, 'engineering', 'full-time', 'Remote', 100000, 120000,
                 'A description long enough to pass validation, about the role and the team.',
                 'https://testco.example/apply', 'jobs@testco.example', ${status}::listingStatus,
                 case when ${published}::text is null then null else now() - ${published}::interval end,
                 case when ${published}::text is null then null else now() + ${expiresIn}::interval end)
      returning id, editToken
  `).firstOrThrow();
}
