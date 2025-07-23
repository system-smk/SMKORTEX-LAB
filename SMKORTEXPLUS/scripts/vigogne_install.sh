#!/bin/bash

echo "🧠 Téléchargement du modèle Vigogne GGUF"

# Vérification que llama.cpp existe
if [ ! -d "llama.cpp/models" ]; then
    mkdir -p llama.cpp/models
fi

cd llama.cpp/models

# Téléchargement du modèle GGUF
echo "📦 Téléchargement de Vigogne Q4_K_M..."
wget "https://huggingface.co/TheBloke/Vigogne-2-7B-Chat-GGUF/resolve/main/vigogne-2-7b-chat.Q4_K_M.gguf" \
     -O model.gguf || exit 1

echo "✅ Modèle Vigogne téléchargé dans llama.cpp/models/"
exit 0
