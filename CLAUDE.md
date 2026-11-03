# CLAUDE.md

Personal website and portfolio of **Mr. Rizzo**, published at https://rizzoadm.github.io.
Hugo (extended) + Blowfish theme (git submodule in `themes/blowfish`), bilingual EN / PT-BR.

## Working across devices

The owner switches between the desktop, the Claude Android app (Remote Control / cloud sessions) and back.
The repository is the single source of truth, so context must live in files, not only in chat history.

- **Start of every session:** run `git pull` and read `docs/progress.md` to see where the last session stopped.
- **End of every session (or when the owner says they are leaving):** update `docs/progress.md`
  (what was done, decisions, next steps), commit, and ask before pushing.
- Talk to the owner in **Portuguese (PT-BR)**. Code, commit messages and repo docs stay in English.

## Public repository: privacy rules

This repo is **public**. Everything committed here, including `CLAUDE.md` and `docs/`, is visible to anyone.

- No personal email, phone number, address, family, home or private-life information.
- No secrets, tokens or credentials.
- All photos must have EXIF/GPS metadata removed: use `scripts/prepare-images.sh`.

## Structure

| Path | Purpose |
|---|---|
| `.github/workflows/hugo.yml` | Deploy to GitHub Pages on every push to `main`. Hugo pinned to 0.167.0 (Blowfish supports 0.164–0.167); checkout with submodules; `resources/_gen` cached |
| `static/` | Site icons (`favicon.ico`, PNG sizes, `favicon.svg` source) and `site.webmanifest`; override the Blowfish defaults |
| `config/_default/` | Site config: `hugo.toml`, `languages.*.toml`, `menus.*.toml`, `params.toml` |
| `content/` | Pages. Each page is a bundle: `index.md` (EN) + `index.pt-br.md` (PT-BR) + images |
| `content/projects/<slug>/` | One folder per project, `feature.jpg` as cover, optional `gallery/01.jpg ...` |
| `content/hobbies/` | Hobbies. `photography/`, `3d-for-fun/`, `cooking/` are sections (`_index.md`) with one gallery bundle per folder; `cycling/`, `homelab/`, `swimming/` are pages. `example-gallery/` folders are drafts used as templates |
| `content/hobbies/<section>/<gallery>/photos.yaml` | Highlights (`highlight: "05:1 12:2"`) and optional `order:` list, shared by EN and PT |
| `content/privacy/` | Privacy Policy (EN/PT), linked from the footer menu only (not the main menu). Also covers the owner's private Google OAuth app for rclone ("Arquivos pessoais e backups gerais"); its URL `https://rizzoadm.github.io/privacy/` is registered in Google Cloud, so do not move or rename it. Update the "Last updated" date in both files whenever the text changes |
| `content/contact/`, `content/thanks/` | Contact page (cards + Web3Forms form) and the confirmation page shown after sending (`noindex`, not listed) |
| `layouts/shortcodes/rz-*.html` | Custom shortcodes: `rz-photos`, `rz-gallery`, `rz-video`, `rz-feature`, `rz-contact-cards`, `rz-contact-card`, `rz-contact-form` (usage documented at the top of each file) |
| `layouts/partials/rz-*.html` | Partials used by those shortcodes (`rz-photos-assets.html` = justified-rows layout script) |
| `assets/css/custom.css` | Site-wide overrides: text uses the full content width on every page; contact page styles at the end |
| `archetypes/` | Templates for `hugo new`: `projects/` (default for `content/projects/`), `gallery/` and `hobby/` (`--kind`). EN + PT with `TODO` placeholders |
| `scripts/new.sh` | One-command content creation: `project`, `gallery`, `hobby`, `images` (append to a gallery), `cover` (make `feature.jpg`). Uses the archetypes, sets `weight` to last + 10, runs `prepare-images.sh` |
| `scripts/check.sh` | Pre-publish checklist: EN/PT pairs, summary/description, leftover `TODO`, drafts, covers, image metadata and size, production build, git status. Exit 1 on errors; `--quick` skips the build |
| `scripts/prepare-images.sh` | Renames, strips metadata and resizes images for the site |
| `README.md` / `README.pt-br.md` | Repository README in English and Portuguese, linked to each other at the top. Keep both in sync |
| `docs/` | Progress log and manuals (PT-BR, not rendered by Hugo): `manual-site.md` (main manual: site map, contact form, config, theme/Hugo upgrades), `manual-conteudo.md` (content routine), `manual-galerias.md` (gallery how-to) |

## Conventions

- New content: `bash scripts/new.sh ...`; before every commit: `bash scripts/check.sh`. Routine in `docs/manual-conteudo.md`.
  Archetypes use `TODO` placeholders on purpose: `check.sh` fails while any is left. Keep the archetypes in sync with
  the conventions below when they change.
- Every content page exists in both languages. When editing one, update the other.
- Project pages start with a status badge (`{{< badge >}}In progress{{< /badge >}}`) and use front matter
  `title`, `summary`, `date`, `weight`, `tags`.
- Commit messages: short imperative English sentence describing what was added or changed.
- Hiding a hobby/section without deleting it: front matter `build: {render: never, list: never, publishResources: false}`
  plus the same under `cascade:` (do not use `draft: true` on sections: child pages would still be published).
- `web3formsAccessKey` stays at the top of `config/_default/params.toml` (outside any `[section]`). It is public by design.
- Pushing to `main` publishes the site (about 2–3 min; check the Actions tab). Preview locally first.
- Upgrading Blowfish or the workflow Hugo version: follow `docs/manual-site.md` (sections 9 and 10); test with the exact pinned Hugo binary first.
- Local Hugo (snap) may be newer than the pinned 0.167.0 and shows a Blowfish compatibility WARN: harmless locally. Do not raise the workflow version beyond the theme's max.
- SEO: the site description lives in `languages.*.toml` (`[params] description`). Pages without `summary` need a
  `description` in front matter. Share image fallback: `defaultSocialImage` in `params.toml` (avatar).
- After editing `photos.yaml` or a shortcode, restart `hugo server`: changes are not always picked up live.

## Commands

```bash
git submodule update --init --recursive   # first clone on a new machine
hugo server                                # preview at http://localhost:1313
hugo --gc --minify                         # production build into public/ (ignored by git)
bash scripts/new.sh project <slug> [images]  # new content (see docs/manual-conteudo.md)
bash scripts/check.sh                      # pre-publish checklist
```
