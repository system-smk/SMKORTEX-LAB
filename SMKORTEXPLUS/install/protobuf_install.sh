#!/bin/bash

echo "╔══════════════════════════════════════════════════╗"
echo "║ 🧠 SMKORTEX — Installation de Protocol Buffers    ║"
echo "╚══════════════════════════════════════════════════╝"

# 🔍 Vérification de libprotobuf-dev
if dpkg -s libprotobuf-dev &> /dev/null && dpkg -s protobuf-compiler &> /dev/null; then
    echo "✅ Protobuf est déjà installé sur ce système."
else
    echo "📦 Protobuf non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y libprotobuf-dev protobuf-compiler

    if [ $? -eq 0 ]; then
        echo "✅ Protobuf installé avec succès."
    else
        echo "❌ Échec de l'installation de Protobuf."
        exit 1
    fi
fi

echo "🎯 Fin du script protobuf_install.sh"
exit 0
