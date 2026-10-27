---
title: "Local AI"
summary: "In progress · A self-hosted AI stack with local models, a team of agents and shared long-term memory. No cloud AI APIs."
date: 2026-10-26
weight: 20
tags: ["AI", "Ollama", "Agents", "Local AI"]
---

{{< badge >}}In progress{{< /badge >}}

A self-hosted AI stack running on local hardware. Ollama serves open-weight models; Hermes Agent orchestrates a CrewAI team of specialized agents (researcher, writer, critic) with shared long-term memory on a Mem0 server backed by Qdrant. It is accessible through Open WebUI, a chat bot interface and the Paperclip agent manager.

No cloud AI APIs: models and memory stay on local hardware.

## Hardware

- **OS:** Ubuntu
- **CPU:** AMD Ryzen 9 5950X
- **RAM:** 32 GB
- **GPU:** NVIDIA RTX 4080 SUPER (16 GB VRAM)

## Models

| Model | Use |
|---|---|
| gemma4:26b · gemma4:12b | General purpose |
| gpt-oss:20b (64k context) | General purpose, long context |
| qwen3.8:27b · qwen3:14b | General purpose |
| qwen3-coder:30b · qwen2.5-coder:14b | Code |
| deepseek-r1:14b | Reasoning |

## Stack

Ollama · Open WebUI · Hermes Agent · CrewAI · Mem0 · Qdrant · Paperclip · Docker
