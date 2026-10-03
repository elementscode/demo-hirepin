import { test, assert, equal, session, sql, AuthError } from "@elements/app";
import { signin } from "#app/shared/services/auth";

test("signin", () => {
  let suffix = crypto.randomUUID().slice(0, 8);
  let email = `admin.${suffix}@example.com`;
  sql(`insert into users (email, passwordHash, role) values (${email}, crypt('right-password', genSalt('bf', 4)), 'admin')`);

  test("the right password signs in", () => {
    signin(` Admin.${suffix}@Example.com `, "right-password");
    assert(session.isLoggedIn());
    equal(session.get("userName"), email);
  });

  test("a wrong password does not say which part was wrong", () => {
    try {
      signin(email, "wrong");
      assert(false, "should have thrown");
    } catch (err) {
      assert(err instanceof AuthError, `got ${err}`);
      equal((err as Error).message, "invalid email or password");
    }
  });
});
