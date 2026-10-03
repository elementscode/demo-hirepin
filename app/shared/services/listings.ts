import { File, LiveTable, ForbiddenError, NotFoundError, ValidationError, sql } from "@elements/app";
import config from "#config";

export type Category = "engineering" | "design" | "product" | "marketing";
export type JobType = "full-time" | "part-time" | "contract";
export type ListingStatus = "draft" | "live" | "expired" | "removed";
export type ListingEmailKind = "draft" | "live" | "featured" | "reminder" | "expired";

export const CATEGORIES: Category[] = ["engineering", "design", "product", "marketing"];
export const JOB_TYPES: JobType[] = ["full-time", "part-time", "contract"];

export const CATEGORY_LABELS: Record<Category, string> = {
  engineering: "Engineering",
  design: "Design",
  product: "Product",
  marketing: "Marketing",
};

export const JOB_TYPE_LABELS: Record<JobType, string> = {
  "full-time": "Full-time",
  "part-time": "Part-time",
  contract: "Contract",
};

/** A row on the board: everything the list shows, and not the description. */
export interface BoardListing {
  id: string;
  title: string;
  companyName: string;
  logoUrl: string | null;
  category: Category;
  jobType: JobType;
  location: string;
  salaryMin: number;
  salaryMax: number;
  featured: boolean;
  publishedAt: Date;
  expiresAt: Date;
}

export interface Listing extends Omit<BoardListing, "publishedAt" | "expiresAt"> {
  companyUrl: string;
  description: string;
  applyUrl: string;
  employerEmail: string;
  status: ListingStatus;
  publishedAt: Date | null;
  expiresAt: Date | null;
  createdAt: Date;
}

/** What the employer fills in. Salaries are in thousands of dollars a year. */
export interface ListingForm {
  companyName: string;
  companyUrl: string;
  title: string;
  category: Category;
  jobType: JobType;
  location: string;
  salaryMin: number;
  salaryMax: number;
  description: string;
  applyUrl: string;
  employerEmail: string;
  logo: File | null;
}

const LOGO_TYPES = new Set(["image/png", "image/jpeg", "image/gif", "image/webp"]);
const LOGO_MAX_BYTES = 1024 * 1024;


/**
 * The live board. Listings go live from the payment return page, the Stripe
 * webhook and the expiry job, so writes never go through this view: a trigger
 * on listings broadcasts them (see the schema migration).
 */
export let boardListings: LiveTable<BoardListing> = new LiveTable<BoardListing>({
  channel: (partition) => (partition ? `boardListings:${partition}` : "boardListings"),

  select: () => sql<BoardListing>(`
    select l.id, l.title, l.companyName, l.category, l.jobType, l.location,
           l.salaryMin, l.salaryMax, l.featured, l.publishedAt, l.expiresAt,
           case when g.id is null then null else '/logos/' || g.id || '/' || g.hash end as logoUrl
      from listings l
      left join logos g on g.id = l.logoId
     where l.status = 'live'
  `),

  insert: () => {
    throw new ForbiddenError();
  },

  update: () => {
    throw new ForbiddenError();
  },

  delete: () => {
    throw new ForbiddenError();
  },
});

export function getLiveListing(id: string): Listing {
  if (!isUuid(id)) {
    throw new NotFoundError("listing not found");
  }

  return sql<Listing>(`
    select l.id, l.title, l.companyName, l.companyUrl, l.category, l.jobType, l.location,
           l.salaryMin, l.salaryMax, l.featured, l.publishedAt, l.expiresAt, l.createdAt,
           l.description, l.applyUrl, l.employerEmail, l.status,
           case when g.id is null then null else '/logos/' || g.id || '/' || g.hash end as logoUrl
      from listings l
      left join logos g on g.id = l.logoId
     where l.id = ${id} and l.status = 'live'
  `).firstOrThrow("listing not found");
}

/** The employer's view of their listing, found by the token in their link. */
export function getListingByToken(token: string): Listing {
  return sql<Listing>(`
    select l.id, l.title, l.companyName, l.companyUrl, l.category, l.jobType, l.location,
           l.salaryMin, l.salaryMax, l.featured, l.publishedAt, l.expiresAt, l.createdAt,
           l.description, l.applyUrl, l.employerEmail, l.status,
           case when g.id is null then null else '/logos/' || g.id || '/' || g.hash end as logoUrl
      from listings l
      left join logos g on g.id = l.logoId
     where l.editToken = ${token} and l.status <> 'removed'
  `).firstOrThrow("listing not found");
}

export function getListingById(id: string): Listing {
  return sql<Listing>(`
    select l.id, l.title, l.companyName, l.companyUrl, l.category, l.jobType, l.location,
           l.salaryMin, l.salaryMax, l.featured, l.publishedAt, l.expiresAt, l.createdAt,
           l.description, l.applyUrl, l.employerEmail, l.status,
           case when g.id is null then null else '/logos/' || g.id || '/' || g.hash end as logoUrl
      from listings l
      left join logos g on g.id = l.logoId
     where l.id = ${id}
  `).firstOrThrow("listing not found");
}

export function isUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value);
}

function isUrl(value: string): boolean {
  return /^https?:\/\/[^\s.]+\.[^\s]+$/i.test(value);
}

function isEmail(value: string): boolean {
  return /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(value);
}

/** Trims the form in place and throws a per-field ValidationError. */
export function validateListing(form: ListingForm) {
  form.companyName = form.companyName.trim();
  form.companyUrl = form.companyUrl.trim();
  form.title = form.title.trim();
  form.location = form.location.trim();
  form.description = form.description.trim();
  form.applyUrl = form.applyUrl.trim();
  form.employerEmail = form.employerEmail.trim().toLowerCase();

  let errors: Partial<Record<keyof ListingForm, string[]>> = {};

  if (!form.companyName) {
    errors.companyName = ["Enter the company name."];
  }

  if (form.companyUrl && !isUrl(form.companyUrl)) {
    errors.companyUrl = ["Enter a full url, starting with https://."];
  }

  if (!form.title) {
    errors.title = ["Enter the job title."];
  }

  if (!CATEGORIES.includes(form.category)) {
    errors.category = ["Pick a category."];
  }

  if (!JOB_TYPES.includes(form.jobType)) {
    errors.jobType = ["Pick a job type."];
  }

  if (!form.location) {
    errors.location = ["Say where the role can be done from."];
  }

  if (!(form.salaryMin > 0) || !(form.salaryMax > 0)) {
    errors.salaryMin = ["Enter both ends of the salary range."];
  } else if (form.salaryMax < form.salaryMin) {
    errors.salaryMin = ["The top of the range is below the bottom."];
  } else if (form.salaryMax > 1000) {
    errors.salaryMin = ["Salaries are in thousands: 120 for $120k."];
  }

  if (form.description.length < 50) {
    errors.description = ["Write at least a few sentences about the role."];
  }

  if (!isUrl(form.applyUrl) && !form.applyUrl.startsWith("mailto:")) {
    errors.applyUrl = ["Enter a url starting with https://, or a mailto: address."];
  }

  if (!isEmail(form.employerEmail)) {
    errors.employerEmail = ["Enter the email we should send your edit link to."];
  }

  if (form.logo) {
    if (!LOGO_TYPES.has(form.logo.contentType)) {
      errors.logo = ["Upload a png, jpg, gif or webp image."];
    } else if (form.logo.size > LOGO_MAX_BYTES) {
      errors.logo = ["Keep the logo under 1 MB."];
    }
  }

  if (Object.keys(errors).length > 0) {
    throw new ValidationError(errors);
  }
}

export function saveLogo(logo: File): string {
  return sql<{ id: string }>(`
    insert into logos (name, contentType, data)
         values (${logo.name}, ${logo.contentType}, ${logo.data})
      returning id
  `).firstOrThrow().id;
}

export function listingDays(): number {
  return config.hirepin.listingDays;
}
