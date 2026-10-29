# Progress log

Read this at the start of each session; update it at the end. Newest entry first.
This file is public: keep it to work notes only (see privacy rules in `CLAUDE.md`).

## Current status

- Site content: Home, About, Experience, Skills and Projects (Legal AI, Local AI, Family Finance,
  3D Archviz, Beaver Buzz Energy), all in EN and PT-BR.
- **Not deployed yet.** The README mentions GitHub Actions, but there is no `.github/workflows/` file.

## Next steps

- [ ] Add a GitHub Actions workflow to build Hugo and deploy to GitHub Pages
- [ ] Photography and hobbies sections (mentioned in the README, not created yet)
- [ ] Review all pages before the first deploy

## Session log

### 2026-10-29
- Added `CLAUDE.md` and this progress log so work can continue from any device
  (desktop, Android app via Remote Control or cloud sessions).

### 2026-10-24 to 2026-10-28 (summary from git history)
- Initial Hugo + Blowfish setup, EN/PT-BR languages, menus, custom dark color scheme
- Hero homepage with profile photo and background
- About, Experience, Skills pages
- Projects section with five projects, `rz-gallery` / `rz-video` / `rz-feature` shortcodes
- `scripts/prepare-images.sh` for metadata-free images
