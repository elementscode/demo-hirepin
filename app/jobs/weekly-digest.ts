import { Job, email, sql } from "@elements/app";
import DigestEmail, { DigestJob } from "#app/emails/digest";
import type { Category } from "#app/shared/services/listings";

/** Fans the weekly email out into one job per subscriber. */
export class WeeklyDigestJob extends Job {
  run() {
    let subscribers = sql<{ id: string }>(`select id from subscribers`).all();
    let week = new Date().toISOString().slice(0, 10);

    for (let s of subscribers) {
      new SendDigestJob({ subscriberId: s.id }).schedule({ idempotencyKey: `digest:${s.id}:${week}` });
    }
  }
}

export interface SendDigestJobFields {
  subscriberId: string;
}

export class SendDigestJob extends Job<SendDigestJobFields> {
  static maxAttempts = 3;

  run() {
    let subscriber = sql<{ email: string; categories: Category[]; token: string; since: Date }>(`
      select email, categories::text[] as categories, token,
             greatest(coalesce(lastDigestAt, now() - interval '7 days'), now() - interval '7 days') as since
        from subscribers
       where id = ${this.fields.subscriberId}
    `).first();

    if (!subscriber) {
      return;
    }

    let jobs = sql<DigestJob>(`
      select id, title, companyName, category, location, salaryMin, salaryMax
        from listings
       where status = 'live'
         and publishedAt > ${subscriber.since}
         and category::text = any(${subscriber.categories})
       order by featured desc, publishedAt desc
       limit 30
    `).all();

    if (jobs.length > 0) {
      email({
        to: subscriber.email,
        subject: `${jobs.length} new remote ${jobs.length === 1 ? "job" : "jobs"} on hirepin`,
        body: new DigestEmail({ jobs, categories: subscriber.categories, token: subscriber.token }),
      });
    }

    sql(`update subscribers set lastDigestAt = now() where id = ${this.fields.subscriberId}`);
  }
}
