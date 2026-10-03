import { sql } from "@elements/app";
import { isUserAdminOrThrow } from "#app/shared/services/admin";
import type { Category, ListingStatus } from "#app/shared/services/listings";

export interface AdminListing {
  id: string;
  title: string;
  companyName: string;
  employerEmail: string;
  category: Category;
  status: ListingStatus;
  featured: boolean;
  createdAt: Date;
  publishedAt: Date | null;
  expiresAt: Date | null;
  editToken: string;
  paidCents: number;
}

export interface AdminStats {
  live: number;
  featured: number;
  drafts: number;
  revenueCents: number;
  subscribers: number;
}

export function listAllListings(): AdminListing[] {
  return sql<AdminListing>(`
    select l.id, l.title, l.companyName, l.employerEmail, l.category, l.status, l.featured,
           l.createdAt, l.publishedAt, l.expiresAt, l.editToken,
           coalesce((select sum(p.amountTotal) from payments p where p.listingId = l.id), 0)::int as paidCents
      from listings l
     order by l.createdAt desc
  `).all();
}

export function adminStats(): AdminStats {
  return sql<AdminStats>(`
    select (select count(*) from listings where status = 'live')::int as live,
           (select count(*) from listings where status = 'live' and featured)::int as featured,
           (select count(*) from listings where status = 'draft')::int as drafts,
           (select coalesce(sum(amountTotal), 0) from payments)::int as revenueCents,
           (select count(*) from subscribers)::int as subscribers
  `).firstOrThrow();
}

/** @rpc */
export function removeListing(id: string): AdminListing[] {
  isUserAdminOrThrow();

  sql(`update listings set status = 'removed' where id = ${id}`);

  return listAllListings();
}

/**
 * Puts a removed listing back where it would have been: live if its paid time
 * has not run out, expired if it has, and a draft if it was never paid for.
 * @rpc
 */
export function restoreListing(id: string): AdminListing[] {
  isUserAdminOrThrow();

  sql(`
    update listings
       set status = case
             when publishedAt is null then 'draft'::listingStatus
             when expiresAt > now() then 'live'::listingStatus
             else 'expired'::listingStatus
           end
     where id = ${id} and status = 'removed'
  `);

  return listAllListings();
}
