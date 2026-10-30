# Progress log

Read this at the start of each session; update it at the end. Newest entry first.
This file is public: keep it to work notes only (see privacy rules in `CLAUDE.md`).

## Current status

- Site content: Home, About, Experience, Skills, Projects (Legal AI, Local AI, Family Finance,
  3D Archviz, Beaver Buzz Energy) and Hobbies, all in EN and PT-BR.
- Hobbies: Photography (Animals & Plants, The Moon, HDR), 3D for Fun (Corvette), Homelab, Cycling,
  Swimming. Cooking is hidden (`build` block) until there are photos.
- Menu items still without a page: Contact (stage 9).
- **Not deployed yet.** No `.github/workflows/` file.

## Next steps

- [ ] Stage 9: Contact page with the LinkedIn link (`/contact/` is already linked from Family Finance)
- [ ] Blog section (`content/blog`, EN/PT), then the menu item between Hobbies and Contact
- [ ] Replace the site icon/favicon (still Blowfish's)
- [ ] Stage 10: GitHub Actions workflow; pin a Hugo version supported by Blowfish (0.164–0.167; local is 0.169 via snap);
      checkout with submodules; turn off `showRecent` if there is no recent content
- [ ] Stage 11: final review (mobile: About photo strip, timeline, galleries; long text at full width; links; privacy)
- [ ] Cooking: add a gallery and remove the `build` block
- [ ] Legal AI: update status and numbers when the project moves forward
- [ ] End of project: README in PT-BR, full site manual (blog, galleries, projects), LinkedIn post

## Session log

### 2026-10-28 to 2026-10-30 (stage 8: Hobbies and photography)
- Hobbies section (cards): Photography, 3D for Fun and Cooking as gallery sections; Homelab, Cycling, Swimming as pages.
- New `rz-photos` shortcode: justified rows, original aspect ratio, highlight levels 1–4 via `photos.yaml`,
  `files` / `from` / `count` subsets to interleave text and photos, `caption`; two consecutive level-2 photos share a row.
- `assets/css/custom.css`: full-width text on every page.
- `docs/manual-galerias.md`: how to add and update galleries, image best practices, privacy checklist.
- Galleries: Corvette (3D), Animals & Plants, The Moon, HDR. Cooking hidden. Covers for all hobby cards.

### 2026-10-29
- Added `CLAUDE.md` and this progress log so work can continue from any device
  (desktop, Android app via Remote Control or cloud sessions).

### 2026-10-24 to 2026-10-28 (summary from git history)
- Initial Hugo + Blowfish setup, EN/PT-BR languages, menus, custom dark color scheme
- Hero homepage with profile photo and background
- About, Experience, Skills pages
- Projects section with five projects, `rz-gallery` / `rz-video` / `rz-feature` shortcodes
- `scripts/prepare-images.sh` for metadata-free images
