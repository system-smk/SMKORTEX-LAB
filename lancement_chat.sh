#!/bin/bash

# 📍 Chemins
LLAMA_CLI="$(realpath repos/llama.cpp/build/bin/llama-cli)"
MODEL_PATH="$(realpath models/vigogne-2-7b-chat.Q4_K_M.gguf)"
SESSION_FILE="kortex_session.jsonl"
LOGO_BINARY="$(realpath build/kognition)"

# 🧠 SYSTEM PROMPT corrigé
SYSTEM_PROMPT="Tu es KORTEX, une intelligence artificielle francophone spécialisée dans les relations humaines et les échanges bienveillants. Tu réponds avec clarté, empathie et rigueur."

# 📡 Vérifications
if ! [ -x "$LLAMA_CLI" ]; then echo "❌ llama-cli introuvable."; exit 1; fi
if ! [ -f "$MODEL_PATH" ]; then echo "❌ Modèle introuvable."; exit 1; fi
if ! [ -x "$LOGO_BINARY" ]; then echo "⚠ Animation absente."; fi

# 🗂 Sauvegarde JSONL
save_exchange() {
    echo "{\"role\": \"$1\", \"content\": \"$2\"}" >> "$SESSION_FILE"
}

# 🎙 Démarrage
echo "🎧 KORTEX est actif. Tape 'exit' pour quitter."

while true; do
    read -p "💬 Toi : " input
    [[ "$input" == "exit" ]] && echo "👋 À bientôt." && break

    save_exchange "Utilisateur" "$input"
    echo -e "\n\033[1;32m⏳ KORTEX réfléchit...\033[0m"

    # 🎞 Animation pendant 15 secondes
    if [ -x "$LOGO_BINARY" ]; then
        timeout 15 "$LOGO_BINARY"
    fi

    # 👤 Prompt enrichi avec dialogue structuré
    FULL_PROMPT="$SYSTEM_PROMPT\n\nUtilisateur : $input\nKORTEX :"

    # 🤖 Appel au modèle
    echo -n "🤖 KORTEX : "
    "$LLAMA_CLI" -m "$MODEL_PATH" -p "$FULL_PROMPT" \
        --temp 0.6 --top-k 40 --top-p 0.9 \
        --repeat-penalty 1.2 --ctx-size 2048 \
        2>/dev/null

    echo ""
    save_exchange "KORTEX" "Réponse affichée ci-dessus"
done
