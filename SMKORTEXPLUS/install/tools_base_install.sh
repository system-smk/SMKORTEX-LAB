#!/bin/bash

# 📁 Dossier log
mkdir -p install
LOG="install/install.log"

echo "🧠 Lancement installation complète — $(date)" > "$LOG"

# ✅ Fonction : vérifie et installe si absent
check_and_install() {
  PACKAGE="$1"
  SCRIPT="$2"

  if dpkg -s "$PACKAGE" >/dev/null 2>&1; then
    echo "✅ $PACKAGE déjà installé." | tee -a "$LOG"
  else
    echo "🛠️ Installation de $PACKAGE via $SCRIPT..." | tee -a "$LOG"
    if bash "install/$SCRIPT" >> "$LOG" 2>&1; then
      echo "✅ $PACKAGE installé avec succès." | tee -a "$LOG"
    else
      echo "❌ Échec installation de $PACKAGE." | tee -a "$LOG"
    fi
  fi
}

# 🔧 Modules système à vérifier
check_and_install build-essential "buildtools_install.sh"
check_and_install cmake "cmake_install.sh"
check_and_install curl "curl_install.sh"
check_and_install git "git_install.sh"
check_and_install libboost-all-dev "boostProc_install.sh"
check_and_install libprotobuf-dev "protobuf_install.sh"
check_and_install libsentencepiece-dev "sentencepiece_install.sh"
check_and_install nlohmann-json-dev "jsonlib_install.sh"

echo "📦 Installation terminée — consulte le log : $LOG"
