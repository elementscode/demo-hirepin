import { ValidationError, sql } from "@elements/app";
import { CATEGORIES, Category } from "#app/shared/services/listings";

export interface SubscribeForm {
  email: string;
  categories: Category[];
}

/** @rpc */
export function subscribe(form: SubscribeForm) {
  let address = form.email.trim().toLowerCase();
  let categories = form.categories.filter((c) => CATEGORIES.includes(c));

  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(address)) {
    throw new ValidationError({ email: ["Enter a valid email address."] });
  }

  if (categories.length === 0) {
    throw new ValidationError({ categories: ["Pick at least one category."] });
  }

  // Subscribing again with the same address updates the categories.
  sql(`
    insert into subscribers (email, categories)
         values (${address}, ${categories}::listingCategory[])
    on conflict (email) do update set categories = excluded.categories
  `);
}

export function unsubscribe(token: string): string | undefined {
  return sql<{ email: string }>(`delete from subscribers where token = ${token} returning email`).first()?.email;
}
