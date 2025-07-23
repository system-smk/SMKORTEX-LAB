#!/bin/bash

# 🧠 Configuration
DATE=$(date +"%d-%m-%Y_%H-%M")
LOG="install/setup_log_$DATE.log"
ARCHIVE="install/premiere_install_$DATE.sh"
LAUNCHER="kortexecute.sh"

# 🗂️ Préparer les dossiers
mkdir -p install
echo "🧠 [SMKORTEX] Installation initiale — $DATE" > "$LOG"

echo ""
echo "🔧 [1/4] Installation des dépendances système"
bash install/tools_base_install.sh >> "$LOG" 2>&1

echo ""
echo "🧠 [2/4] Installation des modules IA (llamacpp & vigogne)"
bash scripts/llamacpp_install.sh >> "$LOG" 2>&1
bash scripts/vigogne_install.sh >> "$LOG" 2>&1

echo ""
echo "📦 [3/4] Compilation du terminal SMKORTEX"
mkdir -p build
cd build
cmake .. >> "../$LOG" 2>&1
make >> "../$LOG" 2>&1
cd ..

# 🧪 Vérification et lancement
if [ -f "build/kortex_terminal" ]; then
  echo ""
  echo "✅ Compilation réussie — Terminal prêt." | tee -a "$LOG"

  # 🚀 Création du lanceur kortexecute.sh
  echo "#!/bin/bash" > "$LAUNCHER"
  echo "./build/kortex_terminal" >> "$LAUNCHER"
  chmod +x "$LAUNCHER"
  echo "🚀 Utilise : ./$LAUNCHER pour lancer SMKORTEX." | tee -a "$LOG"

  # 📦 Archive du script d'installation avec horodatage
  mv "$0" "$ARCHIVE"
  echo "🗃️ Script déplacé vers : $ARCHIVE" | tee -a "$LOG"

  # 🌟 Message de bienvenue personnalisé
  echo ""
  echo "╔════════════════════════════════════════╗"
  echo "║   🚀 SMKORTEX est prêt à pulser !    ║"
  echo "║   Lance-le avec : ./kortexecute.sh    ║"
  echo "╚════════════════════════════════════════╝"
else
  echo ""
  echo "❌ Compilation échouée — vérifie le log : $LOG" | tee -a "$LOG"
fi
