import { test, assert, equal, sql, ValidationError } from "@elements/app";
import { subscribe, unsubscribe } from "#app/shared/services/subscribers";

test("subscribe", () => {
  test("saves the address and updates on a second subscribe", () => {
    let suffix = crypto.randomUUID().slice(0, 8);
    let email = `ada.${suffix}@hirepin.test`;
    subscribe({ email: ` Ada.${suffix}@HirePin.test `, categories: ["design"] });
    subscribe({ email, categories: ["design", "product"] });

    let rows = sql<{ email: string; categories: string[] }>(`
      select email, categories::text[] as categories from subscribers where lower(email) = ${email}
    `).all();
    equal(rows.length, 1);
    equal(rows[0].email, email);
    equal(rows[0].categories, ["design", "product"]);
  });

  test("needs an email and a category", () => {
    let threw = 0;

    for (let form of [{ email: "nope", categories: ["design" as const] }, { email: "a@b.co", categories: [] }]) {
      try {
        subscribe(form);
      } catch (err) {
        assert(err instanceof ValidationError, `got ${err}`);
        threw++;
      }
    }

    equal(threw, 2);
  });

  test("unsubscribe by token", () => {
    let email = `grace.${crypto.randomUUID().slice(0, 8)}@hirepin.test`;
    subscribe({ email, categories: ["engineering"] });
    let token = sql<{ token: string }>(`select token from subscribers where email = ${email}`).firstOrThrow().token;

    equal(unsubscribe(token), email);
    equal(unsubscribe(token), undefined);
  });
});
