Welcome to the **Jetson flash playbook cheat-sheet wiki**.

> Canonical sources live in git on `main`; this wiki is intentionally short so students + AI copilots can skim fast. When details disagree, **[the repo Markdown](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/tree/main)** wins.

![Three-phase Jetson flashing overview](./images/phases-overview.svg)

## Read this first

| Need | Canonical doc |
|------|---------------|
| Happy-path timeline (“downloads before wiring Recovery”) | [`docs/START_HERE.md`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/blob/main/docs/START_HERE.md) |
| Symptom → fix lookup | [`docs/jetson/troubleshooting.md`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/blob/main/docs/jetson/troubleshooting.md) |
| “What option do I choose?” bursts | [`docs/jetson/faq.md`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/blob/main/docs/jetson/faq.md) |
| Exhaustive scripted flow | [`docs/jetson/flash-runbook.md`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/blob/main/docs/jetson/flash-runbook.md) |
| Morale + multi-hour journaling | [`docs/jetson/bring-up-journey.md`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/blob/main/docs/jetson/bring-up-journey.md) |

## Using assistants / LLMs

Attach or index the Markdown files linked above (plus whatever lives in [`docs/meta/`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/tree/main/docs/meta)) inside your IDE prompts so tooling cites **committed lab facts**, not improvised forum anecdotes.

## Three phases (mental model)

1. **Phase 1 — Host only:** downloads, APT checks; Jetson offline OK.
2. **Phase 2 — Recovery:** regulated DC jack, flashing Type‑C cable, hold **FORCE REC**.
3. **Phase 3 — Flash:** wait for SDK Manager banner, reboot, optionally install payloads.

## Maintainer sync

Markdown + diagram source for this wiki lives inside the repo [`wiki/` tree](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/tree/main/wiki). Follow [`docs/publishing-github-wiki.md`](https://github.com/Robots-Rnt-Us/jetson-flash-playbook/blob/main/docs/publishing-github-wiki.md) before force-pushing.
