-- add hirepin schema

-- Auto-update updatedAt on row changes.
create or replace function touchUpdatedAt()
returns trigger
language plpgsql
as $$
begin
  new.updatedAt = now();
  return new;
end;
$$;

create type userRole as enum ('user', 'admin');

create table users (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  email text not null unique,
  passwordHash text not null,
  role userRole not null default 'user'
);

create trigger usersTouchUpdatedAt
  before update on users
  for each row execute function touchUpdatedAt();

create table logos (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  name text not null,
  contentType text not null,
  data bytea not null,

  -- The cache key in the logo's url, recomputed whenever the bytes change.
  hash text generated always as (encode(sha256(data), 'hex')) stored
);

create trigger logosTouchUpdatedAt
  before update on logos
  for each row execute function touchUpdatedAt();

create type listingCategory as enum ('engineering', 'design', 'product', 'marketing');
create type listingJobType as enum ('full-time', 'part-time', 'contract');

-- draft is posted but unpaid; live is paid and on the board until expiresAt.
create type listingStatus as enum ('draft', 'live', 'expired', 'removed');

create table listings (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  companyName text not null,
  companyUrl text not null default '',
  logoId uuid references logos (id) on delete set null,
  title text not null,
  category listingCategory not null,
  jobType listingJobType not null default 'full-time',
  location text not null default 'Remote, worldwide',
  salaryMin integer not null check (salaryMin >= 0),
  salaryMax integer not null check (salaryMax >= salaryMin),
  description text not null,
  applyUrl text not null,
  employerEmail text not null,

  -- The employer has no account: this token in the emailed link is the key.
  editToken text not null unique default encode(gen_random_bytes(24), 'hex'),
  status listingStatus not null default 'draft',
  featured boolean not null default false,
  publishedAt timestamptz,
  expiresAt timestamptz,
  reminderSentAt timestamptz,
  removedReason text not null default ''
);

create index listingsStatusIdx on listings (status, expiresAt);
create index listingsPublishedAtIdx on listings (publishedAt desc);

create trigger listingsTouchUpdatedAt
  before update on listings
  for each row execute function touchUpdatedAt();

create table payments (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  stripeSessionId text not null unique,
  listingId uuid not null references listings (id) on delete cascade,
  publish boolean not null,
  feature boolean not null,
  amountTotal integer not null,
  currency text not null
);

create trigger paymentsTouchUpdatedAt
  before update on payments
  for each row execute function touchUpdatedAt();

create table subscribers (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  email text not null unique,
  categories listingCategory[] not null,
  token text not null unique default encode(gen_random_bytes(24), 'hex'),
  lastDigestAt timestamptz
);

create trigger subscribersTouchUpdatedAt
  before update on subscribers
  for each row execute function touchUpdatedAt();

-- One row per url the app has served from, written the first time a buyer
-- starts a checkout in production. Stripe returns an endpoint's signing
-- secret only when it is created, so the app keeps it here.
create table stripeWebhooks (
  url text primary key,
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  endpointId text not null,
  secret text not null
);

create trigger stripeWebhooksTouchUpdatedAt
  before update on stripeWebhooks
  for each row execute function touchUpdatedAt();

-- The board is a LiveTable over live listings. Listings go live from the
-- Stripe return page, the webhook and the expiry job, none of which write
-- through the view, so the write itself broadcasts. A listing entering the
-- board is an insert to the browser and one leaving it is a delete.
create or replace function boardListingsNotify() returns trigger
language plpgsql as $$
declare
  wasLive boolean := tg_op <> 'INSERT' and old.status = 'live';
  isLive boolean := tg_op <> 'DELETE' and new.status = 'live';
  r record;
  op text;
  payload text;
begin
  if isLive and wasLive then
    op := 'update';
    r := new;
  elsif isLive then
    op := 'insert';
    r := new;
  elsif wasLive then
    op := 'delete';
    r := old;
  else
    return null;
  end if;

  payload := json_build_object(
    'op', op,
    'data', json_build_object(
      'id', r.id,
      'title', r.title,
      'companyName', r.companyName,
      'logoUrl', (select '/logos/' || l.id || '/' || l.hash from logos l where l.id = r.logoId),
      'category', r.category,
      'jobType', r.jobType,
      'location', r.location,
      'salaryMin', r.salaryMin,
      'salaryMax', r.salaryMax,
      'featured', r.featured,
      'publishedAt', json_build_object('$type', 'Date', '$value', (extract(epoch from r.publishedAt) * 1000)::bigint),
      'expiresAt', json_build_object('$type', 'Date', '$value', (extract(epoch from r.expiresAt) * 1000)::bigint)
    )
  )::text;

  if octet_length(payload) >= 8000 then
    payload := json_build_object('op', op, 'id', r.id)::text;
  end if;

  perform pg_notify(channel_name('listings'), payload);

  return null;
end;
$$;

create trigger boardListingsNotifyTrigger
  after insert or update or delete on listings
  for each row execute function boardListingsNotify();
