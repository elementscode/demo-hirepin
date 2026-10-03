import { Request, Response, redirect, session } from "@elements/app";
import { isUserAdminOrThrow } from "#app/shared/services/admin";
import { adminStats, listAllListings } from "./services";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (!session.isLoggedIn()) {
    redirect("/signin");
    return;
  }

  isUserAdminOrThrow();

  return new html({
    initial: listAllListings(),
    stats: adminStats(),
    query: String(req.query.q ?? ""),
  });
}
