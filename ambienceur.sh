#!/bin/bash

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AMBIANCE="1"
[[ -f "$ROOTDIR/config/ambiance.txt" ]] && AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")

if [[ "$AMBIANCE" == "1" ]]; then
  echo "🧘 Ambiance classique activée ➤ terminal standard"
  bash "$ROOTDIR/scripts/install-core.sh"
  exit 0
fi

# 🌪️ Mode visuel ➤ cmatrix en premier plan (non bloquant)
echo "🌈 Ambiance visuelle ➤ cmatrix lancé en parallèle"
cmatrix -u 2 &
echo $! > "$ROOTDIR/config/cmatrix.pid"
sleep 0.5  # petit décalage pour laisser cmatrix démarrer

# 💡 Lancement installation classique
bash "$ROOTDIR/scripts/install-core.sh"


