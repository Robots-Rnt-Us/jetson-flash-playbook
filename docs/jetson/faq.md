# FAQ — Jetson flashing with SDK Manager

If you arrived before reading the phased guide, skim [START_HERE.md](../START_HERE.md) once—FAQ entries below assume those ordering concepts.

---

## Automatic vs Manual setup?

| Mode | Typical use |
|------|-------------|
| **Automatic** | Board already boots Linux and credentials exist for SDK Manager probing |
| **Manual** | First-time flash via USB recovery |

First-time flashing almost always aligns with **Manual**.

---

## IPv4 vs IPv6?

Prefer **IPv4** unless IPv6-only network.

---

## What IP is `192.168.55.1`?

SDK Manager defaults often relate to gadget / usbNCM style host↔Jetson linkage. Exact roles can vary; treat as provisional default and adjust if pings fail.

---

## Pre-Config vs Runtime OEM?

| Option | Outcome |
|--------|---------|
| **Pre-Config** | Credentials & basic OEM choices applied before first full boot path |
| **Runtime** | Standard first-boot wizard on Jetson console |

If Runtime wizard stalls for hours, reflash with **Pre-Config**.

---

## Do I invent username/password mid-wizard?

- **Runtime** — Finish OEM on Jetson, then reuse that account inside SDK Manager.
- **Pre-Config** — Use the deliberate username/password SDK Manager prompts for (those become Jetson credentials).

Avoid using board marketing labels as SSH usernames.

---

## Flash succeeded — Install or Skip extras?

Choose **Skip** when:

- Offline environment or iterative bring-up scheduling.
- You only needed clean OS baseline.

Choose **Install** when:

- You want NVIDIA runtime/meta packages staged now.
- Networking + credentials validated.

Skipping is safe—you can rerun SDK Manager omitting redundant host components.

---

## When does `--flash` still skip flash?

Selections inside UI overriding flash, rerun confusion, abort before flash stage triggers. Inspect final summary rows.

---

## Do I install Jetson Multimedia API always?

Install only workloads requiring it—it increases download time footprint.
