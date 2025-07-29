#!/bin/bash

# 📍 Chemins
LLAMA_CLI="$(realpath repos/llama.cpp/build/bin/llama-cli)"
MODEL_PATH="$(realpath models/vigogne-2-7b-chat.Q4_K_M.gguf)"
SESSION_FILE="kortex_session.jsonl"
LOGO_BINARY="$(realpath build/kognition)"

# 📡 Vérifications
if ! [ -x "$LLAMA_CLI" ]; then
    echo "❌ llama-cli introuvable à : $LLAMA_CLI"
    exit 1
fi
if ! [ -f "$MODEL_PATH" ]; then
    echo "❌ Modèle introuvable à : $MODEL_PATH"
    exit 1
fi
if ! [ -x "$LOGO_BINARY" ]; then
    echo "⚠ logo introuvable. L'affichage sera sans animation."
fi

# 🗂 Fonction de sauvegarde JSONL
save_exchange() {
    local role="$1"
    local content="$2"
    echo "{\"role\": \"$role\", \"content\": \"$content\"}" >> "$SESSION_FILE"
}

# 🚀 Démarrage de la session
echo "🎙 KORTEX est prêt à discuter avec streaming & historique. Tape 'exit' pour quitter."

while true; do
    read -p "💬 Toi : " input
    [[ "$input" == "exit" ]] && echo "👋 À bientôt." && break

    save_exchange "Utilisateur" "$input"

    # 🎨 Animation pendant le chargement
    if [ -x "$LOGO_BINARY" ]; then
        "$LOGO_BINARY" &
        LOGO_PID=$!
    fi

    # 🧘 Appel au modèle en streaming direct
    echo -n "🤖 KORTEX : "
    "$LLAMA_CLI" -m "$MODEL_PATH" -p "$input" --temp 0.6 --top-k 42 --ctx-size 4096 --color 2>/dev/null

    # 🛑 Stop animation
    if [ -n "$LOGO_PID" ]; then
        kill "$LOGO_PID" 2>/dev/null
        wait "$LOGO_PID" 2>/dev/null
        unset LOGO_PID
    fi

    echo "" # saut de ligne propre
    save_exchange "KORTEX" "Réponse affichée ci-dessus"
done
