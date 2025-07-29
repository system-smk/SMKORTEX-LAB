#!/bin/bash

# 📍 Chemins
LLAMA_CLI="$(realpath repos/llama.cpp/build/bin/llama-cli)"
MODEL_PATH="$(realpath models/vigogne-2-7b-chat.Q4_K_M.gguf)"
SESSION_FILE="kortex_session.jsonl"
LOGO_BINARY="$(realpath build/kognition)"

# 🧠 SYSTEM PROMPT
SYSTEM_PROMPT="Tu es KORTEX, une IA francophone bienveillante et concise. Tu réponds toujours en français, sans digression, avec rigueur et clarté."

# 📡 Vérifications
if ! [ -x "$LLAMA_CLI" ]; then echo "❌ llama-cli introuvable."; exit 1; fi
if ! [ -f "$MODEL_PATH" ]; then echo "❌ Modèle introuvable."; exit 1; fi
if ! [ -x "$LOGO_BINARY" ]; then echo "⚠ Animation absente."; fi

# 🗂 Sauvegarde JSONL
save_exchange() {
    echo "{\"role\": \"$1\", \"content\": \"$2\"}" >> "$SESSION_FILE"
}

# 🎙 Boucle principale
echo "🎧 KORTEX est actif. Tape 'exit' pour quitter."
while true; do
    read -p "💬 Toi : " input
    [[ "$input" == "exit" ]] && echo "👋 À bientôt." && break

    save_exchange "Utilisateur" "$input"
    echo -e "\n\033[1;32m⏳ Traitement en cours...\033[0m"

    # 🎞 Animation pendant 15s (avant-plan)
    if [ -x "$LOGO_BINARY" ]; then
        timeout 15 "$LOGO_BINARY"
    fi

    # 🤖 Appel au modèle avec contrôle strict
    echo -n "🤖 KORTEX : "
    FULL_PROMPT="$SYSTEM_PROMPT Réponds simplement à : $input"
    "$LLAMA_CLI" -m "$MODEL_PATH" -p "$FULL_PROMPT" \
        --temp 0.2 --top-k 42 --top-p 0.9 \
        --repeat-penalty 1.2 --ctx-size 4096 \
        --mirostat 2 --color 2>/dev/null

    echo ""
    save_exchange "KORTEX" "Réponse affichée ci-dessus"
done
