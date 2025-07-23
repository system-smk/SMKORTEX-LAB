#!/bin/bash

echo "╔════════════════════════════════════════════════════╗"
echo "║ 🧠 SMKORTEX — Installation de SentencePiece Tokenizer ║"
echo "╚════════════════════════════════════════════════════╝"

# 🔍 Vérification de libsentencepiece-dev
if dpkg -s libsentencepiece-dev &> /dev/null; then
    echo "✅ SentencePiece est déjà installé sur ce système."
else
    echo "📦 libsentencepiece-dev non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y libsentencepiece-dev

    if [ $? -eq 0 ]; then
        echo "✅ SentencePiece installé avec succès."
    else
        echo "❌ Échec de l'installation de SentencePiece."
        exit 1
    fi
fi

echo "🎯 Fin du script sentencepiece_install.sh"
exit 0
