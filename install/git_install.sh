#!/bin/bash

echo "╔════════════════════════════════════╗"
echo "║ 🧠 SMKORTEX — Installation de Git ║"
echo "╚════════════════════════════════════╝"

# 🔍 Vérification de Git via dpkg
if dpkg -s git &> /dev/null; then
    echo "✅ Git est déjà installé sur ce système."
else
    echo "📦 Git non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y git

    if [ $? -eq 0 ]; then
        echo "✅ Git installé avec succès."
    else
        echo "❌ Échec de l'installation de Git."
        exit 1
    fi
fi

echo "🎯 Fin du script git_install.sh"
exit 0
