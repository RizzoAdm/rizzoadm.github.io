---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
summary: "TODO: uma frase curta para o card. Comece com 'Em andamento · ' se o projeto não terminou."
date: {{ .Date | time.Format "2006-01-02" }}
weight: 999
tags: ["TODO"]
---

{{"{{"}}< badge >{{"}}"}}Em andamento{{"{{"}}< /badge >{{"}}"}}

TODO: o que é o projeto e por que existe (2–3 frases). Apague a linha do badge acima se ele estiver concluído.

## O que faz

- TODO

## Stack

TODO · TODO · TODO

<!-- Imagens, galeria e vídeo: veja docs/manual-conteudo.md (seção "Trechos prontos"). -->
