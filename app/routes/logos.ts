import { Request, Response, sql } from "@elements/app";
import { isUuid } from "#app/shared/services/listings";

// svg is on the list for the seeded logos only: uploads accept raster types,
// and the sandbox policy below stops a hostile svg running script regardless.
const INLINE = new Set(["image/png", "image/jpeg", "image/gif", "image/webp", "image/svg+xml"]);

const YEAR = 31536000;

export default function serveLogo(req: Request, res: Response) {
  if (!isUuid(req.params.id)) {
    res.status(404);
    return res.end();
  }

  let logo = sql<{ contentType: string; hash: string; data: Buffer }>(
    `select contentType, hash, data from logos where id = ${req.params.id}`,
  ).firstOrThrow("logo not found");

  // The hash names the bytes. A stale one is a request for bytes that no
  // longer exist, so 404 rather than cache the new ones under the old key.
  if (req.params.hash !== logo.hash || !INLINE.has(logo.contentType)) {
    res.status(404);
    return res.end();
  }

  res.setHeader("Content-Type", logo.contentType);
  res.setHeader("Content-Security-Policy", "default-src 'none'; style-src 'unsafe-inline'; sandbox");
  res.setHeader("Cache-Control", `public, max-age=${YEAR}, immutable`);

  return logo.data;
}
