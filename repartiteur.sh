#!/bin/bash

QUERY="$1"
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# === 🧪 Vérification basique
if [[ -z "$QUERY" ]]; then
  echo "❌ Aucun message à analyser."
  exit 1
fi

# === 📘 Route vers glossaire si mots clés d’abréviations
if echo "$QUERY" | grep -iqE "APS|SSI|CMSI|SDI|DS|DAC|DM|DAS|CGE|CMSI|SSIAP|NF|NFS"; then
  bash "$ROOTDIR/scripts/abrv.sh" "$QUERY"
  exit 0
fi

# === 🔥 Route vers corpus incendie si mots clés détectés
if echo "$QUERY" | grep -iqE "désenfumage|alarme|évacuation|incendie|extincteur|fumée|clapet|sprinkler|CMSI|SSIAP"; then
  bash "$ROOTDIR/scripts/rag-engine.sh" "$QUERY"
  exit 0
fi

# === 🤖 Route vers LLM généraliste pour tout le reste
bash "$ROOTDIR/scripts/instChatv2-kortex.sh" "$QUERY"
