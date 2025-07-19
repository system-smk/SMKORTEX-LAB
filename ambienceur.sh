#!/bin/bash

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOGDIR="$ROOTDIR/logs"
LOGFILE="$LOGDIR/session_$(date +"%H-%M_%d-%m-%Y").log"

mkdir -p "$LOGDIR"
touch "$LOGFILE"

AMBIANCE="1"
[[ -f "$ROOTDIR/config/ambiance.txt" ]] && AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")

if [[ "$AMBIANCE" == "1" ]]; then
  echo "🧘 Ambiance classique activée ➤ terminal standard"
  bash "$ROOTDIR/scripts/install-core.sh"
  exit 0
fi

if ! command -v tmux &>/dev/null; then
  echo "⚠️ tmux absent ➤ fallback vers mode classique"
  bash "$ROOTDIR/scripts/install-core.sh"
  exit 0
fi

MIN_HEIGHT=12
TERM_HEIGHT=$(tput lines)
[[ "$TERM_HEIGHT" -lt "$MIN_HEIGHT" ]] && {
  echo "⚠️ Terminal trop petit ➤ fallback classique"
  bash "$ROOTDIR/scripts/install-core.sh"
  exit 0
}

# 🎬 Ambiance visuelle complète dans tmux
echo "🎛️ Activation de l’ambiance mixte ➤ cmatrix + installation"

tmux new-session -d -s kortex "cmatrix -u 2"
tmux split-window -v -p 50 -t kortex "bash \"$ROOTDIR/scripts/install-core.sh\" | tee -a \"$LOGFILE\""
tmux select-pane -t kortex:0
tmux attach-session -t kortex

