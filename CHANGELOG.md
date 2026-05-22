# Changelog

All notable documentation revisions should be summarized here.

## 0.5.0 — 2026-05-23

- Added **`wiki/`** mirror for the GitHub Wiki (`Home.md`, `_Sidebar.md`, [`Ninety-second-cheatsheet.md`](wiki/Ninety-second-cheatsheet.md), [`wiki/images/phases-overview.svg`](wiki/images/phases-overview.svg)) plus [`docs/publishing-github-wiki.md`](docs/publishing-github-wiki.md) and [`scripts/sync-github-wiki.sh`](scripts/sync-github-wiki.sh) for maintainers with `.wiki.git` access.

## 0.4.0 — 2026-05-23

- Added **[AGENTS.md](AGENTS.md)** and **[docs/meta/agent-and-llm-usage.md](docs/meta/agent-and-llm-usage.md)** so assistants ingest read-order/policy before improvising NVIDIA forum advice; README/`START_HERE`/`CONTRIBUTING`/documentation-strategy pointers updated accordingly.

## 0.3.0 — 2026-05-22

- Added [docs/START_HERE.md](docs/START_HERE.md): beginner-first timeline (downloads on host versus Recovery wiring), physical kit checklist, NVMe caution, Ubuntu Wi‑Fi/Chromium/SSH helpers, condensed flowchart aligned with externally reviewed guidance plus lab reality.
- Simplified README to route through `START_HERE.md` plus a compact phase diagram teaser.
- Pointed contributing / flash-runbook / FAQ / troubleshooting / journey pages at the new onboarding spine.

## 0.2.0 — 2026-05-22

- Added [docs/jetson/bring-up-journey.md](docs/jetson/bring-up-journey.md), a chronological "whole journey" companion to the distilled runbook/troubleshooting pages.
- Added [docs/meta/documentation-strategy.md](docs/meta/documentation-strategy.md) on using Git/GitHub versus wikis, Notion/static sites, and hybrid patterns.
- Cross-linked README, [flash-runbook.md](docs/jetson/flash-runbook.md), and [troubleshooting.md](docs/jetson/troubleshooting.md) to the narrative for mixed-skill teams.

## 0.1.1 — 2026-05-22

- Added [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) and README link for reviewer/wiki workflow.

## 0.1.0 — 2026-05-22

- Initial playbook: README quick path,
  [flash-runbook.md](docs/jetson/flash-runbook.md),
  [troubleshooting.md](docs/jetson/troubleshooting.md),
  [post-flash-checklist.md](docs/jetson/post-flash-checklist.md),
  [faq.md](docs/jetson/faq.md).
- Captures lessons from JetPack 6.2.2 + SDK Manager 2.4.x bring-up on Ubuntu 22.04 host.
