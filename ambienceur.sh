#!/bin/bash
# 🌈 ambienceur.sh : active le style terminal selon le choix utilisateur

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOGDIR="$ROOTDIR/logs"
LOGFILE="$LOGDIR/session_$(date +"%H-%M_%d-%m-%Y").log"

# 📥 Lecture du choix utilisateur
AMBIANCE="1"
[[ -f "$ROOTDIR/config/ambiance.txt" ]] && AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")

# 🧘 Ambiance classique ➤ pas d'effet visuel
if [[ "$AMBIANCE" == "1" ]]; then
  echo "🧘 Ambiance classique activée ➤ terminal standard"
  exit 0
fi

# 🔍 Vérifications : tmux présent + terminal assez grand
if ! command -v tmux &>/dev/null; then
  echo "⚠️ tmux non disponible ➤ ambiance mixte désactivée"
  exit 0
fi

MIN_HEIGHT=12
TERM_HEIGHT=$(tput lines)
if [[ "$TERM_HEIGHT" -lt "$MIN_HEIGHT" ]]; then
  echo "⚠️ Terminal trop petit pour split ➤ ambiance désactivée"
  exit 0
fi

# 📁 Préparation des logs
mkdir -p "$LOGDIR"
touch "$LOGFILE"

# 🎛️ Ambiance mixte ➤ tmux + split cmatrix / install-core.sh
echo "🎬 Ambiance visuelle activée ➤ cmatrix + installation active"

tmux new-session -d -s kortex "cmatrix -u 2"
tmux split-window -v -p 50 -t kortex "bash \"$ROOTDIR/scripts/install-core.sh\" | tee -a \"$LOGFILE\""
tmux select-pane -t kortex:0
tmux attach-session -t kortex
