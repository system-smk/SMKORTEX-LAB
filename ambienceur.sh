#!/bin/bash
# 🌈 ambienceur.sh : active le style terminal selon le choix utilisateur


ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmux new-session -d -s kortex "cmatrix -u 2"
tmux split-window -v -p 50 -t kortex "bash $ROOTDIR/scripts/install-core.sh"
tmux select-pane -t kortex:0
tmux attach-session -t kortex

LOGDIR="$ROOTDIR/logs"
LOGFILE="$LOGDIR/session_$(date +"%H-%M_%d-%m-%Y").log"

# 📥 Lecture du choix utilisateur
AMBIANCE="1"
[[ -f "$ROOTDIR/config/ambiance.txt" ]] && AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")

# 📁 Préparation des logs
mkdir -p "$LOGDIR"
touch "$LOGFILE"

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

# 🎛️ Ambiance mixte ➤ tmux + split cmatrix / verbose
echo "🎬 Ambiance visuelle activée ➤ affichage cmatrix + flux cognitif SMKORTEX"

tmux new-session -d -s kortex "cmatrix -u 2"
tmux split-window -v -p 50 -t kortex "tail -f \"$LOGFILE\""
tmux select-pane -t kortex:0
tmux attach-session -t kortex
