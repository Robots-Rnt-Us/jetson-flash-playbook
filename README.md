# Jetson Flash Playbook

Operational documentation for flashing **NVIDIA Jetson AGX Orin Developer Kit** (64 GB) using **SDK Manager CLI** with **JetPack 6.x** on an **Ubuntu 22.04** x86 host.

This repo is optimized for mixed-skill teams: use the Quick Path first, drill into guided steps when something fails.

---

## Audience

| Profile | Where to start |
|--------|----------------|
| Operator (done this before) | [Quick Path](#quick-path) → [Flash runbook](docs/jetson/flash-runbook.md#quick-path) |
| First-time flasher | [Guided Path](docs/jetson/flash-runbook.md#guided-path) |
| Debugging | [Troubleshooting](docs/jetson/troubleshooting.md) |

---

## Quick Path

Host prep (once per machine):

```bash
mkdir -p /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
sudo chown -R "$USER:$USER" /opt/nvidia/sdkm_downloads /opt/nvidia/nvidia_sdk
df -h / /home
```

SDK Manager avoids filling `/home` when `--download-folder` and `--target-image-folder` live on a larger partition than `$HOME`.

Put Jetson in **Force Recovery**; verify:

```bash
lsusb | grep 0955
```

Run SDK Manager (adjust `--version` / hardware target for your SKU):

```bash
sdkmanager --cli --action install --login-type devzone --product Jetson \
  --target-os Linux --version 6.2.2 --show-all-versions \
  --target JETSON_AGX_ORIN_TARGETS --flash \
  --download-folder /opt/nvidia/sdkm_downloads \
  --target-image-folder /opt/nvidia/nvidia_sdk \
  --license accept
```

Suggested interactive choices:

- **Manual Setup** matching your developer kit SKU (often “64 GB developer kit version”).
- **OEM Configuration: Pre-Config** if you hit first-boot hangs (see troubleshooting).
- **Flash: Yes**.
- Post-flash SDK install: complete first boot on Jetson, then choose **Install** with real SSH credentials—or **Skip** and install packages later.

---

## Repository Layout

| Path | Contents |
|------|----------|
| [docs/jetson/flash-runbook.md](docs/jetson/flash-runbook.md) | Step-by-step flash flow and prompt decisions |
| [docs/jetson/troubleshooting.md](docs/jetson/troubleshooting.md) | Symptom → cause → fix matrix |
| [docs/jetson/post-flash-checklist.md](docs/jetson/post-flash-checklist.md) | Sanity checks after power-on |
| [docs/jetson/faq.md](docs/jetson/faq.md) | Short answers to common choices |

---

## GitHub CLI (optional)

Authenticate (required before `gh repo` / PR commands):

```bash
gh auth login -h github.com
```

List org repos:

```bash
gh repo list Robots-Rnt-Us --limit 20
```

---

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) for reviewer expectations and optional org wiki mirroring.

---

## Naming & versioning

Maintainers should update README and runbook headers whenever **JetPack**, **Jetson Linux**, or **SDK Manager** versions change materially. Older boards or carrier boards may require different `--target` or manual setup lines—call that out when you diverge.

---

## Security note

Never commit passwords, bearer tokens, or device serial numbers. Use placeholders (`your_username`, `***`) in examples.

---

## License

Documentation in this repo is licensed under **CC BY-SA 4.0** (see [LICENSE](LICENSE)).
