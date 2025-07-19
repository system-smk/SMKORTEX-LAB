#!/bin/bash

echo -e "\n🎛️ Choisissez votre ambiance :"
echo "1. Classique ➤ sans effet visuel"
echo "2. Mixte ➤ cmatrix + installation visible"
read -p "👉 Votre choix [1/2] : " USER_CHOICE

mkdir -p config
echo "$USER_CHOICE" > config/ambiance.txt

if [[ "$USER_CHOICE" == "2" ]]; then
  bash "scripts/ambienceur.sh"
else
  bash "scripts/install-core.sh"
fi

    echo "✅ tmux est déjà installé"
  fi
fi

echo -e "\n✅ Dépendances installées et ambiance définie 💎"
