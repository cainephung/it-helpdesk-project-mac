#!/usr/bin/env bash
# Reset Wi‑Fi on macOS: toggle interface and renew DHCP lease.
# Usage: sudo ./reset_wifi.sh
set -euo pipefail

# Default Wi‑Fi service name on macOS is "Wi‑Fi"; adjust if yours differs.
WIFI_SERVICE="${WIFI_SERVICE:-Wi-Fi}"

echo "Turning Wi‑Fi OFF for service: $WIFI_SERVICE"
networksetup -setairportpower "$WIFI_SERVICE" off
sleep 3
echo "Turning Wi‑Fi ON"
networksetup -setairportpower "$WIFI_SERVICE" on
sleep 3

echo "Renewing DHCP lease"
ipconfig set "$WIFI_SERVICE" DHCP 2>/dev/null || true

echo "Wi‑Fi has been reset."
