import { Request, Response } from "@elements/app";
import { getLiveListing } from "#app/shared/services/listings";
import { currentUserIsAdmin } from "#app/shared/services/admin";
import { renderMarkdown } from "#app/shared/markdown";
import html from "./template";

export default function route(req: Request, res: Response) {
  let listing = getLiveListing(req.params.id);

  return new html({
    listing,
    body: renderMarkdown(listing.description),
    isAdmin: currentUserIsAdmin(),
  });
}
