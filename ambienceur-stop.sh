#!/bin/bash
# === 🔧 ambienceur-stop.sh : arrête les effets visuels

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -f "$ROOTDIR/config/cmatrix.pid" ]]; then
  kill "$(cat "$ROOTDIR/config/cmatrix.pid")" 2>/dev/null
  rm "$ROOTDIR/config/cmatrix.pid"
fi
