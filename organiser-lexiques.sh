#!/bin/bash
echo "📦 Organisation des fichiers texte dans glossaire/ et rag/…"

mkdir -p glossaire rag/incendie glossaire/abreviations

# Déplace les abréviations
find . -maxdepth 1 -type f -name "*_abreviations.txt" -exec mv {} glossaire/abreviations/ \;

# Déplace les corpus incendie
find . -maxdepth 1 -type f -name "*_incendie.txt" -exec mv {} rag/incendie/ \;

echo "✅ Fichiers répartis selon leur thème."
