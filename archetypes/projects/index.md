---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
summary: "TODO: one short sentence for the card. Start with 'In progress · ' if the project is not finished."
date: {{ .Date | time.Format "2006-01-02" }}
weight: 999
tags: ["TODO"]
---

{{"{{"}}< badge >{{"}}"}}In progress{{"{{"}}< /badge >{{"}}"}}

TODO: what the project is and why it exists (2–3 sentences). Delete the badge line above if it is finished.

## What it does

- TODO

## Stack

TODO · TODO · TODO

<!-- Images, gallery and video: see docs/manual-conteudo.md (section "Trechos prontos"). -->
