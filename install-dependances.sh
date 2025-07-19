#!/bin/bash

echo -e "\n📦 Installation des dépendances pour SMKORTEX..."

# 🎛️ Choix de l’ambiance
echo -e "\n🎛️ Choisissez votre ambiance :"
echo "1. Classique ➤ sans effet visuel"
echo "2. Mixte ➤ cmatrix + logs en split terminal"
read -p "👉 Votre choix [1/2] : " USER_CHOICE

# 📁 Sauvegarde du choix
mkdir -p config
echo "$USER_CHOICE" > config/ambiance.txt

# 🔄 Installation des paquets de base
echo -e "\n🔄 Mise à jour et installation des packages..."
sudo apt update
sudo apt install -y git cmake g++ wget build-essential libcurl4-openssl-dev ccache

# 🎞️ Installation cmatrix si ambiance visuelle choisie
[[ "$USER_CHOICE" == "2" ]] && sudo apt install -y cmatrix

# 🎛️ Vérification et installation de tmux si ambiance mixte
if [[ "$USER_CHOICE" == "2" ]]; then
  if ! command -v tmux &> /dev/null; then
    read -p "👉 Installer tmux pour activer le mode mixte ? [o/N] : " INSTALL_TMUX
    if [[ "$INSTALL_TMUX" =~ ^[oO]$ ]]; then
      sudo apt install -y tmux
    else
      echo "❌ Mode mixte annulé ➤ ambiance classique activée"
      USER_CHOICE="1"
      echo "$USER_CHOICE" > config/ambiance.txt
    fi
  else
    echo "✅ tmux est déjà installé"
  fi
fi

# 🌈 Lancement immédiat de l’ambiance visuelle si disponible
if [[ -f "$(dirname "$0")/ambienceur.sh" ]]; then
  bash "$(dirname "$0")/ambienceur.sh"
fi

echo -e "\n✅ Dépendances installées et ambiance définie 💎"
