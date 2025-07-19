#!/bin/bash
# === 🌈 ambienceur.sh : applique le style visuel choisi (cmatrix / tmux / rien)

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AMBIANCE="1"
CM_PID=""

# 🔍 Lecture du style
if [ -f "$ROOTDIR/config/ambiance.txt" ]; then
  AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")
fi

# 🎞️ Lancement selon choix
if [[ "$AMBIANCE" == "2" ]]; then
  cmatrix -u 3 > /dev/null &
  echo $! > "$ROOTDIR/config/cmatrix.pid"

elif [[ "$AMBIANCE" == "3" ]]; then
  tmux new-session -d -s kortex 'cmatrix -u 3'
  tmux split-window -v -t kortex "echo '📖 Log en direct :'; tail -f $ROOTDIR/logs/session_*.log"
  tmux attach-session -t kortex
  exit 0
fi
