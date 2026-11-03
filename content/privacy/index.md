---
title: "Privacy Policy"
description: "How rizzoadm.github.io and the owner's private Google Drive backup app handle data: no analytics, no ads, no data sold or shared."
showDate: false
showDateUpdated: false
showReadingTime: false
showWordCount: false
showAuthor: false
showTableOfContents: false
showPagination: false
sharingLinks: false
---

**Last updated:** November 3, 2026

This policy covers two things run by Mr. Rizzo: this website, **rizzoadm.github.io**, and **Arquivos pessoais e backups gerais**, a private Google API application used only by the site owner to back up his own files to his own Google Drive. Questions about this policy can be sent through the [Contact](/contact/) page.

## This website

**No tracking.** This site has no user accounts, no analytics, no advertising and no tracking cookies. Nothing you do here is used to build a profile of you.

**Hosting.** The site is a set of static files hosted on [GitHub Pages](https://pages.github.com/). Like any web host, GitHub may process technical data such as your IP address to deliver the pages and keep the service secure. See the [GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement).

**Browser storage.** The site theme may save display preferences (such as language) in your browser's local storage. This data stays on your device and is never sent to the site owner.

**Contact form.** If you send a message through the [Contact](/contact/) page, the name, email address and message you type are delivered to the site owner's inbox by [Web3Forms](https://web3forms.com/privacy). They are used only to reply to you, are never sold or shared, and you can ask for your message to be deleted at any time. The form uses [hCaptcha](https://www.hcaptcha.com/privacy) to block spam, which processes technical data from your browser for that purpose only.

**Embedded videos.** Some project pages show videos hosted on Vimeo (with "do not track" enabled) or YouTube (in privacy-enhanced mode). These services may process data when you play a video, under their own policies: [Vimeo](https://vimeo.com/privacy) and [Google/YouTube](https://policies.google.com/privacy).

**Links to other sites.** Links to LinkedIn, GitHub and other sites lead to services with their own privacy policies.

**Photos.** Every photo published on this site has its hidden metadata (EXIF, including GPS location) removed before publication.

## Google Drive backup app ("Arquivos pessoais e backups gerais")

**What it is.** A private OAuth client registered in Google Cloud and used with [rclone](https://rclone.org/), an open-source command-line tool, so the site owner can back up, sync and restore **his own files** between his own computer and **his own Google Drive**. It is not offered to the public, has no other users and has no website, server or database of its own.

**Google user data accessed.** Through the Google Drive API, and only with the permissions granted on Google's consent screen, the app can list, read, create, update and delete files and folders in the owner's Google Drive (file contents, names, folders and file metadata such as size and modification date).

**How the data is used.** Only to perform the backup, sync and restore operations the owner runs on his own computer. The data is not used for advertising, profiling or market research, and is not used to train AI or machine learning models.

**How the data is stored.** Files travel directly between Google Drive and the owner's computer over encrypted connections (HTTPS). The access token issued by Google is stored only in the rclone configuration file on the owner's computer. No copy of Drive data or tokens is kept anywhere else.

**Sharing.** Google user data is never sold, shared with or transferred to any third party.

**Limited Use.** The use and transfer of information received from Google APIs by Arquivos pessoais e backups gerais to any other app will adhere to the [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy), including the Limited Use requirements.

**Revoking access and deleting data.** Access can be revoked at any time at [Google Account → Third-party connections](https://myaccount.google.com/connections). Revoking access or deleting the rclone configuration removes the stored token; files in Google Drive remain under the control of the Drive account owner.

## Changes to this policy

If this policy changes, the new version is published on this page with a new "Last updated" date.

## Contact

Use the [Contact](/contact/) page. No personal email address is published on this site.
