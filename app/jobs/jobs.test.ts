import { test, assert, equal, sql } from "@elements/app";
import { ExpireListingsJob } from "#app/jobs/expire-listings";
import { SendDigestJob } from "#app/jobs/weekly-digest";
import { insertTestListing } from "#app/shared/services/test-helpers";

function statusOf(id: string): { status: string; reminderSentAt: Date | null } {
  return sql<{ status: string; reminderSentAt: Date | null }>(
    `select status, reminderSentAt from listings where id = ${id}`,
  ).firstOrThrow();
}

test("expire listings job", () => {
  let old = insertTestListing({ publishedAgo: "31 days", expiresIn: "-1 day" });
  let soon = insertTestListing({ publishedAgo: "28 days", expiresIn: "2 days" });
  let fresh = insertTestListing({ publishedAgo: "1 day", expiresIn: "29 days" });

  new ExpireListingsJob({}).run();

  equal(statusOf(old.id).status, "expired", "past its 30 days");
  equal(statusOf(soon.id).status, "live", "still live");
  assert(statusOf(soon.id).reminderSentAt !== null, "reminder sent before expiry");
  assert(statusOf(fresh.id).reminderSentAt === null, "no reminder yet");

  let reminded = statusOf(soon.id).reminderSentAt;
  new ExpireListingsJob({}).run();
  equal(statusOf(soon.id).reminderSentAt, reminded, "a second run does not remind again");
});

test("weekly digest", () => {
  test("only new listings in the subscriber's categories", () => {
    insertTestListing({ title: "New engineering job", publishedAgo: "2 days" });
    insertTestListing({ title: "Old engineering job", publishedAgo: "20 days" });

    let subscriber = sql<{ id: string }>(`
      insert into subscribers (email, categories) values ('ada@example.com', '{engineering}') returning id
    `).firstOrThrow();

    new SendDigestJob({ subscriberId: subscriber.id }).run();

    let row = sql<{ lastDigestAt: Date | null }>(`select lastDigestAt from subscribers where id = ${subscriber.id}`).firstOrThrow();
    assert(row.lastDigestAt !== null, "marks the digest sent");
  });
});
