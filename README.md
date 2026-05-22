# Jetson flash playbook — Robots-Rnt-Us lab

Operational docs for **Jetson AGX Orin Developer Kit** + **Ubuntu 22.04 x86_64 flashing PC** using **JetPack 6.x** and **SDK Manager**.

---

## New here? Start in one place

1. Open **[docs/START_HERE.md](docs/START_HERE.md)** — phased timeline, checklist, wiring notes, NVMe reminder, Wi‑Fi/Chromium/SSH snippets, embedded **flowchart**.
2. Keep **[docs/jetson/troubleshooting.md](docs/jetson/troubleshooting.md)** nearby when something breaks.
3. Read **[docs/jetson/bring-up-journey.md](docs/jetson/bring-up-journey.md)** if you need reassurance that messy sessions are ordinary.

Tiny preview of phases (same diagram renders inside `START_HERE.md`):

```mermaid
flowchart LR
  P1["Phase 1 Host downloads unpack"] --> P2["Phase 2 Power USB Recovery"]
  P2 --> P3["Phase 3 Flash reboot optional SSH packages"]
```

---

## Repo map

| Doc | Audience |
|-----|----------|
| [docs/START_HERE.md](docs/START_HERE.md) | First-time flashes; wants order-of-operations clarity |
| [docs/jetson/flash-runbook.md](docs/jetson/flash-runbook.md) | Exhaustive scripted CLI / UI choices |
| [docs/jetson/troubleshooting.md](docs/jetson/troubleshooting.md) | Error symbology ⇢ mitigations matrix |
| [docs/jetson/faq.md](docs/jetson/faq.md) | Instant answers Automatic/Manual, Runtime/pre-config … |
| [docs/jetson/post-flash-checklist.md](docs/jetson/post-flash-checklist.md) | Post-power validation |
| [docs/meta/documentation-strategy.md](docs/meta/documentation-strategy.md) | Why Git-first + wiki mirroring guideline |
| [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) | Maintainer workflow + changelog rules |

JetPack **6.2.2**, SDK Manager **2.4.x** strings appear as examples — adjust per release cadence and capture notes in CHANGELOG whenever NVIDIA renames dialogs.

---

## Optional GitHub CLI helpers

Authentication:

```bash
gh auth login -h github.com
```

List repos for the owning org:

```bash
gh repo list Robots-Rnt-Us --limit 20
```

---

## Licensing & safety

Markdown is **CC BY-SA 4.0** (see [`LICENSE`](LICENSE)).

Never paste production passwords, SSO tokens, or raw serial dumps into Issues/PR descriptions—use `[REDACTED]` placeholders.
