# Cloud setup

The tracker uses Supabase for password authentication, private cloud storage, and live updates between devices. Vercel hosts the static page. No password or Supabase service-role key belongs in `index.html`.

## 1. Create the Supabase project

1. Create a Supabase project at [supabase.com](https://supabase.com/).
2. In the project's SQL Editor, run the contents of [`supabase-schema.sql`](./supabase-schema.sql).
3. In **Project Settings → API**, copy the Project URL and the public anon/publishable key.
4. The project URL and public publishable key you supplied are now configured in `index.html`. If you create a different Supabase project later, replace `SUPABASE_URL` and `SUPABASE_ANON_KEY` with that project's values. Never use a `service_role` or secret key in this page.
5. In **Authentication → URL Configuration**, set the Site URL to the Vercel URL and add that URL to the allowed redirect URLs. This project's production URL is `https://devops-engineering-roadmap.vercel.app`.
6. In **Authentication → Sessions**, keep the access-token/JWT lifetime at **3600 seconds**. This is the Supabase default and is already configured for this project. The app ends its in-memory session after one hour and does not persist or refresh sign-in sessions. Supabase server-side session time-boxing requires a Pro plan; the app's one-hour timeout remains active on the current Free plan.
7. Keep email confirmation enabled if you want Supabase to verify the account email. If enabled, confirm the email after creating the profile.

The first profile can be created from the sign-in screen. Use the profile name `JH Nahid` and the email account you want to use on all devices. Once the intended profile exists, disable public sign-ups in Supabase Auth settings if this is a private tracker.

## 2. Deploy the site

Use one GitHub repository for the roadmap collection, with each website in an ordinary subfolder (not a Git submodule):

```text
JHN-Career-Roadmap/
└── DevOps Engineering Roadmap (Zero-to-Hero)/
    ├── index.html
    ├── supabase-schema.sql
    ├── SETUP.md
    └── README.md
```

The project is already committed to the `main` branch of `PhantomBeast-Official/JHN-Career-Roadmap` in the folder shown above.

The Vercel project is deployed from `PhantomBeast-Official/JHN-Career-Roadmap` with **Root Directory** set to `DevOps Engineering Roadmap (Zero-to-Hero)`, the **Other** framework preset, and no build command. `index.html` is served at [https://devops-engineering-roadmap.vercel.app](https://devops-engineering-roadmap.vercel.app). New commits to `main` automatically trigger deployments.

For each future independent roadmap website, add another ordinary folder to the same GitHub repository and create another Vercel project from that repository, selecting that website's folder as its **Root Directory**. Each Vercel project gets its own URL.

Changes are saved to Supabase and subscribed devices receive live updates. The browser also keeps a per-account local cache, but the cloud row is authoritative. If two devices edit at exactly the same time, the most recent full-state save wins.

## 3. Existing browser progress

On the first sign-in for an account with no cloud row, the page imports the legacy tracker data from this browser if present and uploads it. Later sign-ins load the cloud copy, so progress is available on other devices.

## Security note

The Supabase public anon/publishable key is intended for browser use; the row-level security policy in `supabase-schema.sql` restricts each account to its own record. Never publish a service-role key or a password. If a password shared in chat is a real account password, change it before using the cloud profile.
