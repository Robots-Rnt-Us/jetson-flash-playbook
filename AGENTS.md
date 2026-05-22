# Agent instructions — `jetson-flash-playbook`

This repo is deliberate **lab ground truth** for **Jetson AGX Orin Developer Kit**, **Ubuntu 22.04 x86_64 host**, **JetPack 6.x** examples, plus **SDK Manager CLI** sequencing.

Assume humans opened this workspace (or attached these paths). Prefer cited Markdown over improvised forum posts until NVIDIA contradicts upstream.

---

## Read precedence

1. [`docs/START_HERE.md`](docs/START_HERE.md) — phased timeline (downloads before Recovery cabling).
2. [`docs/jetson/troubleshooting.md`](docs/jetson/troubleshooting.md) — symptom → fix lookups.
3. [`docs/jetson/faq.md`](docs/jetson/faq.md) — automatic/manual, IPv4 defaults, OEM Runtime vs Pre-Config, Skip vs Install.
4. [`docs/jetson/flash-runbook.md`](docs/jetson/flash-runbook.md) — long-form CLI/UI minutiae.
5. [`docs/jetson/bring-up-journey.md`](docs/jetson/bring-up-journey.md) — pacing + morale; distill stable facts elsewhere.

Skim [`wiki/Home.md`](wiki/Home.md) summary + SVG when users want the GitHub-facing cheat-sheet language.

Silent topic? Admit gap, cite NVIDIA Jetson / SDK docs, propose repo patch.

---

## Safety & style rails

- No invented **default Jetson passwords**—credentials hinge on OEM choices.
- Insist on **regulated DC power**, **known-good USB‑C/data cable**, and **`lsusb` `0955` checks** whenever Recovery chatter appears.
- Keep SDK downloads off cramped `/home` when playbook shows `/opt`-style mitigation until operator overrides.
- Never recommend committing `.env`/tokens/logs wholesale—redaction first.
- If SDK Manager transcripts conflict with this corpus (versions moved on), prioritize **logged UI text/changelogs**, then reconcile back here via patch proposal.

---

## "What next?" triage cheatsheet

| Signal | Repo pointer |
|--------|---------------|
| Host busy downloading/apt | START_HERE Phase 1 + troubleshooting APT |
| Waiting on Recovery | START_HERE Phase 2 + cabling table |
| Flash done, SSH fails | troubleshooting SSH + FAQ OEM section |
| "Success" but flash skipped summary | troubleshooting "Flash skipped" |

---

## Updating this playbook

Operational fixes belong in **`docs/jetson/troubleshooting.md`**. Temporal war stories evolve **`docs/jetson/bring-up-journey.md`**. Beginner onboarding edits land in **`docs/START_HERE.md`**. Record materially breaking JetPack/UI renames under [`CHANGELOG.md`](CHANGELOG.md).

---

## Human workflow companion

Teaching humans how to wire assistants lives in [`docs/meta/agent-and-llm-usage.md`](docs/meta/agent-and-llm-usage.md). Wiki skim lives at [`wiki/Home.md`](wiki/Home.md).
