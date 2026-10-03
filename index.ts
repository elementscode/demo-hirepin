import { App, getEnv } from "@elements/app";
import config from "#config";
import home from "#app/pages/home";
import notFound from "#app/pages/errors/not-found";
import unhandled from "#app/pages/errors/unhandled";
import { ExpireListingsJob } from "#app/jobs/expire-listings";
import { WeeklyDigestJob } from "#app/jobs/weekly-digest";
import serveLogo from "#app/routes/logos";
import checkoutReturn from "#app/routes/checkout-return";
import stripeWebhook from "#app/routes/stripe-webhook";
import job from "#app/pages/job";
import post from "#app/pages/post";
import manage from "#app/pages/manage";
import signin from "#app/pages/signin";
import admin from "#app/pages/admin";
import checkoutTest from "#app/pages/checkout-test";
import unsubscribe from "#app/pages/unsubscribe";
import { stripeConfigured } from "#app/shared/stripe";

if (getEnv() === "production" && !stripeConfigured()) {
  throw new Error("STRIPE_SECRET_KEY is required in production.");
}

const app = new App();

app.route("/", home);
app.route("/jobs/:id", job);
app.route("/post", post);
app.route("/manage/:token", manage);
app.route("/signin", signin);
app.route("/admin", admin);
app.route("/unsubscribe/:token", unsubscribe);
app.route("/logos/:id/:hash", serveLogo);
app.route("/checkout/test/:token", checkoutTest);
app.route("/checkout/return", checkoutReturn);
app.route({ method: "post", path: "/stripe/webhook", handler: stripeWebhook });

app.cron("every 15m", "expire listings", () => new ExpireListingsJob().schedule());
app.cron("every monday at 9am", "weekly digest", () => new WeeklyDigestJob().schedule());

app.error((req, res, err) => {
  switch (err.statusCode) {
    case 404:
      return notFound(req, res, err);

    default:
      return unhandled(req, res, err);
  }
});

app.start(config);
