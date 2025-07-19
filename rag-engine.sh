#!/bin/bash

QUERY="$1"
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CORPUS_DIR="$ROOTDIR/rag/incendie"

# === 🧪 Vérification
if [[ -z "$QUERY" ]]; then
  echo "❌ Aucun texte à analyser"
  exit 1
fi

if [[ ! -d "$CORPUS_DIR" ]]; then
  echo "❌ Corpus non disponible ➤ rag/incendie/ introuvable"
  exit 1
fi

# === 🔍 Recherche
echo -e "🔎 Recherche dans le corpus incendie..."
MATCHES=$(grep -i -H "$QUERY" "$CORPUS_DIR"/*.txt | head -n 10)

if [[ -z "$MATCHES" ]]; then
  echo "🚫 Aucun résultat trouvé dans le corpus incendie."
else
  echo -e "\n📖 Résultats :"
  echo "$MATCHES" | while IFS=: read -r file line text; do
    FILENAME=$(basename "$file")
    echo -e "📁 \e[1m$FILENAME\e[0m ➤ $text"
  done
fi
