#!/bin/bash

echo "╔═════════════════════════════════════════════╗"
echo "║ 🧠 SMKORTEX — Installation des outils C++    ║"
echo "╚═════════════════════════════════════════════╝"

# 🔍 Vérification du méta-paquet build-essential
if dpkg -s build-essential &> /dev/null; then
    echo "✅ Les outils de compilation C++ sont déjà installés."
else
    echo "📦 build-essential non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y build-essential

    if [ $? -eq 0 ]; then
        echo "✅ Outils de compilation installés avec succès."
    else
        echo "❌ Échec de l'installation de build-essential."
        exit 1
    fi
fi

echo "🎯 Fin du script buildtools_install.sh"
exit 0
