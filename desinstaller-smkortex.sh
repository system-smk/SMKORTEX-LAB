#!/bin/bash

echo -e "\n🧹 Désinstallation complète de SMKORTEX..."

# ✅ Confirmation utilisateur
read -p "🛑 Es-tu certain de vouloir supprimer tous les fichiers SMKORTEX ? [o/N] : " CONFIRM
[[ "$CONFIRM" =~ ^[oO]$ ]] || { echo "🚫 Désinstallation annulée."; exit 0; }

# 📁 Suppression des dossiers techniques
echo "📁 Suppression des dossiers : glossaire, rag, scripts, logs, llama..."
rm -rf glossaire rag scripts logs llama config webui

# 🗑️ Suppression des raccourcis globaux
echo "🧹 Suppression des raccourcis locaux/global..."
rm -f ~/.local/bin/smkortex
rm -f ~/.local/bin/webkortex
sudo rm -f /usr/local/bin/smkortex
sudo rm -f /usr/local/bin/webkortex

# 📦 Optionnel : supprimer le dossier SMKORTEX si lancé depuis sa racine
CURRENT_DIR=$(pwd)
BASENAME=$(basename "$CURRENT_DIR")

if [[ "$BASENAME" == "SMKORTEX" ]]; then
  echo -e "\n⚠️ Tu es dans le dossier SMKORTEX ➤ suppression possible..."
  read -p "🔁 Supprimer également le dossier SMKORTEX ? [o/N] : " WIPE
  if [[ "$WIPE" =~ ^[oO]$ ]]; then
    cd ..
    rm -rf "$BASENAME"
    echo "✅ Dossier '$BASENAME' supprimé."
    exit 0
  fi
fi

echo -e "\n✅ SMKORTEX désinstallé proprement. Tu pourras toujours le reconstruire quand tu voudras 🦙"

