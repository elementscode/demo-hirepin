import { test, assert, equal, session, sql, AuthError, ForbiddenError } from "@elements/app";
import { removeListing, restoreListing } from "./services";
import { insertTestListing } from "#app/shared/services/test-helpers";

function makeUser(role: "user" | "admin"): string {
  return sql<{ id: string }>(`
    insert into users (email, passwordHash, role)
         values (${`${role}.${crypto.randomUUID().slice(0, 8)}@example.com`}, crypt('password', genSalt('bf', 4)), ${role}::userRole)
      returning id
  `).firstOrThrow().id;
}

function statusOf(id: string): string {
  return sql<{ status: string }>(`select status from listings where id = ${id}`).firstOrThrow().status;
}

test("admin", () => {
  test("signed out cannot remove", () => {
    let listing = insertTestListing();

    try {
      removeListing(listing.id);
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof AuthError, `got ${err}`);
    }

    equal(statusOf(listing.id), "live");
  });

  test("a non-admin cannot remove", () => {
    let listing = insertTestListing();
    session.login({ userId: makeUser("user"), userName: "user" });

    try {
      removeListing(listing.id);
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof ForbiddenError, `got ${err}`);
    }
  });

  test("an admin removes and restores", () => {
    let live = insertTestListing();
    let lapsed = insertTestListing({ publishedAgo: "40 days", expiresIn: "-10 days" });
    session.login({ userId: makeUser("admin"), userName: "admin" });

    removeListing(live.id);
    removeListing(lapsed.id);
    equal(statusOf(live.id), "removed");

    restoreListing(live.id);
    restoreListing(lapsed.id);
    equal(statusOf(live.id), "live", "time left, back on the board");
    equal(statusOf(lapsed.id), "expired", "time ran out while removed");
  });
});
