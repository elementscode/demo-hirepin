import { Request, Response } from "@elements/app";
import { boardListings } from "#app/shared/services/listings";
import { currentUserIsAdmin } from "#app/shared/services/admin";
import html from "./template";

export default function route(req: Request, res: Response) {
  return new html({
    listings: boardListings.view(),
    isAdmin: currentUserIsAdmin(),
  });
}
