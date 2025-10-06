#!/usr/bin/env bash
# Collect basic diagnostics into a timestamped log file.
set -euo pipefail
OUTDIR="$(cd "$(dirname "$0")" && pwd)/logs"
mkdir -p "$OUTDIR"
STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$OUTDIR/diagnostics_${STAMP}.txt"

exec &> >(tee "$OUT")

echo "== System Info =="
sw_vers || true
system_profiler SPHardwareDataType SPSoftwareDataType || true

echo
echo "== Network Services =="
networksetup -listallnetworkservices || true

echo
echo "== Wi‑Fi Details =="
networksetup -getinfo "Wi-Fi" || true

echo
echo "== IP Addresses =="
ipconfig getifaddr en0 || true
ipconfig getifaddr en1 || true

echo
echo "== DNS Config =="
scutil --dns || true

echo
echo "== Ping Test =="
ping -c 4 8.8.8.8 || true

echo
echo "== Traceroute =="
traceroute 8.8.8.8 || true

echo
echo "Diagnostics saved to $OUT"
