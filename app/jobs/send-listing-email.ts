import { Job, email, sql } from "@elements/app";
import ListingEmail from "#app/emails/listing";
import type { ListingEmailKind } from "#app/shared/services/listings";

export interface SendListingEmailJobFields {
  listingId: string;
  kind: ListingEmailKind;
  amountCents?: number;
}

const SUBJECTS: Record<ListingEmailKind, (title: string) => string> = {
  draft: (title) => `Your hirepin listing is saved: ${title}`,
  live: (title) => `Your listing is live: ${title}`,
  featured: (title) => `Your listing is featured: ${title}`,
  reminder: (title) => `Your listing expires soon: ${title}`,
  expired: (title) => `Your listing has expired: ${title}`,
};

export class SendListingEmailJob extends Job<SendListingEmailJobFields> {
  static maxAttempts = 5;

  run() {
    let { listingId, kind, amountCents }: SendListingEmailJobFields = this.fields;

    let listing = sql<{
      title: string;
      companyName: string;
      editToken: string;
      employerEmail: string;
      expiresAt: Date | null;
    }>(`
      select title, companyName, editToken, employerEmail, expiresAt
        from listings
       where id = ${listingId}
    `).first();

    if (!listing) {
      return;
    }

    email({
      to: listing.employerEmail,
      subject: SUBJECTS[kind](listing.title),
      body: new ListingEmail({
        data: {
          kind,
          title: listing.title,
          companyName: listing.companyName,
          editToken: listing.editToken,
          listingId,
          expiresAt: listing.expiresAt,
          amountCents: amountCents ?? 0,
        },
      }),
    });
  }
}
