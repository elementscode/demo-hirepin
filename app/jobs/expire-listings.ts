import { Job, sql, tx } from "@elements/app";
import config from "#config";
import { SendListingEmailJob } from "#app/jobs/send-listing-email";

/**
 * Takes listings past their 30 days off the board, and warns employers a few
 * days before. Runs every few minutes from cron; both updates only touch rows
 * that still need it, so a missed or doubled run changes nothing.
 */
export class ExpireListingsJob extends Job {
  run() {
    tx(() => {
      let expired = sql<{ id: string }>(`
        update listings
           set status = 'expired'
         where status = 'live' and expiresAt <= now()
     returning id
      `).all();

      for (let row of expired) {
        new SendListingEmailJob({ listingId: row.id, kind: "expired" }).schedule();
      }

      let days = `${config.hirepin.reminderDays} days`;
      let expiring = sql<{ id: string }>(`
        update listings
           set reminderSentAt = now()
         where status = 'live'
           and reminderSentAt is null
           and expiresAt <= now() + ${days}::interval
     returning id
      `).all();

      for (let row of expiring) {
        new SendListingEmailJob({ listingId: row.id, kind: "reminder" }).schedule();
      }
    });
  }
}
