# Cloud setup

The tracker uses Supabase for password authentication, private cloud storage, and live updates between devices. Vercel can host the static page. No password or Supabase service-role key belongs in `index.html`.

## 1. Create the Supabase project

1. Create a Supabase project at [supabase.com](https://supabase.com/).
2. In the project's SQL Editor, run the contents of [`supabase-schema.sql`](./supabase-schema.sql).
3. In **Project Settings → API**, copy the Project URL and the public anon/publishable key.
4. The project URL and public publishable key you supplied are now configured in `index.html`. If you create a different Supabase project later, replace `SUPABASE_URL` and `SUPABASE_ANON_KEY` with that project's values. Never use a `service_role` or secret key in this page.
5. In **Authentication → URL Configuration**, set the Site URL to the Vercel URL after deployment and add that URL to the allowed redirect URLs.
6. In **Authentication → Settings**, set the access-token/JWT lifetime to **3600 seconds**. The page also ends its in-memory session after one hour and does not persist or refresh sign-in sessions.
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

The supplied GitHub repository is currently empty, so it needs an initial push before Vercel can import it. Put this project folder in the repository root with the exact name shown above, then push it to the repository's `main` branch.

In Vercel, create a project and import `PhantomBeast-Official/JHN-Career-Roadmap`. Set **Root Directory** to `DevOps Engineering Roadmap (Zero-to-Hero)`, use the **Other** framework preset, and leave the build command empty. `index.html` is the entry point. Deploy the project; Vercel will serve this roadmap at the project's domain root.

For each future independent roadmap website, add another ordinary folder to the same GitHub repository and create another Vercel project from that repository, selecting that website's folder as its **Root Directory**. Each Vercel project gets its own URL. After the first deployment, set this site's Vercel URL in Supabase **Authentication → URL Configuration**. Open that URL on each phone or computer and sign in to the same Supabase account.

Changes are saved to Supabase and subscribed devices receive live updates. The browser also keeps a per-account local cache, but the cloud row is authoritative. If two devices edit at exactly the same time, the most recent full-state save wins.

## 3. Existing browser progress

On the first sign-in for an account with no cloud row, the page imports the legacy tracker data from this browser if present and uploads it. Later sign-ins load the cloud copy, so progress is available on other devices.

## Security note

The Supabase public anon/publishable key is intended for browser use; the row-level security policy in `supabase-schema.sql` restricts each account to its own record. Never publish a service-role key or a password. If a password shared in chat is a real account password, change it before using the cloud profile.
