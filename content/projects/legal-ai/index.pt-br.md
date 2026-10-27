---
title: "IA jurídica"
summary: "Em andamento · POC de RAG totalmente local sobre decisões reais do Supremo Tribunal Federal (STF), projetado para que toda afirmação cite uma decisão real."
date: 2026-10-26
weight: 10
tags: ["IA", "RAG", "Python", "Ollama", "IA local"]
---

{{< badge >}}Em andamento{{< /badge >}}

**AI_Juridico** é uma prova de conceito (POC) que estou construindo para explorar até onde um sistema de IA totalmente local consegue ir em pesquisa jurídica.

O objetivo é um pipeline de RAG (retrieval-augmented generation) que sintetize decisões do Supremo Tribunal Federal (STF) e redija pareceres. Ele é projetado para que toda citação possa ser rastreada até uma decisão real, de modo que o sistema não consiga inventar referências.

## Princípios do projeto

- **Somente dados reais de tribunal.** Bases sintéticas foram descartadas de propósito.
- **Execução totalmente local** em uma única GPU de uso doméstico (RTX 4080 SUPER), com Ollama e modelos open-weight. Sem APIs na nuvem.
- **Metas de avaliação objetivas**, incluindo zero citações inventadas.

## O que já está pronto

Um pipeline automatizado que coleta decisões, baixa o inteiro teor no portal do STF e divide cada documento em suas seções jurídicas (ementa, relatório, voto, acórdão). O pipeline já processou as 51 decisões do conjunto de validação; a revisão de acurácia campo a campo está em andamento. A extração gera registros estruturados em JSONL, prontos para chunking e embeddings.

## O plano

1. Definição de escopo: **concluída**
2. Coleta de dados do STF e validação: **concluída**
3. Extração estruturada: **em andamento**
4. Chunking jurídico
5. Embeddings e vector store
6. Pipeline de RAG
7. Síntese e minuta de parecer
8. Interface (Open WebUI)
9. Avaliação com métricas objetivas
10. Deploy local com Docker

## Stack

Python · Playwright · PyMuPDF · Ollama (Qwen3) · embeddings bge-m3 · ChromaDB · Open WebUI · Docker · Git
