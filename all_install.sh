#!/bin/bash

g++ src/anime.cpp -o build/logo
./build/logo &
echo "🧠 [SMKORTEX] Installation de base et compilation du module IA"

# 📁 Création du dossier build
mkdir -p build

# 📦 Compilation du module_installer.cpp
echo "🔧 Compilation de src/module_installer.cpp..."
g++ src/module_installer.cpp -o build/module_installer -std=c++17 -lboost_system

# 🧪 Vérification du binaire
if [ -f build/module_installer ]; then
    echo "✅ Compilation réussie : build/module_installer est prêt"

    echo ""
    echo "🚀 Lancement du module_installer pour cloner llama.cpp et télécharger Vigogne..."
    ./build/module_installer

    echo ""
    echo "🧩 Installation IA terminée. Le cortex SMKORTEX est connecté."
else
    echo "❌ Erreur de compilation — Impossible de lancer module_installer"
fi
