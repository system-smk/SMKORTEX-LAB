#!/bin/bash

# 🔍 Définir le chemin vers llama-run et le modèle
LLAMA_RUN="$(realpath repos/llama.cpp/build/bin/llama-run)"
MODEL_PATH="$(realpath models/vigogne-2-7b-chat.Q4_K_M.gguf)"

# 📡 Vérifications
if ! [ -x "$LLAMA_RUN" ]; then
    echo "❌ Erreur : l'exécutable llama-run est introuvable ou non exécutable."
    exit 1
fi
if ! [ -f "$MODEL_PATH" ]; then
    echo "❌ Erreur : le modèle .gguf n'a pas été trouvé à l'emplacement : $MODEL_PATH"
    exit 1
fi

# 🚀 Lancement du chat
echo "KORTEX lancé! Tape 'exit' pour quitter."

while true; do
    read -p "💬 Toi : " input
    [[ "$input" == "exit" ]] && echo "👋 Session terminée." && break
    "$LLAMA_RUN" file://"$MODEL_PATH" <<< "$input"
done
