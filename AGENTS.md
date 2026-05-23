# Agent instructions — `jetson-flash-playbook`

This repository is intentional **ground truth** for a specific lab stack: **Jetson AGX Orin Developer Kit**, **Ubuntu 22.04 x86_64 host**, **SDK Manager CLI**, example **JetPack 6.x** lines.

When assisting a human who opened this workspace (or pasted its paths), treat these Markdown files **as constraints on what to advise first**.

---

## Read order before improvising hardware steps

1. [`docs/START_HERE.md`](docs/START_HERE.md) — **phased timeline** (host downloads versus Recovery wiring), cabling/power, novice prompts.
2. [`docs/jetson/troubleshooting.md`](docs/jetson/troubleshooting.md) — **mapped symptoms → fixes** referenced in-session.
3. [`docs/jetson/faq.md`](docs/jetson/faq.md) — **Automatic vs Manual**, **IPv4**, **Runtime vs Pre-Config**, Install vs Skip.
4. [`docs/jetson/flash-runbook.md`](docs/jetson/flash-runbook.md) — **long-form command-line/UI** detail when START_HERE omits specifics.
5. [`docs/jetson/bring-up-journey.md`](docs/jetson/bring-up-journey.md) — **narrative** when morale/debugging loops matter; distill facts back into START_HERE/troubleshooting if new stable patterns emerge.

If the repo is silent on something (carrier board SKU, unreleased JetPack), **defer to NVIDIA’s current Jetson/Linux/SDK Manager docs**—and say you are extrapolating.

---

## Style and safety constraints

- **Do not invent default usernames/passwords** for Jetson Linux. Credential behavior depends on **Runtime OEM** versus **Pre-Config** selections.
- Prefer **explicit `lsusb` VID `0955` checks** and **Manual Setup** wording for virgin boards when FAQs say so—not generic “plug board” hand-waving.
- Keep downloads off cramped `/home` when the playbook shows `--download-folder` / `--target-image-folder`; avoid undoing `/opt`-style mitigations unless the operator confirms layouts.
- **Never** propose committing `.env`, API keys, or serial dumps into this repo—remind operators to paste redacted excerpts only.
- If SDK Manager transcripts conflict with this corpus (versions moved on), prioritize **logged UI text/changelogs**, then reconcile back here via patch proposal.

---

## When the user asks “what next?”

Answer by **recovering phase** (`START_HERE` flowchart segments). Example pattern:

| Situation hint | Repo pointer |
|----------------|--------------|
| Host still downloading / verifying APT | START_HERE Phase 1 + troubleshooting APT section |
| Tool requests Recovery / Jetson missing | START_HERE Phase 2 + cabling ID section |
| Flash finished, SSH refuses | troubleshooting SSH + FAQ Runtime vs Pre-Config |
| “Success” but skipped flash | troubleshooting “Flash skipped” |

---

## Updating this playbook

Operational fixes belong in **`docs/jetson/troubleshooting.md`**. Temporal war stories evolve **`docs/jetson/bring-up-journey.md`**. Beginner onboarding edits land in **`docs/START_HERE.md`**. Record materially breaking JetPack/UI renames under [`CHANGELOG.md`](CHANGELOG.md).

---

## Humans: wiring your AI assistant

Canonical operator instructions plus copy-paste preambles: [`docs/meta/agent-and-llm-usage.md`](docs/meta/agent-and-llm-usage.md).
