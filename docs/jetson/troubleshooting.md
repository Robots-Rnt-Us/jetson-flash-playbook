# Troubleshooting matrix — Jetson flash (SDK Manager / Ubuntu host)

Prefer the phased narrative in [`START_HERE.md`](../START_HERE.md) unless you jumped here chasing a symptom.

This file stays deliberately terse. Need pacing plus war stories first? Peek at [bring-up-journey.md](bring-up-journey.md).

Convention: Run commands on **host PC** unless stated otherwise.

---

## Disk space: `/home` warnings from SDK Manager

**Symptoms**

- SDK Manager warns insufficient space on `/dev/sda6` or `$HOME`.
- Earlier `df` shows plenty of space on `/` but `/home` is tight.

**Likely causes**

Default locations without overrides:

| Asset | Typical default location |
|-------|--------------------------|
| Downloads | `${HOME}/Downloads/nvidia/sdkm_downloads` |
| Target image / SDK tree | `${HOME}/nvidia/nvidia_sdk` |

**Fix**

Point both to a large partition:

```bash
mkdir -p /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
sudo chown -R "$USER:$USER" /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
```

Relaunch CLI with explicit flags:

```
--download-folder /opt/nvidia/sdkm_downloads \
--target-image-folder /opt/nvidia/nvidia_sdk
```

**Verify**

```bash
df -h /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
```

---

## “Needs additional 2 MiB” (small delta)

**Symptoms**

SDK Manager insists on a trivial amount more free space despite apparent headroom.

**Likely causes**

- Rounding + safety buffers.
- Old path partially filled.
- Oversized selections (host CUDA + heavy target runtime).

**Fix**

- Prefer explicit `--download-folder` / `--target-image-folder`.
- Optionally deselect bulky optional stacks for first pass.

---

## APT repository readiness failure (exitCode 100)

**Symptoms**

- Readiness pane: failure running `sudo timeout 300 apt-get update && sudo timeout 300 apt-get check`.
- Logs include `NO_PUBKEY …` referencing `file:/var/l4t-cuda-repo-ubuntu*-local`.

Example fingerprint seen in-field: **`6101062BDFC407FB`**.

**Fix (import local repo gpg key)**

```bash
sudo mkdir -p /usr/share/keyrings
sudo cp /var/l4t-cuda-repo-*-local/*.gpg /usr/share/keyrings/  # adjust glob if multiple
sudo apt-get update
sudo apt-get check
```

If still failing, Ubuntu keyserver fallback (use only if instructed by your security policy):

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <KEYSHORT>
sudo apt-get update && sudo apt-get check
```

**Verify**

Manual run should exit 0:

```bash
sudo apt-get update && sudo apt-get check
sudo dpkg --audit
```

---

## Incorrect Jetson detected / does not match target

**Symptoms**

- Logs: could not detect correct NVIDIA Jetson device.
- Mixed USB IDs (`0955:7023` previously, `0955:7020` now, etc.).

**Likely causes**

Wrong **Manual Setup** SKU line picked, wrong recovery entry, flaky cable/USB port.

**Fix**

- Re-enter Force Recovery cleanly.
- Re-run `lsusb | grep 0955` and correlate with SKU documentation ([NVIDIA developer forums references](https://forums.developer.nvidia.com/)).
- Select board profile explicitly matching Developer Kit wording.

---

## SSH “Permission denied (publickey,password)” from SDK Manager

**Symptoms**

During **Automatic Setup** probing or post-flash installs, SSH to `...@192.168.55.x` denied.

**Likely causes**

- Using board label / guessed username (`Prof*-DevKit`-style hostname is **not** a Linux username unless you explicitly created one).
- No user yet (Runtime wizard not finished).
- Wrong password or SSH blocked.

**Fix**

- Prefer **Manual Setup + Flash** loop if still unconfigured board.
- If **Runtime OEM**: finish onboarding on Jetson, then rerun post-install SSH step.
- If stuck in OEM: use **Pre-Config** reflash path with known credentials.

---

## Jetson console stuck on OEM configuration job

**Symptoms**

Systemd status line similar to:

`A start job is running for End-user configuration after initial OEM installation … / no limit`

**Likely causes**

Headless / display issues with debconf UI, partial package install, or rare image glitches.

**Quick mitigations**

- Reboot with display + keyboard attached.
- Try virtual consoles: `Ctrl+Alt+F2` / `F3`.

**Robust mitigation**

Reflash with **Pre-Config** credentials so board boots directly to login.

---

## Session ends with “Flash Jetson Linux: Skipped”

**Symptoms**

Final summary shows success but flash row skipped.

**Likely causes**

Earlier selection **No, skip flashing** or interrupted session.

**Fix**

Run again with `--flash`, enable flash component explicitly, recovery mode connected.

---

## Host GitHub CLI / API blocked in constrained environments

**Symptoms**

`gh auth status` OK locally outside sandbox fails inside CI/sandbox proxies.

**Fix**

Run `gh` with outbound HTTPS access or PAT with `repo` + `workflow` scopes as needed.

---

## Escalation data to collect before asking for help

1. `uname -a` (host).
2. `sdkmanager --ver` output.
3. JetPack `--version`.
4. `lsusb | grep 0955` during recovery vs runtime.
5. Relevant excerpt of SDK Manager **Terminal Log** (redacted).
6. `df -h / /home` with download paths used.
