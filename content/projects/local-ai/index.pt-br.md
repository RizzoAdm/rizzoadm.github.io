---
title: "IA local"
summary: "Em andamento · Uma stack de IA self-hosted com modelos locais, um time de agentes e memória de longo prazo compartilhada. Sem APIs de IA na nuvem."
date: 2026-10-26
weight: 20
tags: ["IA", "Ollama", "Agentes", "IA local"]
---

{{< badge >}}Em andamento{{< /badge >}}

Uma stack de IA self-hosted rodando em hardware local. O Ollama serve modelos open-weight; o Hermes Agent orquestra um time de agentes especializados no CrewAI (pesquisador, redator e crítico) com memória de longo prazo compartilhada em um servidor Mem0 apoiado no Qdrant. O acesso é pelo Open WebUI, por uma interface de chat bot e pelo gerenciador de agentes Paperclip.

Sem APIs de IA na nuvem: modelos e memória ficam no hardware local.

## Hardware

- **Sistema:** Ubuntu
- **CPU:** AMD Ryzen 9 5950X
- **RAM:** 32 GB
- **GPU:** NVIDIA RTX 4080 SUPER (16 GB de VRAM)

## Modelos

| Modelo | Uso |
|---|---|
| gemma4:26b · gemma4:12b | Uso geral |
| gpt-oss:20b (contexto de 64k) | Uso geral, contexto longo |
| qwen3.8:27b · qwen3:14b | Uso geral |
| qwen3-coder:30b · qwen2.5-coder:14b | Código |
| deepseek-r1:14b | Raciocínio |

## Stack

Ollama · Open WebUI · Hermes Agent · CrewAI · Mem0 · Qdrant · Paperclip · Docker
