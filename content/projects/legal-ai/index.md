---
title: "Legal AI"
summary: "In progress · A fully local RAG proof of concept over real decisions from Brazil's Supreme Federal Court (STF), designed so every claim cites a real ruling."
date: 2026-10-26
weight: 10
tags: ["AI", "RAG", "Python", "Ollama", "Local AI"]
---

{{< badge >}}In progress{{< /badge >}}

**AI_Juridico** is a proof of concept I'm building to explore how far a fully local AI system can go in legal research.

The goal is a RAG (retrieval-augmented generation) pipeline that synthesizes decisions from Brazil's Supreme Federal Court (STF) and drafts legal opinions. It is designed so that every citation can be traced back to a real ruling, which means the system cannot invent references.

## Design principles

- **Real court data only.** Synthetic datasets were deliberately ruled out.
- **Fully local execution** on a single consumer GPU (RTX 4080 SUPER), using Ollama and open-weight models. No cloud APIs.
- **Objective evaluation targets**, including zero hallucinated citations.

## What is built so far

An automated pipeline that collects decisions, downloads the full-text rulings from the STF portal and splits each document into its legal sections (*ementa*, *relatório*, *voto*, *acórdão*). The pipeline has processed all 51 decisions of the validation set; a field-level accuracy review is underway. The extraction produces structured JSONL records, ready for chunking and embedding.

## The plan

1. Scope definition: **done**
2. Data collection from the STF and validation: **done**
3. Structured extraction: **in progress**
4. Legal-aware chunking
5. Embeddings and vector store
6. RAG pipeline
7. Synthesis and draft opinions
8. Interface (Open WebUI)
9. Evaluation with objective metrics
10. Local deployment with Docker

## Stack

Python · Playwright · PyMuPDF · Ollama (Qwen3) · bge-m3 embeddings · ChromaDB · Open WebUI · Docker · Git
