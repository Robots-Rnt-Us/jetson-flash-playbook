# Post-flash checklist — Jetson AGX Orin

Use immediately after flashing and first successful boot completes (or login screen appears).

---

## Power & connections

- [ ] Disconnect recovery wiring if accidental short risk (follow lab ESD habits).
- [ ] Connect display if using desktop Ubuntu image.
- [ ] Intended network uplink plugged (Ethernet) if SSH over LAN planned.

---

## Login validation

- [ ] Local GUI or TTY login works with credentials from **Pre-Config** OR **Runtime** wizard outcome.
- [ ] `passwd` sanity: non-default strong password enforced per org policy.

---

## Network & SSH (recommended)

Adjust interface names/IP targets to your topology.

From host attempting USB gadget path (sometimes `192.168.55.x`):

```bash
ping -c 3 192.168.55.1   # commonly host-visible side varies; invert if needed
```

From Jetson (after console access):

```bash
ip addr
```

From host if routing allows:

```bash
ssh jetson_username@TARGET_IP "echo ssh_ok && uname -a"
```

Document **discovered IPs** privately (avoid publishing in wiki).

---

## Version verification

```bash
cat /etc/nv_tegra_release
```

Ensure major lines match expectation for flashed JetPack / Jetson Linux bundle.

CUDA samples optional:

```bash
nvidia-smi 2>/dev/null || echo note_not_all_images_include_smi_helpers
dpkg -l | grep -E 'cuda|tensorrt|cudnn|opencv' || true
```

Interpret output against components you chose to install (many may be absent if you skipped target packages).

---

## Storage health

```bash
df -h /
lsblk
```

Flash images may expand rootfs on first boot — wait for expansion jobs to finish.

---

## Time & locale

```bash
timedatectl
```

Set timezone if fleet standard requires it.

---

## APT on device (if installing extras)

Behind corporate proxy populate `/etc/apt/apt.conf.d/proxy.conf` per org baseline.

Smoke test:

```bash
sudo apt-get update && sudo apt-get -s upgrade | head
```

---

## Telemetry / NVIDIA registration

Deferred unless required—document org policy separately.

---

## Handoff snippet for ticket closure

Paste internally (sanitize):

```
Board: Jetson AGX Orin Developer Kit <SKU>
JetPack/SDKM: X.Y.Z
Flash method: Manual + PreConfig/Runtime
Post-flash SSH: reachable Y/N IP _
nv_tegra_release: pasted trimmed
Outstanding: CUDA runtime install deferred / Done
```
