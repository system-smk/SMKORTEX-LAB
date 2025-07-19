#!/bin/bash
# === 🔧 ambienceur-stop.sh : arrête les effets visuels

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PIDFILE="$ROOTDIR/config/cmatrix.pid"

if [[ -f "$PIDFILE" ]]; then
  kill "$(cat "$PIDFILE")" 2>/dev/null
  rm "$PIDFILE"
  echo "🛑 cmatrix arrêté avec succès"
else
  echo "ℹ️ Aucun processus cmatrix à arrêter"
fi

