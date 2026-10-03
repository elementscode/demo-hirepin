-- demo rows: the admin, company logos and the listings on the board

insert into users (email, passwordHash, role)
     values ('admin@hirepin.dev', crypt('hirepin-admin', genSalt('bf', 12)), 'admin');

insert into logos (name, contentType, data)
     values ('northwind-labs.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#1f6feb"/><path d="M22 38h36a10 10 0 1 0-10-10M22 50h48a10 10 0 1 1-10 10M22 62h24" fill="none" stroke="#ffffff" stroke-width="7" stroke-linecap="round"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('quillfeather.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#7c3aed"/><path d="M68 22C44 26 30 44 28 70l6-4c4-14 12-24 24-30-10 8-16 16-20 26 18-4 28-20 30-40z" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('tidepool-analytics.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#0891b2"/><path d="M18 44c8-8 16-8 24 0s16 8 24 0 12-6 12-6M18 60c8-8 16-8 24 0s16 8 24 0 12-6 12-6" fill="none" stroke="#ffffff" stroke-width="7" stroke-linecap="round"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('brightloop.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#f59e0b"/><circle cx="48" cy="48" r="20" fill="none" stroke="#ffffff" stroke-width="10"/><circle cx="48" cy="48" r="5" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('kestrel-health.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#059669"/><path d="M40 22h16v18h18v16H56v18H40V56H22V40h18z" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('mossgrove.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#4d7c0f"/><path d="M26 70C26 40 44 24 72 24c0 28-16 46-46 46zm0 0l26-26" fill="#ffffff" stroke="#ffffff" stroke-width="3"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('lumen-and-oak.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#b45309"/><path d="M26 44c0-12 10-18 22-18s22 6 22 18z" fill="#ffffff"/><path d="M48 18v8" stroke="#ffffff" stroke-width="6" stroke-linecap="round"/><path d="M30 48h36c0 16-8 28-18 30-10-2-18-14-18-30z" fill="#ffffff" opacity=".8"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('parcelwise.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#dc2626"/><path d="M48 20l26 13v30L48 76 22 63V33z" fill="none" stroke="#ffffff" stroke-width="6" stroke-linejoin="round"/><path d="M22 33l26 13 26-13M48 46v30" fill="none" stroke="#ffffff" stroke-width="6" stroke-linejoin="round"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('orbitfield.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#4338ca"/><ellipse cx="48" cy="48" rx="30" ry="12" fill="none" stroke="#ffffff" stroke-width="5" transform="rotate(-30 48 48)"/><circle cx="48" cy="48" r="10" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('cinderpath-games.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#be123c"/><path d="M48 18c4 14 20 20 20 38a20 20 0 0 1-40 0c0-10 6-16 10-20 0 8 4 12 8 12-4-12 0-22 2-30z" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('harbor-ledger.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#0f766e"/><g fill="none" stroke="#ffffff" stroke-width="6" stroke-linecap="round"><circle cx="48" cy="26" r="6"/><path d="M48 32v42M36 44h24M24 56c0 12 10 18 24 18s24-6 24-18"/></g></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('fernwork.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#15803d"/><text x="48" y="63" text-anchor="middle" font-family="Helvetica, Arial, sans-serif" font-size="44" font-weight="700" fill="#ffffff">F</text></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('stackmint.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#0d9488"/><g fill="#ffffff"><path d="M48 20l28 12-28 12-28-12z"/><path d="M20 46l28 12 28-12v6L48 64 20 52z" opacity=".85"/><path d="M20 62l28 12 28-12v6L48 80 20 68z" opacity=".7"/></g></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('pebble-and-pine.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#57534e"/><g fill="#ffffff"><circle cx="34" cy="34" r="8"/><circle cx="62" cy="34" r="8"/><circle cx="34" cy="62" r="8"/><circle cx="62" cy="62" r="8" opacity=".6"/></g></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('voltbridge.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#ca8a04"/><path d="M54 16L26 54h18l-4 26 28-38H50z" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('sundial-studio.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#ea580c"/><circle cx="48" cy="48" r="13" fill="#ffffff"/><g stroke="#ffffff" stroke-width="6" stroke-linecap="round"><path d="M48 18v8M48 70v8M18 48h8M70 48h8M27 27l6 6M63 63l6 6M27 69l6-6M63 33l6-6"/></g></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('relaywave.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#2563eb"/><circle cx="30" cy="66" r="7" fill="#ffffff"/><g fill="none" stroke="#ffffff" stroke-width="7" stroke-linecap="round"><path d="M30 46a20 20 0 0 1 20 20"/><path d="M30 28a38 38 0 0 1 38 38"/></g></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('nimbus-notes.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#6366f1"/><path d="M30 66a14 14 0 0 1 0-28 18 18 0 0 1 34-4 14 14 0 0 1 2 32z" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('copperline.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#c2410c"/><text x="48" y="63" text-anchor="middle" font-family="Helvetica, Arial, sans-serif" font-size="44" font-weight="700" fill="#ffffff">C</text></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('driftwood-crm.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#78716c"/><text x="48" y="63" text-anchor="middle" font-family="Helvetica, Arial, sans-serif" font-size="44" font-weight="700" fill="#ffffff">D</text></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('hollowtree.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#166534"/><path d="M48 16L24 52h14L28 66h40L58 52h14z" fill="#ffffff"/><rect x="44" y="66" width="8" height="14" fill="#ffffff"/></svg>$svg$, 'UTF8'));
insert into logos (name, contentType, data)
     values ('mapleway-learning.svg', 'image/svg+xml', convert_to($svg$<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96"><rect width="96" height="96" rx="22" fill="#b91c1c"/><g fill="none" stroke="#ffffff" stroke-width="6" stroke-linejoin="round"><path d="M48 30c-8-6-18-7-28-5v42c10-2 20-1 28 5 8-6 18-7 28-5V25c-10-2-20-1-28 5z"/><path d="M48 30v42"/></g></svg>$svg$, 'UTF8'));

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Northwind Labs', 'https://northwindlabs.example', (select id from logos where name = 'northwind-labs.svg'), 'Senior Backend Engineer (Go)',
             'engineering', 'full-time', 'Remote, US or Canada', 150000, 190000,
             $md$## About Northwind Labs

Northwind Labs builds the observability platform that 4,000 engineering teams use to find out why production is slow. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Senior Backend Engineer (Go)** to join a small team with a lot of ownership. This is a full-time role, open to people in the US or Canada.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with Go, Postgres, Kafka and Kubernetes
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $150k to $190k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://northwindlabs.example/careers/senior-backend-engineer-go', 'jobs@northwindlabs.example', 'live',
             true, now() - interval '2 days' - interval '436 minutes', now() - interval '2 days' - interval '436 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Quillfeather', 'https://quillfeather.example', (select id from logos where name = 'quillfeather.svg'), 'Product Designer',
             'design', 'full-time', 'Remote, worldwide', 110000, 140000,
             $md$## About Quillfeather

Quillfeather is a writing app for teams who publish: docs, newsletters and help centres, all from one editor. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Product Designer** to join a small team with a lot of ownership. This is a full-time role, open to people anywhere in the world.

## What you'll do

- Lead design for a product area, from research through to shipped pixels
- Run small experiments and learn from real customers every week
- Contribute to and help evolve our design system
- Present work, take critique well, and give it generously

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with Figma, prototyping and design systems
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $110k to $140k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://quillfeather.example/careers/product-designer', 'jobs@quillfeather.example', 'live',
             true, now() - interval '4 days' - interval '592 minutes', now() - interval '4 days' - interval '592 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Tidepool Analytics', 'https://tidepool.example', (select id from logos where name = 'tidepool-analytics.svg'), 'Data Engineer',
             'engineering', 'full-time', 'Remote, Americas', 130000, 165000,
             $md$## About Tidepool Analytics

Tidepool turns messy product events into dashboards a whole company can read, without a data team in the middle. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Data Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in the Americas.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with Python, dbt, Snowflake and Airflow
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $130k to $165k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://tidepool.example/careers/data-engineer', 'jobs@tidepool.example', 'live',
             false, now() - interval '1 days' - interval '481 minutes', now() - interval '1 days' - interval '481 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Brightloop', 'https://brightloop.example', (select id from logos where name = 'brightloop.svg'), 'Growth Marketing Manager',
             'marketing', 'full-time', 'Remote, US', 95000, 125000,
             $md$## About Brightloop

Brightloop is a referral and loyalty platform for independent retailers, with 12,000 shops on board. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Growth Marketing Manager** to join a small team with a lot of ownership. This is a full-time role, open to people in the US.

## What you'll do

- Own a channel end to end: strategy, execution and reporting
- Run experiments, read the results honestly, and double down on what works
- Work closely with product and sales on launches
- Write copy that sounds like a person, not a press release

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with paid acquisition, lifecycle email and SQL
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $95k to $125k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://brightloop.example/careers/growth-marketing-manager', 'jobs@brightloop.example', 'live',
             false, now() - interval '6 days' - interval '288 minutes', now() - interval '6 days' - interval '288 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Kestrel Health', 'https://kestrelhealth.example', (select id from logos where name = 'kestrel-health.svg'), 'Senior Product Manager, Care Experience',
             'product', 'full-time', 'Remote, US', 145000, 175000,
             $md$## About Kestrel Health

Kestrel Health runs virtual physical therapy: a care plan, a licensed therapist and a phone camera. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Senior Product Manager, Care Experience** to join a small team with a lot of ownership. This is a full-time role, open to people in the US.

## What you'll do

- Own the roadmap for a product area and the outcomes it is measured on
- Talk to customers every week and turn what you hear into clear problems
- Write specs engineers and designers enjoy reading
- Decide what not to build, and explain why

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with discovery, roadmapping and HIPAA-aware products
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $145k to $175k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://kestrelhealth.example/careers/senior-product-manager-care-experience', 'jobs@kestrelhealth.example', 'live',
             true, now() - interval '3 days' - interval '243 minutes', now() - interval '3 days' - interval '243 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Mossgrove', 'https://mossgrove.example', (select id from logos where name = 'mossgrove.svg'), 'Frontend Engineer',
             'engineering', 'full-time', 'Remote, Europe', 90000, 120000,
             $md$## About Mossgrove

Mossgrove helps property managers track energy use across thousands of buildings and cut it. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Frontend Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in Europe.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with TypeScript, React, D3 and accessibility
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $90k to $120k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://mossgrove.example/careers/frontend-engineer', 'jobs@mossgrove.example', 'live',
             false, now() - interval '9 days' - interval '29 minutes', now() - interval '9 days' - interval '29 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Lumen & Oak', 'https://lumenandoak.example', (select id from logos where name = 'lumen-and-oak.svg'), 'Brand Designer',
             'design', 'contract', 'Remote, worldwide', 80000, 100000,
             $md$## About Lumen & Oak

Lumen & Oak is a small, independent brand studio working with climate and education companies. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Brand Designer** to join a small team with a lot of ownership. This is a contract role, open to people anywhere in the world.

## What you'll do

- Lead design for a product area, from research through to shipped pixels
- Run small experiments and learn from real customers every week
- Contribute to and help evolve our design system
- Present work, take critique well, and give it generously

## What we're looking for

- 2+ years of experience in a similar role
- Comfort with identity, illustration and typography
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $80k to $100k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://lumenandoak.example/careers/brand-designer', 'jobs@lumenandoak.example', 'live',
             false, now() - interval '12 days' - interval '518 minutes', now() - interval '12 days' - interval '518 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Parcelwise', 'https://parcelwise.example', (select id from logos where name = 'parcelwise.svg'), 'Staff Platform Engineer',
             'engineering', 'full-time', 'Remote, US or Canada', 185000, 230000,
             $md$## About Parcelwise

Parcelwise is shipping infrastructure for online stores: labels, tracking and returns through one API. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Staff Platform Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in the US or Canada.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with Rust, AWS, Terraform and distributed systems
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $185k to $230k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://parcelwise.example/careers/staff-platform-engineer', 'jobs@parcelwise.example', 'live',
             false, now() - interval '5 days' - interval '251 minutes', now() - interval '5 days' - interval '251 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Orbitfield', 'https://orbitfield.example', (select id from logos where name = 'orbitfield.svg'), 'Content Marketing Lead',
             'marketing', 'full-time', 'Remote, worldwide', 90000, 115000,
             $md$## About Orbitfield

Orbitfield sells satellite imagery by the square kilometre to farmers, insurers and researchers. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Content Marketing Lead** to join a small team with a lot of ownership. This is a full-time role, open to people anywhere in the world.

## What you'll do

- Own a channel end to end: strategy, execution and reporting
- Run experiments, read the results honestly, and double down on what works
- Work closely with product and sales on launches
- Write copy that sounds like a person, not a press release

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with long-form writing, SEO and editorial calendars
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $90k to $115k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://orbitfield.example/careers/content-marketing-lead', 'jobs@orbitfield.example', 'live',
             false, now() - interval '15 days' - interval '214 minutes', now() - interval '15 days' - interval '214 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Cinderpath Games', 'https://cinderpath.example', (select id from logos where name = 'cinderpath-games.svg'), 'Gameplay Engineer',
             'engineering', 'full-time', 'Remote, Europe', 85000, 115000,
             $md$## About Cinderpath Games

Cinderpath is a 40-person studio making cozy co-op games. Our last title sold two million copies. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Gameplay Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in Europe.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with C#, Unity and multiplayer netcode
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $85k to $115k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://cinderpath.example/careers/gameplay-engineer', 'jobs@cinderpath.example', 'live',
             false, now() - interval '8 days' - interval '29 minutes', now() - interval '8 days' - interval '29 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Harbor Ledger', 'https://harborledger.example', (select id from logos where name = 'harbor-ledger.svg'), 'Product Manager, Payments',
             'product', 'full-time', 'Remote, Americas', 135000, 160000,
             $md$## About Harbor Ledger

Harbor Ledger is accounting software for small freight and logistics businesses. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Product Manager, Payments** to join a small team with a lot of ownership. This is a full-time role, open to people in the Americas.

## What you'll do

- Own the roadmap for a product area and the outcomes it is measured on
- Talk to customers every week and turn what you hear into clear problems
- Write specs engineers and designers enjoy reading
- Decide what not to build, and explain why

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with payments, B2B SaaS and SQL
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $135k to $160k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://harborledger.example/careers/product-manager-payments', 'jobs@harborledger.example', 'live',
             false, now() - interval '11 days' - interval '325 minutes', now() - interval '11 days' - interval '325 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Fernwork', 'https://fernwork.example', (select id from logos where name = 'fernwork.svg'), 'UX Researcher',
             'design', 'part-time', 'Remote, US', 60000, 80000,
             $md$## About Fernwork

Fernwork is a scheduling tool for field-service crews: plumbers, electricians and landscapers. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **UX Researcher** to join a small team with a lot of ownership. This is a part-time role, open to people in the US.

## What you'll do

- Lead design for a product area, from research through to shipped pixels
- Run small experiments and learn from real customers every week
- Contribute to and help evolve our design system
- Present work, take critique well, and give it generously

## What we're looking for

- 2+ years of experience in a similar role
- Comfort with interviews, usability testing and synthesis
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $60k to $80k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://fernwork.example/careers/ux-researcher', 'jobs@fernwork.example', 'live',
             false, now() - interval '18 days' - interval '481 minutes', now() - interval '18 days' - interval '481 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Stackmint', 'https://stackmint.example', (select id from logos where name = 'stackmint.svg'), 'Developer Relations Engineer',
             'engineering', 'full-time', 'Remote, worldwide', 125000, 155000,
             $md$## About Stackmint

Stackmint is an open-source feature flag service with a hosted cloud for teams who would rather not run it. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Developer Relations Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people anywhere in the world.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with TypeScript, Go, open source and writing
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $125k to $155k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://stackmint.example/careers/developer-relations-engineer', 'jobs@stackmint.example', 'live',
             false, now() - interval '7 days' - interval '436 minutes', now() - interval '7 days' - interval '436 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Pebble & Pine', 'https://pebbleandpine.example', (select id from logos where name = 'pebble-and-pine.svg'), 'Lifecycle Marketing Manager',
             'marketing', 'full-time', 'Remote, US or Canada', 85000, 110000,
             $md$## About Pebble & Pine

Pebble & Pine sells sustainable home goods direct to customers in the US and Canada. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Lifecycle Marketing Manager** to join a small team with a lot of ownership. This is a full-time role, open to people in the US or Canada.

## What you'll do

- Own a channel end to end: strategy, execution and reporting
- Run experiments, read the results honestly, and double down on what works
- Work closely with product and sales on launches
- Write copy that sounds like a person, not a press release

## What we're looking for

- 2+ years of experience in a similar role
- Comfort with Klaviyo, segmentation and A/B testing
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $85k to $110k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://pebbleandpine.example/careers/lifecycle-marketing-manager', 'jobs@pebbleandpine.example', 'live',
             false, now() - interval '20 days' - interval '399 minutes', now() - interval '20 days' - interval '399 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Voltbridge', 'https://voltbridge.example', (select id from logos where name = 'voltbridge.svg'), 'Senior iOS Engineer',
             'engineering', 'full-time', 'Remote, US', 140000, 175000,
             $md$## About Voltbridge

Voltbridge makes the app EV drivers use to find, book and pay for chargers across 30 networks. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Senior iOS Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in the US.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with Swift, SwiftUI and MapKit
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $140k to $175k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://voltbridge.example/careers/senior-ios-engineer', 'jobs@voltbridge.example', 'live',
             false, now() - interval '10 days' - interval '103 minutes', now() - interval '10 days' - interval '103 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Sundial Studio', 'https://sundial.example', (select id from logos where name = 'sundial-studio.svg'), 'Senior Product Designer',
             'design', 'full-time', 'Remote, worldwide', 130000, 160000,
             $md$## About Sundial Studio

Sundial Studio is a product design consultancy working with early-stage startups from first sketch to launch. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Senior Product Designer** to join a small team with a lot of ownership. This is a full-time role, open to people anywhere in the world.

## What you'll do

- Lead design for a product area, from research through to shipped pixels
- Run small experiments and learn from real customers every week
- Contribute to and help evolve our design system
- Present work, take critique well, and give it generously

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with Figma, user research and motion
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $130k to $160k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://sundial.example/careers/senior-product-designer', 'jobs@sundial.example', 'live',
             true, now() - interval '1 days' - interval '251 minutes', now() - interval '1 days' - interval '251 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Relaywave', 'https://relaywave.example', (select id from logos where name = 'relaywave.svg'), 'Site Reliability Engineer',
             'engineering', 'full-time', 'Remote, Europe or Africa', 120000, 150000,
             $md$## About Relaywave

Relaywave is a messaging API that delivers a billion SMS and push notifications a month. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Site Reliability Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in Europe or Africa.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with Linux, Prometheus, Kubernetes and on-call
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $120k to $150k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://relaywave.example/careers/site-reliability-engineer', 'jobs@relaywave.example', 'live',
             false, now() - interval '13 days' - interval '325 minutes', now() - interval '13 days' - interval '325 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Nimbus Notes', 'https://nimbusnotes.example', (select id from logos where name = 'nimbus-notes.svg'), 'Group Product Manager',
             'product', 'full-time', 'Remote, US', 170000, 210000,
             $md$## About Nimbus Notes

Nimbus Notes is a note-taking app with eight million users and a team plan growing fast. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Group Product Manager** to join a small team with a lot of ownership. This is a full-time role, open to people in the US.

## What you'll do

- Own the roadmap for a product area and the outcomes it is measured on
- Talk to customers every week and turn what you hear into clear problems
- Write specs engineers and designers enjoy reading
- Decide what not to build, and explain why

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with team leadership, growth and experimentation
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $170k to $210k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://nimbusnotes.example/careers/group-product-manager', 'jobs@nimbusnotes.example', 'live',
             false, now() - interval '16 days' - interval '177 minutes', now() - interval '16 days' - interval '177 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Copperline', 'https://copperline.example', (select id from logos where name = 'copperline.svg'), 'SEO Specialist',
             'marketing', 'contract', 'Remote, worldwide', 70000, 90000,
             $md$## About Copperline

Copperline makes project software for architecture and engineering firms. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **SEO Specialist** to join a small team with a lot of ownership. This is a contract role, open to people anywhere in the world.

## What you'll do

- Own a channel end to end: strategy, execution and reporting
- Run experiments, read the results honestly, and double down on what works
- Work closely with product and sales on launches
- Write copy that sounds like a person, not a press release

## What we're looking for

- 2+ years of experience in a similar role
- Comfort with technical SEO, Ahrefs and content strategy
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $70k to $90k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://copperline.example/careers/seo-specialist', 'jobs@copperline.example', 'live',
             false, now() - interval '22 days' - interval '518 minutes', now() - interval '22 days' - interval '518 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Tidepool Analytics', 'https://tidepool.example', (select id from logos where name = 'tidepool-analytics.svg'), 'Machine Learning Engineer',
             'engineering', 'full-time', 'Remote, Americas', 160000, 200000,
             $md$## About Tidepool Analytics

Tidepool turns messy product events into dashboards a whole company can read, without a data team in the middle. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Machine Learning Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in the Americas.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with Python, PyTorch and feature stores
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $160k to $200k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://tidepool.example/careers/machine-learning-engineer', 'jobs@tidepool.example', 'live',
             false, now() - interval '14 days' - interval '325 minutes', now() - interval '14 days' - interval '325 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Northwind Labs', 'https://northwindlabs.example', (select id from logos where name = 'northwind-labs.svg'), 'Engineering Manager, Ingest',
             'engineering', 'full-time', 'Remote, US or Canada', 180000, 220000,
             $md$## About Northwind Labs

Northwind Labs builds the observability platform that 4,000 engineering teams use to find out why production is slow. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring an **Engineering Manager, Ingest** to join a small team with a lot of ownership. This is a full-time role, open to people in the US or Canada.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 8+ years of experience in a similar role
- Comfort with people leadership, Go and streaming systems
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $180k to $220k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://northwindlabs.example/careers/engineering-manager-ingest', 'jobs@northwindlabs.example', 'live',
             false, now() - interval '19 days' - interval '399 minutes', now() - interval '19 days' - interval '399 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Quillfeather', 'https://quillfeather.example', (select id from logos where name = 'quillfeather.svg'), 'Product Marketing Manager',
             'marketing', 'full-time', 'Remote, worldwide', 105000, 135000,
             $md$## About Quillfeather

Quillfeather is a writing app for teams who publish: docs, newsletters and help centres, all from one editor. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Product Marketing Manager** to join a small team with a lot of ownership. This is a full-time role, open to people anywhere in the world.

## What you'll do

- Own a channel end to end: strategy, execution and reporting
- Run experiments, read the results honestly, and double down on what works
- Work closely with product and sales on launches
- Write copy that sounds like a person, not a press release

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with positioning, launches and sales enablement
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $105k to $135k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://quillfeather.example/careers/product-marketing-manager', 'jobs@quillfeather.example', 'live',
             false, now() - interval '17 days' - interval '325 minutes', now() - interval '17 days' - interval '325 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Driftwood CRM', 'https://driftwood.example', (select id from logos where name = 'driftwood-crm.svg'), 'Solutions Engineer',
             'engineering', 'full-time', 'Remote, UK or Europe', 95000, 125000,
             $md$## About Driftwood CRM

Driftwood is a CRM for agencies and consultancies who want a CRM they can set up in an afternoon. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Solutions Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people in the UK or Europe.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with APIs, integrations and customer calls
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $95k to $125k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://driftwood.example/careers/solutions-engineer', 'jobs@driftwood.example', 'live',
             false, now() - interval '21 days' - interval '66 minutes', now() - interval '21 days' - interval '66 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Hollowtree', 'https://hollowtree.example', (select id from logos where name = 'hollowtree.svg'), 'Design Systems Designer',
             'design', 'full-time', 'Remote, US', 125000, 150000,
             $md$## About Hollowtree

Hollowtree is an online bank for freelancers, with invoicing and tax set-asides built in. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Design Systems Designer** to join a small team with a lot of ownership. This is a full-time role, open to people in the US.

## What you'll do

- Lead design for a product area, from research through to shipped pixels
- Run small experiments and learn from real customers every week
- Contribute to and help evolve our design system
- Present work, take critique well, and give it generously

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with Figma variables, tokens and accessibility
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $125k to $150k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://hollowtree.example/careers/design-systems-designer', 'jobs@hollowtree.example', 'live',
             false, now() - interval '24 days' - interval '251 minutes', now() - interval '24 days' - interval '251 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Mapleway Learning', 'https://mapleway.example', (select id from logos where name = 'mapleway-learning.svg'), 'Associate Product Manager',
             'product', 'full-time', 'Remote, US', 90000, 115000,
             $md$## About Mapleway Learning

Mapleway Learning makes reading-practice software used in 9,000 elementary classrooms. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring an **Associate Product Manager** to join a small team with a lot of ownership. This is a full-time role, open to people in the US.

## What you'll do

- Own the roadmap for a product area and the outcomes it is measured on
- Talk to customers every week and turn what you hear into clear problems
- Write specs engineers and designers enjoy reading
- Decide what not to build, and explain why

## What we're looking for

- 3+ years of experience in a similar role
- Comfort with user interviews, analytics and education
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $90k to $115k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://mapleway.example/careers/associate-product-manager', 'jobs@mapleway.example', 'live',
             false, now() - interval '27 days' - interval '325 minutes', now() - interval '27 days' - interval '325 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Copperline', 'https://copperline.example', (select id from logos where name = 'copperline.svg'), 'Marketing Operations Analyst',
             'marketing', 'contract', 'Remote, worldwide', 60000, 75000,
             $md$## About Copperline

Copperline makes project software for architecture and engineering firms. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Marketing Operations Analyst** to join a small team with a lot of ownership. This is a contract role, open to people anywhere in the world.

## What you'll do

- Own a channel end to end: strategy, execution and reporting
- Run experiments, read the results honestly, and double down on what works
- Work closely with product and sales on launches
- Write copy that sounds like a person, not a press release

## What we're looking for

- 2+ years of experience in a similar role
- Comfort with HubSpot and reporting
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $60k to $75k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://copperline.example/careers/marketing-operations-analyst', 'jobs@copperline.example', 'expired',
             false, now() - interval '35 days' - interval '436 minutes', now() - interval '35 days' - interval '436 minutes' + interval '30 days');

insert into listings (companyName, companyUrl, logoId, title, category, jobType, location,
                      salaryMin, salaryMax, description, applyUrl, employerEmail, status,
                      featured, publishedAt, expiresAt)
     values ('Driftwood CRM', 'https://driftwood.example', (select id from logos where name = 'driftwood-crm.svg'), 'Senior Rails Engineer',
             'engineering', 'full-time', 'Remote, worldwide', 130000, 160000,
             $md$## About Driftwood CRM

Driftwood is a CRM for agencies and consultancies who want a CRM they can set up in an afternoon. We are fully remote and write things down: most decisions happen in docs, not meetings.

## The role

We are hiring a **Senior Rails Engineer** to join a small team with a lot of ownership. This is a full-time role, open to people anywhere in the world.

## What you'll do

- Design, build and ship features end to end, from the schema to the page
- Own services in production, including a shared on-call rotation one week in eight
- Review code, write design docs, and mentor the engineers around you
- Work with product and design to decide what to build next and what not to

## What we're looking for

- 5+ years of experience in a similar role
- Comfort with Ruby on Rails and Postgres
- Clear written communication; you will work across time zones
- Curiosity about the people who use what you make

## Compensation and benefits

- $130k to $160k base salary, plus equity
- Health, dental and vision coverage, or a stipend where we can't offer a plan
- $1,500 home office budget and a yearly learning allowance
- Four weeks of paid time off, plus a company-wide week off in December

## How to apply

Apply through the link on this page with a CV or portfolio and a few lines on why this role. We reply to everyone within a week.$md$,
             'https://driftwood.example/careers/senior-rails-engineer', 'jobs@driftwood.example', 'draft',
             false, null, null);

insert into subscribers (email, categories)
     values ('ada@example.com', '{engineering,product}'),
            ('grace@example.com', '{design}'),
            ('linus@example.com', '{engineering}'),
            ('margaret@example.com', '{engineering,design,product}'),
            ('dieter@example.com', '{design,product}'),
            ('mary@example.com', '{marketing}'),
            ('alan@example.com', '{engineering,marketing}');

-- every published listing was paid for: $99, or $149 with the featured upgrade
insert into payments (stripeSessionId, listingId, publish, feature, amountTotal, currency, createdAt)
     select 'seed_' || l.id, l.id, true, l.featured, case when l.featured then 14900 else 9900 end, 'usd', l.publishedAt
       from listings l
      where l.publishedAt is not null;
