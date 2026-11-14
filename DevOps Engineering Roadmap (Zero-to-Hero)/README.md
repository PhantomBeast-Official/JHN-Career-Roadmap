# DevOps Engineering Roadmap (Zero-to-Hero)

A cloud-synced study tracker for the 13-stage DevOps roadmap. It includes searchable stage cards, video/syllabus/lab checklists, study-hour logging, project links and notes, capstone checklists, certification guidance, progress reports, and JSON backup/restore.

## Run locally

Follow [`SETUP.md`](./SETUP.md) to create and configure the Supabase project first. Then serve this folder over HTTP (for example, run `python -m http.server 8000` here) and open `http://localhost:8000`. The page loads Supabase, Tailwind CSS, Chart.js, and web fonts from CDNs, so an internet connection is required.

## Progress and privacy

Progress is stored in Supabase and synchronized across devices signed in to the same account. Row-level security restricts each account to its own tracker record. The browser also keeps a per-account cache. Use **Progress Report & Backup** to export a JSON backup. Keep backups private if your notes contain personal information.

Authentication is handled by Supabase; the page does not store passwords or persist login sessions. Sessions require a fresh sign-in on each page open and expire after one hour. Only the Supabase public anon/publishable key belongs in the page; never add a password or service-role key.

## Publish and update the website

Deploy the configured folder as a static site using Vercel or GitHub Pages. Set the deployed URL in Supabase Authentication URL Configuration. For this repository, the GitHub Actions workflow at `../.github/workflows/pages.yml` publishes this folder to GitHub Pages:

1. Push this project to `main` in `PhantomBeast-Official/JHN-Career-Roadmap`.
2. In the repository, open **Settings → Pages** and select **GitHub Actions** as the build and deployment source if it is not already selected.
3. Open **Actions** and wait for the **Deploy roadmap to GitHub Pages** workflow to complete.
4. The site will be available at <https://phantombeast-official.github.io/JHN-Career-Roadmap/>.

After that initial setup, every push to `main` updates the website automatically. Progress changes sync directly to Supabase and do not require a repository update.
