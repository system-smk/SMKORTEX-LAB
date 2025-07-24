#!/bin/bash

echo "╔═════════════════════════════════════════╗"
echo "║ ⚙️ SMKORTEX — Installation de CMake      ║"
echo "╚═════════════════════════════════════════╝"

# 🔍 Vérification de CMake
if dpkg -s cmake &> /dev/null; then
    echo "✅ CMake est déjà installé sur ce système."
else
    echo "📦 CMake non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y cmake

    if [ $? -eq 0 ]; then
        echo "✅ CMake installé avec succès."
    else
        echo "❌ Échec de l'installation de CMake."
        exit 1
    fi
fi

echo "🎯 Fin du script cmake_install.sh"
exit 0
