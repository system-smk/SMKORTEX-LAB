#!/bin/bash

echo -e "\n📦 Installation des dépendances pour SMKORTEX..."

# 🎛️ Choix de l’ambiance
echo -e "\n🎛️ Choisissez votre ambiance :"
echo "1. Classique ➤ sans effet visuel"
echo "2. Mixte ➤ cmatrix + verbosité en split terminal"
read -p "👉 Votre choix [1/2] : " USER_CHOICE
# 🎛️ Ambiance visuelle ➤ lancement synchrone
if [[ -f "scripts/ambienceur.sh" ]]; then
  bash "scripts/ambienceur.sh"
fi

# 📁 Sauvegarde du choix
mkdir -p config logs
echo "$USER_CHOICE" > config/ambiance.txt

# 📡 Initialisation du fichier log partagé
LOGFILE="logs/session_$(date +"%H-%M_%d-%m-%Y").log"
touch "$LOGFILE"

# 🧠 Lancement de l'ambiance visuelle en arrière-plan
if [[ -f "$(dirname "$0")/ambienceur.sh" ]]; then
  bash "$(dirname "$0")/ambienceur.sh" &
fi

# 📜 Capture de la verbosité système (stdout + stderr)
exec > >(tee -a "$LOGFILE") 2>&1

# 🔄 Mise à jour système
echo -e "\n🔄 Mise à jour et installation des packages..."
sudo apt update
sudo apt install -y git cmake g++ wget build-essential libcurl4-openssl-dev ccache

# 🎞️ Installation de cmatrix si nécessaire
[[ "$USER_CHOICE" == "2" ]] && sudo apt install -y cmatrix

# 🎛️ Vérification de tmux
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

echo -e "\n✅ Dépendances installées et ambiance définie 💎"
