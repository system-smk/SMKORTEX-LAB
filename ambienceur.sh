#!/bin/bash
# 🌈 ambienceur.sh : active l'ambiance terminal (classique ou mixte)

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOGDIR="$ROOTDIR/logs"
LOGFILE="$LOGDIR/session_$(date +"%H-%M_%d-%m-%Y").log"

# 📥 Lecture du choix utilisateur
AMBIANCE="1"
[[ -f "$ROOTDIR/config/ambiance.txt" ]] && AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")

# 📁 Préparation des logs
mkdir -p "$LOGDIR"
touch "$LOGFILE"

# 🧘 Mode 1 ➤ ambiance classique (aucun effet visuel)
if [[ "$AMBIANCE" == "1" ]]; then
  echo "🧘 Ambiance classique activée ➤ pas d'animation"
  exit 0
fi

# 🔍 Vérifications : tmux présent + terminal assez grand
if ! command -v tmux &>/dev/null; then
  echo "⚠️ tmux absent ➤ ambiance désactivée"
  exit 0
fi

MIN_LINES=12
TERM_LINES=$(tput lines)
if [[ "$TERM_LINES" -lt "$MIN_LINES" ]]; then
  echo "⚠️ Terminal trop petit pour split ➤ ambiance désactivée"
  exit 0
fi

# 🎛️ Mode 2 ➤ ambiance mixte : cmatrix + verbose live via split tmux
echo "🎬 Activation de l’ambiance mixte ➤ cmatrix + flux cognitif SMKORTEX"

tmux new-session -d -s kortex "cmatrix -u 2"
tmux split-window -v -t kortex "echo -e '\n📖 Verbosité SMKORTEX :'; tail -f \"$LOGFILE\""
tmux select-pane -t kortex:0
tmux attach-session -t kortex
