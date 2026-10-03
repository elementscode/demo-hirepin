import { test, assert, equal, session, sql, AuthError } from "@elements/app";
import { signin } from "#app/shared/services/auth";

test("signin", () => {
  sql(`insert into users (email, passwordHash, role) values ('admin@example.com', crypt('right-password', genSalt('bf', 4)), 'admin')`);

  test("the right password signs in", () => {
    signin(" Admin@Example.com ", "right-password");
    assert(session.isLoggedIn());
    equal(session.get("userName"), "admin@example.com");
  });

  test("a wrong password does not say which part was wrong", () => {
    try {
      signin("admin@example.com", "wrong");
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof AuthError, `got ${err}`);
      equal((err as Error).message, "invalid email or password");
    }
  });
});
