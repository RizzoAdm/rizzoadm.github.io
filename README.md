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
| `assets/`          | Images and custom color schemes processed by Hugo       |
| `content/` | Pages and posts |
| `static/` | Files served as-is |
| `themes/blowfish/` | Theme (submodule) |
| `docs/` | Project notes and progress log (not rendered) |

## Status

Under construction. Not yet deployed.