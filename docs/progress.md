# Progress log

Read this at the start of each session; update it at the end. Newest entry first.
This file is public: keep it to work notes only (see privacy rules in `CLAUDE.md`).

## Current status

- Site content: Home, About, Experience, Skills, Projects (Legal AI, Local AI, Family Finance,
  3D Archviz, Beaver Buzz Energy), Hobbies and Contact, all in EN and PT-BR.
- Hobbies: Photography (Animals & Plants, The Moon, HDR), 3D for Fun (Corvette), Homelab, Cycling,
  Swimming. Cooking is hidden (`build` block) until there are photos.
- Contact: cards (LinkedIn, GitHub, Message) + Web3Forms form; `thanks/` page after sending.
- **Live** at https://rizzoadm.github.io since 2026-10-30, deployed by GitHub Actions (`.github/workflows/hugo.yml`).
- Custom favicon (cyan geometric "R" on dark indigo) in `static/`. Home "Recent" lists projects only.
- Stage 11 (final review) done: build has no warnings; SEO descriptions and share image in place.

## Next steps

- [ ] Blog: will be hosted outside this site. When it exists, add only an external link to the menu
      (`url` instead of `pageRef`) between Hobbies and Contact. Do not add `blog` back to `mainSections`
- [ ] Cooking: add a gallery and remove the `build` block
- [ ] Legal AI: update status and numbers when the project moves forward
- [ ] End of project: README in PT-BR, full site manual (galleries, projects, contact form), LinkedIn post

## Decisions

- Hosting: GitHub Pages via GitHub Actions; Hugo pinned to the newest version Blowfish supports.
- Home "Recent" shows projects only (`mainSections = ["projects"]`).
- Contact page shows an "Open to opportunities" badge. This is a deliberate exception chosen by the owner;
  do not remove it during reviews.
- Contact form: Web3Forms (free plan). The access key lives in `config/_default/params.toml`
  (`web3formsAccessKey`, top of the file) and is public by design: it does not reveal the destination email.
  hCaptcha is enabled in the Web3Forms dashboard. The email subject is fixed in English in both languages
  ("New message from rizzoadm.github.io") so one mail filter catches it.

## Session log

### 2026-10-30 (stage 11: Final review)
- Mobile check at 390 px (iPhone size): no horizontal overflow on any page; About photo strip, timeline,
  galleries (lazy loading OK), contact cards and form OK.
- Links: all internal links resolve; EN/PT switch works on every page (tag pages excepted: tag names differ by language).
- Privacy: no email, phone or address in content, docs or git history; commits use the GitHub noreply address;
  all images (current and every past version in git history) have no EXIF/GPS/XMP.
  Owner chose to keep the mention of his mother on the Duna page and the family context of Family Finance.
- `languages.*.toml`: `languageCode`/`languageName` replaced by `locale` (`en`, `pt-BR`) / `label`. No more build warnings;
  `og:locale` is now `pt_BR`.
- Experience badges shortened to years only (`2022–2025`) so they fit on phones.
- GitHub added to the footer menu and the author links (both languages).
- SEO: site `description` per language (`[params]` in `languages.*.toml`); `description` front matter on About,
  Experience and Skills; `defaultSocialImage = "img/avatar.jpg"` for pages without a feature image;
  home page title (used by Open Graph) "Mr. Rizzo · Systems, AI & 3D" / "Mr. Rizzo · Sistemas, IA e 3D".
  The browser tab on the home page still shows the site title "Mr. Rizzo" (Blowfish uses `.Site.Title` there).
- Hobbies description no longer mentions cooking (hidden). Typos fixed: macro gallery title, Duna PT text.
- robots.txt and sitemap.xml checked: sitemap lists only public pages (no `thanks/`, tags or drafts).

### 2026-10-30 (stage 10: Deploy)
- `.github/workflows/hugo.yml`: official GitHub Pages flow (configure-pages, upload-pages-artifact, deploy-pages),
  Hugo extended 0.167.0 pinned, submodules checked out, `resources/_gen` cached. Pages source set to GitHub Actions.
- Full build tested with Hugo 0.167.0 before publishing (about 2 min without cache).
- `mainSections = ["projects"]` (blog removed); `showRecent` kept on.
- Custom favicon set in `static/` (+ `site.webmanifest` with site name and dark theme color).
- Tested on the live site: contact form in EN and PT (email arrives under the Gmail label, thanks page),
  `/contact/` link from Family Finance in both languages.

### 2026-10-30 (stage 9: Contact)
- `content/contact/` (EN/PT): badge, intro, location and languages line, channel cards, form.
- `content/thanks/` (EN/PT): confirmation page after sending; `noindex`, not listed, not in the sitemap.
- New shortcodes: `rz-contact-cards` + `rz-contact-card` (clickable cards with Blowfish icons),
  `rz-contact-form` (Web3Forms form, hCaptcha + honeypot, redirect to `thanks/` of the current language).
- Contact styles appended to `assets/css/custom.css`.
- Blog decision changed: it will not live in this repository.

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
