#!/usr/bin/env bash
# Flush DNS on macOS (works on modern versions).
# Usage: sudo ./flush_dns.sh
set -euo pipefail
echo "Flushing DNS caches..."
dscacheutil -flushcache || true
killall -HUP mDNSResponder || true
echo "Done."
