Short copy you can laminate for benches.

---

## Sanity order

| Step | Checkpoint |
|------|------------|
| Host online + disk OK | `df -h`, `ping -c 3 ubuntu.com` |
| SDK Manager churning | Downloads happen **before** Jetson wiring phase |
| Enter Recovery | Barrel power stable, FORCE REC choreography, **`lsusb` shows `0955`** |
| Post flash | Logs say success; rerun session must not show “Flash skipped” unintentionally |

## Defaults first-timers favored

| Prompt | Recommendation |
|--------|----------------|
| Automatic vs Manual | **Manual + Recovery** for virgin silicon |
| Runtime vs Pre‑Config OEM | Runtime if KVM attached; otherwise Pre‑Config avoids stuck OEM systemd job |
| Post flash packages | Skip until login works reliably |

## USB discipline

Short USB‑3‑rated **data** cable, correct Type‑C **flash** port, avoid flaky hubs—apply regulated DC jack **before** USB stress.
