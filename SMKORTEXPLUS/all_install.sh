#!/bin/bash

echo "🛠️ [SMKORTEX] Initialisation complète des outils de base..."

LOG="install/install.log"
echo "🧠 Installation lancée — $(date +"%d-%m-%Y %H:%M")" > "$LOG"

# 📜 Liste des scripts à exécuter
scripts=(
  buildtools_install.sh
  cmake_install.sh
  curl_install.sh
  git_install.sh
  jsonlib_install.sh
  boostProc_install.sh
  protobuf_install.sh
  sentencepiece_install.sh
  tools_base_install.sh
)

# 🔁 Boucle sur les scripts
for script in "${scripts[@]}"; do
  if [ -f "install/$script" ]; then
    echo ""
    echo "🔧 Exécution de $script..."
    bash "install/$script" 2>&1 | tee -a "$LOG"
  else
    echo "⚠️ Script $script introuvable dans le dossier install/" | tee -a "$LOG"
  fi
done

echo ""
echo "✅ Tous les scripts ont été traités. Voir le log : $LOG"

