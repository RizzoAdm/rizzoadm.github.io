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
| `config/_default/` | Site config: `hugo.toml`, `languages.*.toml`, `menus.*.toml`, `params.toml` |
| `content/` | Pages. Each page is a bundle: `index.md` (EN) + `index.pt-br.md` (PT-BR) + images |
| `content/projects/<slug>/` | One folder per project, `feature.jpg` as cover, optional `gallery/01.jpg ...` |
| `content/hobbies/` | Hobbies. `photography/`, `3d-for-fun/`, `cooking/` are sections (`_index.md`) with one gallery bundle per folder; `cycling/`, `homelab/`, `swimming/` are pages. `example-gallery/` folders are drafts used as templates |
| `content/hobbies/<section>/<gallery>/photos.yaml` | Highlights (`highlight: "05:1 12:2"`) and optional `order:` list, shared by EN and PT |
| `layouts/shortcodes/rz-*.html` | Custom shortcodes: `rz-photos`, `rz-gallery`, `rz-video`, `rz-feature` (usage documented at the top of each file) |
| `layouts/partials/rz-*.html` | Partials used by those shortcodes (`rz-photos-assets.html` = justified-rows layout script) |
| `assets/css/custom.css` | Site-wide overrides: text uses the full content width on every page |
| `scripts/prepare-images.sh` | Renames, strips metadata and resizes images for the site |
| `docs/` | Project notes, progress log and `manual-galerias.md` (gallery how-to, PT-BR); not rendered by Hugo |

## Conventions

- Every content page exists in both languages. When editing one, update the other.
- Project pages start with a status badge (`{{< badge >}}In progress{{< /badge >}}`) and use front matter
  `title`, `summary`, `date`, `weight`, `tags`.
- Commit messages: short imperative English sentence describing what was added or changed.
- Hiding a hobby/section without deleting it: front matter `build: {render: never, list: never, publishResources: false}`
  plus the same under `cascade:` (do not use `draft: true` on sections: child pages would still be published).
- After editing `photos.yaml` or a shortcode, restart `hugo server`: changes are not always picked up live.

## Commands

```bash
git submodule update --init --recursive   # first clone on a new machine
hugo server                                # preview at http://localhost:1313
hugo --gc --minify                         # production build into public/ (ignored by git)
```
