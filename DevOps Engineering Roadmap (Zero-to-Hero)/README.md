# DevOps Engineering Roadmap (Zero-to-Hero)

A cloud-synced study tracker for the 13-stage DevOps roadmap. It includes searchable stage cards, video/syllabus/lab checklists, study-hour logging, project links and notes, capstone checklists, certification guidance, progress reports, and JSON backup/restore.

## Run locally

Follow [`SETUP.md`](./SETUP.md) to create and configure the Supabase project first. Then serve this folder over HTTP (for example, run `python -m http.server 8000` here) and open `http://localhost:8000`. The page loads Supabase, Tailwind CSS, Chart.js, and web fonts from CDNs, so an internet connection is required.

## Progress and privacy

Progress is stored in Supabase and synchronized across devices signed in to the same account. Row-level security restricts each account to its own tracker record. The browser also keeps a per-account cache. Use **Progress Report & Backup** to export a JSON backup. Keep backups private if your notes contain personal information.

Authentication is handled by Supabase; the page does not store passwords or persist login sessions. Sessions require a fresh sign-in on each page open and expire after one hour. Only the Supabase public anon/publishable key belongs in the page; never add a password or service-role key.

## Publish and update the website

This static site is deployed on Vercel at <https://devops-engineering-roadmap.vercel.app/> from the `DevOps Engineering Roadmap (Zero-to-Hero)` folder in `PhantomBeast-Official/JHN-Career-Roadmap`. Vercel is configured with the **Other** framework preset and no build command. Commits pushed to `main` trigger a Vercel deployment; GitHub Pages publishing is not configured.

Progress changes sync directly to Supabase and do not require a repository update.
