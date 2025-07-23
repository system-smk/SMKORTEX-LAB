#!/bin/bash

echo "╔══════════════════════════════════════╗"
echo "║ 🌐 SMKORTEX — Installation de Curl   ║"
echo "╚══════════════════════════════════════╝"

# 🔍 Vérification de curl via dpkg
if dpkg -s curl &> /dev/null; then
    echo "✅ Curl est déjà présent sur ce système."
else
    echo "📦 Curl non détecté — installation en cours..."
    sudo apt update
    sudo apt install -y curl

    if [ $? -eq 0 ]; then
        echo "✅ Curl installé avec succès."
    else
        echo "❌ Échec de l'installation de Curl."
        exit 1
    fi
fi

echo "🎯 Fin du script curl_install.sh"
exit 0
