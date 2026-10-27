---
title: "Family Finance"
summary: "Two countries, two currencies, one spreadsheet. A local-first system that turns statements from 16 accounts into audited dashboards, with local LLMs that only suggest."
date: 2026-10-26
weight: 30
tags: ["Python", "Local AI", "Ollama", "LLM", "Google Sheets", "Automation"]
---

Family finances across two countries and two currencies run on one spreadsheet, and every number in it is audited.

It is a local-first system that turns bank and card statements from 16 accounts into one consolidated cash-flow view, in CAD and BRL. Deterministic code does every calculation; a local LLM only suggests categories, and a human confirms.

*All screens on this page use fictitious values, for system demonstration only.*

## What it does

- Reads 20 statement sources (CSV, OFX and digital PDF) with 13 deterministic parsers
- Converts BRL, USD and EUR to CAD at the Bank of Canada rate of each transaction day
- Pairs card payments, internal transfers and international remittances, so nothing is counted twice
- Categorizes by rules; for the rest, three local LLMs on Ollama vote, and only a unanimous answer becomes a suggestion
- Rebuilds the Google Sheets dashboards on every run: annual cash flow, per person, debts (principal vs. interest), investments against target allocation, and charts
- Audits every run with 4,302 independent checks

## How it works

One command runs the whole pipeline. The LLM touches exactly one step, and never the numbers.

![The seven steps of the pipeline](how-it-works.jpg)

## The spreadsheet

**Transactions.** One row per statement line. BRL converted to CAD at the rate of the day; transfers and card payments paired so nothing counts twice.

![Transactions tab](transactions.jpg)

**Annual dashboard.** Cash in, cash out and what is left, consolidated in CAD.

![Annual dashboard](annual-dashboard.jpg)

**Annual by person.** Each expense belongs to the holder of the account it left from, so it is easy to see early if one person is running negative.

![Annual by person](annual-by-person.jpg)

**Debts.** Each debt split into principal and interest, and how much of the income they take every month.

![Debts](debts.jpg)

**Investments.** Grouped by asset class, type and asset, with a target percentage for each and how much is missing or over.

![Investments](investments.jpg)

**Charts.** Native Google Sheets charts fed by the dashboards, each one following the period selector of its own panel.

![Charts](charts.jpg)

## Local LLMs suggest. Code decides.

Every amount, sum, currency conversion and pairing is handled by deterministic Python. The models touch exactly one step: proposing a category for merchants the rules don't cover yet.

- Three local models on Ollama (gemma4:12b, gemma4:26b and gpt-oss:20b) answer the same queue
- Only a unanimous answer becomes a suggestion; split votes are shown with every model's answer
- Output is structured and restricted to a closed list of 67 categories, at temperature 0
- Categories that depend on intent (gifts, kids' outings, insurance type) are blocked by code before the vote
- The prompt carries the merchant name, account type and similar rules, never an amount
- A suggestion becomes a rule only when a human ticks Confirm in the Review tab

![Review tab with LLM suggestions](review.jpg)

**How the setup was chosen.** Seven model configurations were measured in a leave-one-out test against 114 categorization rules written by a human. Single models landed between 75% and 86% precision. The unanimous vote of three models from two families, plus the block list, reached 97.6% precision with 73% coverage; the remaining items become "don't know" instead of a wrong answer. Reasoning mode did not improve precision for this task, and adding more examples made it worse. The test precision is an upper bound, since the block list was picked on the same data; the real acceptance rate is tracked on every confirmation.

![A real run: three local models voting, with the GPU at work](models-vote.jpg)

## Every run ends with an audit

A dashboard that looks right isn't the same as one that is right. After the dashboards are rebuilt, a read-only script recalculates everything from the local master files and compares it with the sheet, at a tolerance of one cent: 4,302 checks, all of which must match.

- **A.** Every transaction in the sheet against the local master file
- **B.** Every cell of the dashboards, recomputed in Python
- **C.** The annual totals again, through an independent calculation with its own rules
- **D.** The money identity: the monthly surplus equals the sum of every account, and both sides of each transfer cancel out
- **E.** Coverage: no missing statement or month for any account
- **F.** Investments and chart data against their sources
- **G.** A human check: the last balance of each account and random transactions to compare with the statements

The audit writes nothing and fixes nothing: it reports which layer failed and by how much. The first full run found one real mismatch, an internal BRL transfer that left on one day and arrived three days later, at a different exchange rate. The fix went into the rule, not into an exception list. The audit has its own tests: 29 cases and 38 deliberately injected bugs, all caught.

![A real audit run (output in Portuguese)](audit-terminal.jpg)

## By the numbers

Built with Claude Code as the engineering partner.

- ~25,600 lines of Python, more than half of it tests and mutation scripts
- 718 test cases; 204 deliberately injected bugs, all caught
- 75 commits in 16 days
- 41 hours of commit activity (time between commits only)
- ~60 hours of Claude Code sessions and ~4M tokens of context (both estimates)

![By the numbers](by-the-numbers.jpg)

## What it doesn't do

- Connect to banks or store bank credentials; statements are downloaded and dropped into a watched folder
- Let an LLM read amounts, do math or create rules
- Send financial data to any cloud AI service
- Move money or make investment decisions

The repository is private, since it holds a family's real configuration. If a generalized public version would be useful to you, get in touch through the [Contact](/contact/) page.

## Stack

Python · Ollama (gemma4, gpt-oss) · Google Sheets API · systemd · Bank of Canada exchange rates · Claude Code · Git
