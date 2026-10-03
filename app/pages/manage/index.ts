import { Request, Response } from "@elements/app";
import { getListingByToken } from "#app/shared/services/listings";
import { currentUserIsAdmin } from "#app/shared/services/admin";
import html from "./template";

export default function route(req: Request, res: Response) {
  return new html({
    token: req.params.token,
    initial: getListingByToken(req.params.token),
    justPaid: req.query.paid === "1",
    isAdmin: currentUserIsAdmin(),
  });
}
