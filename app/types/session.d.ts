/**
 * The keys your app stores in the session, so `session.get("userId")` is
 * typed. Only the admin signs in; employers and job seekers have no account.
 */
declare module "@elements/app" {
  interface SessionData {
    userId: string;
    userName: string;
  }
}

export {};
