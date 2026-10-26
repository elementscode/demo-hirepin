![A job board with paid listings, built by Claude Code on Elements: featured listings pinned at the top with company logos, salary ranges, category and job type tags, beside search and category, job type and salary filters.](https://elements.dev/demos/01a0f449-6972-792e-9f0f-a81e57ada225/poster?v=588f9456632d)

# A job board with paid listings, built by Claude Code on Elements

> Hirepin is a full-stack app built with Claude Code on Elements.

Remote jobs filtered by category, type and salary, a weekly new-jobs email, and $99 listings paid by card, $50 more to feature.

[Run this app on your machine](https://elements.dev/demos/01a0f449-6972-792e-9f0f-a81e57ada225). Use this demo as inspiration, or as the starting point for your own app. Your agent creates a new app with this one as the scaffold, and you prompt it to add whatever features you want.

## Payments

Employers pay $99 to publish and $50 to feature. Without a Stripe key, the pay
buttons open a built-in test checkout: the order, the total and a Pay button
that records the payment the way a real one is recorded, so the listing goes
live, the receipt email goes out and every open board updates. No card is
collected.

For real Stripe Checkout, create a free sandbox at
[dashboard.stripe.com/register](https://dashboard.stripe.com/register), copy
the secret key from Developers, API keys, and add it to
`config/env/development.env` as `STRIPE_SECRET_KEY`. The same buttons then go
to Stripe; pay with the test card `4242 4242 4242 4242`, any future date and
any CVC. Production requires the key: the build fails without it and the app
refuses to start with it empty. On the first checkout in production the app
registers its own Stripe webhook and keeps the signing secret.

## How it's built

Hirepin needed a board that fills in as listings are paid for, employers who post and edit from an emailed link, card payments for publishing and featuring, expiry reminders and a weekly email. Each of those is a part of Elements, so the agent spent its 25 minutes on the job board itself.

- **A live board.** Listings are a LiveTable, so a job appears on every open board the moment its payment lands, and the search, category, job type and salary filters run in the page over that live list.

- **Posting without an account.** The post form sends the fields and the logo to the server in one `@rpc` call, saves a draft and emails the employer a private link for editing and paying later.

- **Card payments.** Publishing for 30 days costs $99 and featuring costs $50, with prices from the app's config. The listing goes live once whether the return page or Stripe's webhook arrives first, and until a Stripe key is added the pay button opens a test checkout inside the app that records the payment just as a Stripe one is recorded. In production the app registers its own Stripe webhook on the first checkout.

- **Jobs and email.** A cron schedule checks every 15 minutes, takes listings off the board after 30 days and emails each employer a few days before. Every Monday at 9am a job emails each subscriber the new jobs in their categories, once per week.

- **Data from SQL files.** Migrations define the board and seed the admin and 25 live listings from 22 made-up companies with drawn logos, four of them featured.

- **Sessions and roles.** The admin's review and remove pages and their server calls share one guard on the admin role.

## Why Elements

Elements is an integrated full-stack app framework and a project server. The project server checks the agent's work as it builds: it type-checks the server and browser code, analyzes the program, applies migrations and runs the tests, then reports the results to the agent. A security mistake, such as calling a server-only function from the browser, is a compile error. The agent reads the report and fixes its own mistakes before it tells you a feature is done. The same checks run on every feature you ask for next.
