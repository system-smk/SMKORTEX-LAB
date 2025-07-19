#!/bin/bash
# 🌈 ambienceur.sh : applique le style visuel choisi (1 = classique, 2 = tmux mixte)

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOGDIR="$ROOTDIR/logs"
LOGFILE="$LOGDIR/session_$(date +"%H-%M_%d-%m-%Y").log"

# 📥 Lecture du choix depuis config
AMBIANCE="1"
[[ -f "$ROOTDIR/config/ambiance.txt" ]] && AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")

# 📁 Création du dossier logs
mkdir -p "$LOGDIR"
touch "$LOGFILE"

# 🧘 Mode 1 ➤ classique sans effet visuel
if [[ "$AMBIANCE" == "1" ]]; then
  echo "🧘 Ambiance classique activée ➤ pas d'animation"
  exit 0
fi

# 🔍 Vérifications : tmux présent + terminal assez grand
if ! command -v tmux &>/dev/null; then
  echo "⚠️ tmux absent ➤ ambiance mixte désactivée"
  exit 0
fi

MIN_LINES=12
TERM_LINES=$(tput lines)
if [[ "$TERM_LINES" -lt "$MIN_LINES" ]]; then
  echo "⚠️ Terminal trop petit pour split ➤ ambiance désactivée"
  exit 0
fi

# 🌪️ Mode 2 ➤ ambiance mixte avec cmatrix + logs via tmux split
echo "🎛️ Ambiance mixte activée ➤ affichage cmatrix + logs"

tmux new-session -d -s kortex "cmatrix -u 2"
tmux split-window -v -t kortex "echo -e '\n📖 Log SMKORTEX :'; tail -f \"$LOGFILE\""
tmux select-pane -t kortex:0
tmux attach-session -t kortex

