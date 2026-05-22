# Jetson AGX Orin — Flash runbook (SDK Manager CLI)

Scope: **Ubuntu 22.04 x86_64 host**, **JetPack 6.x** (example: `6.2.2`), **Jetson AGX Orin Developer Kit (64 GB)**. Adjust `--version` and Manual Setup target name if your SKU differs.

See also: [bring-up-journey.md](bring-up-journey.md) (chronological “how we finally got there”), [troubleshooting.md](troubleshooting.md), [faq.md](faq.md).

---

## Prerequisites

- Reliable USB data cable to the Jetson **device-mode / flash** USB-C port (location: see [NVIDIA Jetson AGX Orin Developer Kit user guide](https://docs.nvidia.com/jetson/agx-orin-devkit/user-guide/latest/index.html)).
- Host disk space:

  ```bash
  df -h / /home /tmp
  ```

  Prefer **several tens of GB free** on the partition SDK Manager writes to (`--download-folder` + `--target-image-folder`). Hosting large downloads under `/opt` avoids small `/home` partitions.

  ```bash
  mkdir -p /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
  sudo chown -R "$USER:$USER" /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
  ```

- APT must be healthy (`apt-get update` / `apt-get check`). If readiness checks fail with a local NVIDIA repo pubkey error, see [troubleshooting — APT readiness](troubleshooting.md#apt-repository-readiness-no_pubkey).

---

## Known-good command (baseline)

Interactive CLI (recommended for first-time setups):

```bash
sdkmanager --cli --action install --login-type devzone --product Jetson \
  --target-os Linux --version 6.2.2 --show-all-versions \
  --target JETSON_AGX_ORIN_TARGETS \
  --flash \
  --download-folder /opt/nvidia/sdkm_downloads \
  --target-image-folder /opt/nvidia/nvidia_sdk \
  --license accept
```

Notes:

- Drop `--show-all-versions` if you only install primary releases.
- Add `--host` only if you also need CUDA/cross-compile tools on **this Linux PC**.

---

## Recovery mode checklist

Power off Jetson → hold **FORCE REC** → press **POWER** → release FORCE REC after a few seconds (exact sequence varies slightly; verify against current NVIDIA docs for AGX Orin).

On host:

```bash
lsusb | grep 0955:
```

Examples of IDs seen in-field: `0955:7023` (recovery / flashing path). Presence of an NVIDIA VID **does not guarantee** SDK Manager agrees with board profile — pick the correct Manual Setup line.

---

## Quick Path

1. Prep `/opt/nvidia/` folders (above).
2. Enter recovery → `lsusb | grep 0955`.
3. Run SDK Manager command (baseline).
4. Manual Setup → **64 GB developer kit** (or your exact listing).
5. OEM: **Pre-Config** (avoids common first-boot OEM stalls) *or* **Runtime** if you need on-device wizard.
6. Select detected **Recovery | 0955:…** USB entry.
7. **Yes, flash** when prompted.

After successful flash log line similar to:

`The target generic has been flashed successfully.`

Proceed to target component install decision (Install vs Skip) per [FAQ — Install vs Skip](faq.md).

---

## Guided Path

### Step A — Launch SDK Manager

Run the baseline command. Complete NVIDIA Developer login in browser when prompted (`--login-type devzone`).

### Step B — Component selection

In the checklist UI:

- **Jetson Linux** image: required.
- **Flash Jetson Linux**: enable.
- **Host components** (`--host`): optional; adds host disk/time but useful for CUDA cross-compile.

Reduce scope if bandwidth or disk is tight — you can rerun later.

### Step C — Disk space prompts

If SDK Manager warns `/home` partition is low, verify you passed **`--download-folder`** and **`--target-image-folder`** pointing at a directory on a partition with ample free space (often `/`):

```bash
df -h /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
```

### Step D — System readiness (APT)

If verification fails referencing `sudo apt-get update && sudo apt-get check`, open a terminal run the same manually and read errors. Typical fix: importing keys for **`file:/var/l4t-cuda-repo-*-local`** — see troubleshooting.

Retry **Verify** flow in SDK Manager after fix.

### Step E — Automatic vs Manual setup prompt

Choose **Manual Setup** when:

- You are flashing from recovery and want predictable board matching.
- Automatic mode probes SSH/RNDIS on a partially configured system and prompts for credentials you do not have yet.

Choose **Manual Setup — Jetson AGX Orin (64 GB developer kit version)** (wording approximate; pick the SKU that explicitly matches yours).

### Step F — IPv4 vs IPv6 at connection prompts

Default **IPv4** is standard for Jetson ↔ host gadget / RNDIS style addressing (often `192.168.55.1` on host side for USB connection scenarios). Use **IPv6** only if your lab network is explicitly IPv6-only.

### Step G — OEM configuration

| Choice | Use when |
|--------|----------|
| **Runtime** | You will complete OEM first-boot wizard on a monitor attached to Jetson |
| **Pre-Config** | You want OEM user/password baked in ahead of boot (recommended if Runtime wizard hangs forever) |

If **Runtime**, do **not** enter credentials in SDK Manager until first boot succeeds on Jetson and you defined a real Linux user.

If **Pre-Config**, SDK Manager prompts for credentials — those define the eventual login.

### Step H — Confirm flash

Ensure **exactly one** NVIDIA recovery device detected if flashing from RCM unless you intend multi-flash tooling.

Proceed **Yes → flash**.

### Step I — Install SDK components on target?

After flashing you may see post-install prompts.

1. Boot Jetson, complete OEM if Runtime.
2. Choose **Install** and supply SSH username/password **from Jetson Linux**, not your host account.
3. Proxy: **Do not set proxy** unless required by your network.

Or choose **Skip** and install packages later.

### Step J — If install summary shows “Flash Skipped”

You likely finished a rerun where flash was unchecked or session aborted early. Launch with `--flash` and ensure prompts did not disable flash components.

---

## Maintenance

Capture any board-specific SKU or JetPack version deltas as dated notes in CHANGELOG or README.
