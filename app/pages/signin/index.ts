import { Request, Response, getEnv, redirect, session } from "@elements/app";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (session.isLoggedIn()) {
    redirect("/admin");
    return;
  }

  // The demo admin is seeded in development only, so that is the only place
  // its login is shown.
  return new html({ showDemoLogin: getEnv() === "development" });
}
