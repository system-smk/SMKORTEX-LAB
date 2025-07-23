#!/bin/bash

echo "╔════════════════════════════════════════════════╗"
echo "║ 🧠 SMKORTEX — Installation Boost::Process (APT) ║"
echo "╚════════════════════════════════════════════════╝"

# Vérifie si Boost est déjà installé
if dpkg -s libboost-all-dev &> /dev/null; then
    echo "✅ Boost est déjà présent sur le système."
else
    echo "📦 libboost-all-dev non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y libboost-all-dev

    if [ $? -eq 0 ]; then
        echo "✅ Boost installé avec succès."
    else
        echo "❌ Erreur pendant l'installation de Boost."
        exit 1
    fi
fi

echo "🎯 Fin du script boostProc_install.sh"
exit 0
