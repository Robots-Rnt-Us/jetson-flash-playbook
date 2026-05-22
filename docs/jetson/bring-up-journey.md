# Real-world bring-up journal — AGX Orin via SDK Manager

This page records an **actual multi-hour bring-up** on an Ubuntu 22.04 x86 host flashing a **Jetson AGX Orin (64 GB Developer Kit)** with **JetPack 6.2.2** via **SDK Manager CLI 2.4.x**. It is written so the next person recognizes *patterns* when their screen does not match glossy quick-start guides.

Operational checklists live in [flash-runbook.md](flash-runbook.md) and [troubleshooting.md](troubleshooting.md). This file is the **story + sequence of dead ends and fixes**.

---

## Cast of characters

| Role | Detail |
|------|--------|
| Host OS | Ubuntu 22.04, separate `/` (~130 GB) and `/home` (~69 GB) partitions |
| Tooling | `sdkmanager` CLI, NVIDIA Developer (`devzone`) login |
| Board | Jetson AGX Orin Developer Kit flavor (recovery USB IDs migrated during session) |

Naming is sanitized: anytime you saw a label that looked like a **product hostname**—for example tied to “Orin … DevKit”—that string is **not** your Linux SSH username unless you explicitly created an account with that exact login.

---

## Act I — Disk space is not where you think

**Symptom.** Initial checks showed tens of gigabytes consumed under `$HOME`; free space on `/home` was borderline for SDK Manager’s comfort zone.

**Trap.** `du -sh $HOME` reports *usage*, not *free space*. The real gate is `df -h` on the filesystem that will hold downloads and unpacked images.

**Partial fix.** Removing large NVIDIA artifacts under `~/Downloads` and `~/nvidia/nvidia_sdk` freed enough headroom that a *minimal* flash seemed possible.

**Why it still hurt.** Host **root** (`/`) had plenty of space while `/home` stayed tight. SDK Manager’s default layout prefers paths under `$HOME` unless you override it.

**Resolution that stuck.** Create owned directories on a large partition and **always** pass both flags:

```bash
mkdir -p /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
sudo chown -R "$USER:$USER" /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
```

```bash
sdkmanager ... \
  --download-folder /opt/nvidia/sdkm_downloads \
  --target-image-folder /opt/nvidia/nvidia_sdk
```

**Micro-nag (“needs another 2 MB”).** After moving paths, a tiny residual warning can still appear because of buffers, rounding, or an old code path still touching `$HOME`. The lesson: **paste the full command** the tool prints *with* your overrides; do not relaunch a shortened copy.

---

## Act II — Host readiness: APT and a local CUDA repo key

**Symptom.** SDK Manager “system readiness” failed running `apt-get update && apt-get check` with exit code 100.

**Log tell.** `NO_PUBKEY` for a **file:** URI under `/var/l4t-cuda-repo-ubuntu2204-*-local` (example fingerprint seen: `6101062BDFC407FB`).

**Fix that worked.** Import the published key material from that local repo into the system keyrings, then refresh:

```bash
sudo mkdir -p /usr/share/keyrings
sudo cp /var/l4t-cuda-repo-ubuntu2204-12-6-local/*.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get check
```

(Adjust the repo folder glob if your JetPack/apt layout differs.)

**Lesson.** Flash tooling assumes your **host package manager is clean** before it layers more packages. Fixing APT is prerequisite noise—but it blocked everything until resolved.

---

## Act III — “Automatic setup” expects a user that does not exist

**Symptom.** SDK Manager attempted SSH to the Jetson at a typical gadget-style IPv4 (`192.168.55.x`) using a username that visually matched board branding—not a UNIX account—and failed with:

`Permission denied (publickey,password)`

**Trap.** Automatic flows assume Jetson Linux is already up **and** reachable with valid credentials.

**Decision.** Switch to **Manual Setup** grounded in recovery mode flashing for first-time silicon.

---

## Act IV — Manual recovery, USB identity drift, mismatched profiles

**Symptom intermittent.** `lsusb | grep 0955` showed an NVIDIA device, yet SDK Manager still complained it could not find the **correct** Jetson for the chosen profile—sometimes after seeing one USB product id during an earlier phase and another (`0955:7020` vs `0955:7023` style) later.

**Interpretation.** VID/PID can change with mode (recovery vs runtime) and cable/port quality matters.

**Resolution pattern.**

1. Enter **Force Recovery** deliberately.
2. Use the **developer kit specific** manual profile line (64 GB dev kit wording), not a generic superset that happens to be listed nearby.
3. Select the single **Recovery | 0955:…** row the tool offers.
4. Confirm **Yes, flash** only when that row is stable.

---

## Act V — The flash lands

**Log anchor.** When you finally see a line in the spirit of:

`*** The target generic has been flashed successfully. ***`

followed by instructions to reset and boot from internal eMMC—you have crossed the hardware barrier.

**What still remains.** OS image on module ≠ finished lab: first boot, accounts, networking, and optional SDK payload on target.

---

## Act VI — OEM configuration: Runtime vs Pre-Config in the real world

**Runtime path expectation.** You finish a first-boot wizard on a display attached to Jetson, define a real username/password, then return to SDK Manager for target package installation.

**What went wrong.** The console sat for **hours** on a systemd job describing **end-user configuration after OEM installation** (“no limit” timers). Parallel to that, SDK Manager waited for SSH credentials that did not yet exist—or did not match.

**Operational split-brain.**

- Host tool: “give me SSH creds.”
- Target: OEM job never surfaces an interactive wizard on the plugged display—so no account is finalized.

**Escape hatch.** When Runtime first boot is unhealthy, refactor to **Pre-Config**: re-enter recovery and reflash with credentials chosen up front so the module boots directly into a known local user—even if it costs another flash cycle.

---

## Act VII — “Installation completed successfully” but flash skipped

**Symptom.** A later SDK Manager summary showed HOST items up-to-date while:

`Flash Jetson Linux: Skipped`

alongside many skipped target payloads.

**Cause class.** A session completed without re-selecting flash, or the operator chose **Skip** at a gate, or an aborted flow finalized host-only work.

**Lesson.** Read the **summary block literally**. “Success” there means *the session’s selected work*—not necessarily *your intent*.

---

## The path that actually worked (condensed “gold” sequence)

1. Free space intelligently: large partition + explicit `--download-folder` / `--target-image-folder`.
2. Repair host APT / local NVIDIA repo keys until `apt-get update && apt-get check` is clean.
3. Prefer **Manual Setup** + **Force Recovery** for first bring-up.
4. Match board profile string to **physical dev kit SKU**.
5. Flash until the explicit success banner appears in logs.
6. If onboard OEM wedges, stop fighting Runtime—reflash **Pre-Config** with deterministic credentials OR finish OEM on-console using alternate TTYs before expecting SSH installs from SDK Manager.
7. Re-run SDK Manager for **Install** vs **Skip** consciously; validate summary lines reflect flash intent.

---

## What we would tell our past selves

| Instead of … | Try … |
|--------------|-------|
| Trusting `$HOME` defaults | Anchoring payloads on `/opt/...` with flags every launch |
| Pasting shortened `sdkmanager` replay lines | Ensuring overrides survive copy/paste |
| Treating branding strings as usernames | Creating a boring UNIX name like `lab` / `jetson` deliberately |
| Letting Runtime hang “a little longer” | Time-box OEM; pivot to Pre-Config after policy threshold |
| Assuming “success” headers | Reading per-component **Skipped** vs **Up-to-date** rows |

---

## How to use this doc on your team

- Link here from incident tickets when someone hits the same wall—**the emotional context matters** for retention.
- When your stack versions change, append a short dated addendum at the bottom (JetPack bump, new SDK Manager UI strings).

**Maintainers:** append breaking deltas here before trimming them into the neutral [troubleshooting.md](troubleshooting.md) matrix.
