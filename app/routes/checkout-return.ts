import { Request, Response, redirect, sql } from "@elements/app";
import { fulfillCheckout } from "#app/shared/checkout";

/** Stripe sends the buyer here after checkout. Record it, then show the listing. */
export default async function checkoutReturn(req: Request, res: Response) {
  let result = await fulfillCheckout(String(req.query.session_id ?? ""));

  let listing = result.listingId
    ? sql<{ editToken: string }>(`select editToken from listings where id = ${result.listingId}`).first()
    : undefined;

  if (!listing) {
    redirect("/");
    return;
  }

  redirect(`/manage/${listing.editToken}?paid=1`);
}
