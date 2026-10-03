import { NotFoundError, Request, Response, ValidationError, redirect } from "@elements/app";
import { listingPurchase, purchaseLines, purchaseTotal } from "#app/shared/checkout";
import { testCheckout } from "#app/shared/stripe";
import html from "./template";

/** Stands in for Stripe's hosted checkout in development, until a key is set. */
export default function route(req: Request, res: Response) {
  if (!testCheckout()) {
    throw new NotFoundError();
  }

  let token = req.params.token;
  let purchase;

  try {
    purchase = listingPurchase(token, req.query.feature === "1");
  } catch (err) {
    if (err instanceof ValidationError) {
      // Nothing left to buy, for example after a second tab already paid.
      redirect(`/manage/${token}`);
      return;
    }

    throw err;
  }

  return new html({
    purchase,
    lines: purchaseLines(purchase),
    total: purchaseTotal(purchase),
  });
}
