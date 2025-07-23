#!/bin/bash

echo "╔═══════════════════════════════════════════════╗"
echo "║ 📊 SMKORTEX — Installation de la JSON Library ║"
echo "╚═══════════════════════════════════════════════╝"

# 🔍 Vérification via dpkg
if dpkg -s nlohmann-json3-dev &> /dev/null; then
    echo "✅ La bibliothèque JSON est déjà installée."
else
    echo "📦 nlohmann-json3-dev non détectée — installation en cours..."
    sudo apt update
    sudo apt install -y nlohmann-json3-dev

    if [ $? -eq 0 ]; then
        echo "✅ Bibliothèque JSON installée avec succès."
    else
        echo "❌ Échec de l'installation de la lib JSON."
        exit 1
    fi
fi

echo "🎯 Fin du script jsonlib_install.sh"
exit 0
