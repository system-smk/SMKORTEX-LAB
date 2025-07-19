#!/bin/bash

# === 📁 Résolution robuste du chemin racine
SCRIPT_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SCRIPT_SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"
  SCRIPT_SOURCE="$(readlink "$SCRIPT_SOURCE")"
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE="$DIR/$SCRIPT_SOURCE"
done
ROOTDIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")/.." >/dev/null 2>&1 && pwd)"
[[ -n "$KORTEX_ROOTDIR" ]] && ROOTDIR="$KORTEX_ROOTDIR"
# === 📦 Chemins et logs
mkdir -p "$ROOTDIR/logs"
LOGFILE="$ROOTDIR/logs/session_$(date +"%H-%M_%d-%m-%Y").log"
MODEL="$ROOTDIR/llama/models/model.gguf"
BIN="$ROOTDIR/llama/llama.cpp/build/bin/llama-cli"
PROMPT="$1"

# === 🌈 Lecture de l’ambiance visuelle
AMBIANCE="1"
if [ -f "$ROOTDIR/config/ambiance.txt" ]; then
  AMBIANCE=$(cat "$ROOTDIR/config/ambiance.txt")
fi

# === 🎛️ Lancement d’ambiance cmatrix/tmux selon choix
if [[ "$AMBIANCE" == "2" ]]; then
  cmatrix -u 3 &
  CM_PID=$!
elif [[ "$AMBIANCE" == "3" ]]; then
  tmux new-session -d -s kortex 'cmatrix -u 3'
  tmux split-window -v -t kortex "tail -f $LOGFILE"
  tmux attach-session -t kortex
  exit 0
fi

# === 🧪 Vérifs
if [ ! -f "$BIN" ]; then echo "❌ Binaire introuvable ➤ compile avec clone-compile-llama.sh"; exit 1; fi
if [ ! -f "$MODEL" ]; then echo "❌ Modèle introuvable ➤ télécharge avec telecharger-modele.sh"; exit 1; fi

# === 🧠 Fonction d'exécution (réutilisable)
run_prompt() {
  "$BIN" \
    --model "$MODEL" \
    --color \
    --threads 6 \
    --temp 0.6 \
    --repeat_penalty 1.15 \
    --top_k 42 \
    --top_p 0.9 \
    --n_predict 256 \
    --ctx-size 4096 \
    --no-mmap \
    --seed -1 \
    --prompt "La conversation suivante est entre un Utilisateur et KORTEX, un assistant IA francophone bienveillant.\nUtilisateur : $1\nKORTEX :" \
    --reverse-prompt "Utilisateur :"
}

# === 📡 Mode WebUI / prompt unique
if [[ -n "$PROMPT" ]]; then
  run_prompt "$PROMPT"
  exit 0
fi

# === 💬 Mode interactif terminal
echo "📦 Projet : $ROOTDIR"
echo "📅 Log    : $LOGFILE"
echo "⚡ Mode session persistante KORTEX (RAM boostée)"
echo "✏️  Ctrl+C pour quitter"

while true; do
  read -p "Utilisateur : " REPLY
  echo -e "Utilisateur : $REPLY" | tee -a "$LOGFILE"

  if command -v lolcat &> /dev/null; then
    run_prompt "$REPLY" | tee -a "$LOGFILE" | lolcat
  else
    run_prompt "$REPLY" | tee -a "$LOGFILE"
  fi

  echo "" >> "$LOGFILE"
done

# === 🧹 Arrêt de cmatrix si lancé
[[ -n "$CM_PID" ]] && kill "$CM_PID" 2>/dev/null




