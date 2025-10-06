# Fix Wi‑Fi Disconnections (macOS)

**Symptoms:** Wi‑Fi drops or reconnects every few minutes.

**Steps:**
1) Run the Wi‑Fi reset script:
```bash
sudo ./scripts/mac/reset_wifi.sh
```
2) Flush DNS:
```bash
sudo ./scripts/mac/flush_dns.sh
```
3) Collect diagnostics and attach the file to the ticket:
```bash
./scripts/mac/collect_diagnostics.sh
```

**If still failing:**
- Move closer to router; try 5 GHz vs 2.4 GHz.
- Forget and re‑add the network in **System Settings → Wi‑Fi**.
- Reboot router or Mac.
