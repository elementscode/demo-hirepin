import { test, assert, equal, sql, ValidationError } from "@elements/app";
import { subscribe, unsubscribe } from "#app/shared/services/subscribers";

test("subscribe", () => {
  test("saves the address and updates on a second subscribe", () => {
    subscribe({ email: " Ada@Example.com ", categories: ["design"] });
    subscribe({ email: "ada@example.com", categories: ["design", "product"] });

    let rows = sql<{ email: string; categories: string[] }>(`select email, categories::text[] as categories from subscribers`).all();
    equal(rows.length, 1);
    equal(rows[0].email, "ada@example.com");
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
    subscribe({ email: "grace@example.com", categories: ["engineering"] });
    let token = sql<{ token: string }>(`select token from subscribers`).firstOrThrow().token;

    equal(unsubscribe(token), "grace@example.com");
    equal(unsubscribe(token), undefined);
  });
});
