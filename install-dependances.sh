#!/bin/bash

echo -e "\n🎛️ Choisissez votre ambiance :"
echo "1. Classique ➤ sans effet visuel"
echo "2. Mixte ➤ cmatrix + installation visible"
read -p "👉 Votre choix [1/2] : " USER_CHOICE

mkdir -p config
echo "$USER_CHOICE" > config/ambiance.txt

bash "scripts/ambienceur.sh"

