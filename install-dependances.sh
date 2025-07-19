#!/bin/bash

echo -e "\n📦 Installation des dépendances pour SMKortex..."

### Choix d'ambiance terminal
echo -e "\n🎛️ Choisissez votre ambiance :"
echo "1. Classique ➤ progression visible"
echo "2. Animation ➤ cmatrix uniquement"
echo "3. Mixte ➤ cmatrix + logs via tmux"
read -p "👉 Votre choix [1/2/3] : " USER_CHOICE

echo -e "\n🔄 Mise à jour et installation des packages..."
sudo apt update
sudo apt install -y git cmake g++ wget build-essential libcurl4-openssl-dev ccache

[[ "$USER_CHOICE" == "2" || "$USER_CHOICE" == "3" ]] && sudo apt install -y cmatrix

if [[ "$USER_CHOICE" == "3" ]]; then
  if ! command -v tmux &> /dev/null; then
    read -p "👉 Installer tmux pour activer le mode mixte ? [o/N] : " INSTALL_TMUX
    [[ "$INSTALL_TMUX" =~ ^[oO]$ ]] && sudo apt install -y tmux || USER_CHOICE="1"
  else
    echo "✅ tmux est déjà installé"
  fi
fi

### Sauvegarde du choix d’ambiance pour les autres scripts
mkdir -p config
echo "$USER_CHOICE" > config/ambiance.txt

echo -e "\n✅ Dépendances installées et ambiance définie 💚"
# 🧠 Lancement immédiat de l’ambiance choisie (si activée)
if [[ -f "$(dirname "$0")/ambienceur.sh" ]]; then
  bash "$(dirname "$0")/ambienceur.sh"
fi

