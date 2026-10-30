# rizzoadm.github.io

Source code for **Mr. Rizzo**'s personal website and professional portfolio, published at [rizzoadm.github.io](https://rizzoadm.github.io).

## What this site is

A static portfolio that extends my resume: professional experience, skills and selected projects (AI, legal AI, a financial spreadsheet, 3D modeling), plus photography and hobbies. Available in English and Portuguese.

## What this site is not

- No personal email or phone number.
- No family, home or private-life information.
- All photos are published with EXIF/GPS metadata removed.

## Stack

- [Hugo](https://gohugo.io/) (extended), a static site generator
- [Blowfish](https://blowfish.page/) theme, included as a git submodule in `themes/blowfish`
- GitHub Pages, deployed through GitHub Actions

## Run locally

```bash
git clone --recurse-submodules https://github.com/RizzoAdm/rizzoadm.github.io.git
cd rizzoadm.github.io
hugo server
```

Then open http://localhost:1313.

## Structure

| Folder | Purpose |
|---|---|
| `config/_default/` | Site configuration (languages, menus, theme parameters) |
| `assets/` | Images, custom color schemes and `css/custom.css` (site-wide CSS overrides) |
| `content/` | Pages and posts. Each page is a bundle: `index.md` (EN) + `index.pt-br.md` (PT-BR) + images |
| `content/projects/` | Projects, one folder per project |
| `content/hobbies/` | Hobbies: photography, 3D for fun and cooking as gallery sections; cycling, homelab and swimming as pages |
| `layouts/shortcodes/` | Custom `rz-*` shortcodes (see below) |
| `layouts/partials/` | Partials used by the `rz-*` shortcodes (CSS, lightbox, gallery layout) |
| `scripts/` | Helper scripts (image preparation) |
| `static/` | Files served as-is |
| `themes/blowfish/` | Theme (submodule) |
| `docs/` | Project notes, progress log and manuals (not rendered) |

## Custom shortcodes

Usage is documented at the top of each file in `layouts/shortcodes/`.

| Shortcode | What it does |
|---|---|
| `rz-photos` | Photo gallery in justified rows: original aspect ratio, no cropping, per-photo highlight levels (1–4) set in a `photos.yaml` file shared by both languages, optional subsets (`files`, `from`/`count`) and captions, click to enlarge |
| `rz-gallery` | Image grid with fixed or original aspect ratio, optional placeholders, lightbox and video tile |
| `rz-video` | Responsive Vimeo or YouTube embed (videos are not stored in the repository) |
| `rz-feature` | Video next to a 2×2 image grid |

## Images

Every image goes through `scripts/prepare-images.sh` before being committed:

```bash
bash scripts/prepare-images.sh <source folder> <bundle>/gallery [start number]
```

It renames files in sequence (`01.jpg`, `02.jpg`, ...), strips **all** metadata (EXIF, GPS, camera, file paths), converts to sRGB JPEG (quality 88) and limits the longest side to 2560 px. Originals are never modified and are kept outside the repository.

Step-by-step guide for adding galleries (in Portuguese): [`docs/manual-galerias.md`](docs/manual-galerias.md).

## Status

Under construction. Not yet deployed.