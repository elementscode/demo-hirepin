import { Request, Response } from "@elements/app";
import { unsubscribe } from "#app/shared/services/subscribers";
import html from "./template";

export default function route(req: Request, res: Response) {
  return new html({ email: unsubscribe(req.params.token) ?? "" });
}
