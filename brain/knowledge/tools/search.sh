#!/usr/bin/env bash
# search.sh - naive full-text search over /wiki
# Usage: ./tools/search.sh "search term"

set -euo pipefail

QUERY="${1:-}"
WIKI_DIR="$(dirname "$0")/../wiki"

if [[ -z "$QUERY" ]]; then
  echo "Usage: search.sh \"<search term>\""
  exit 1
fi

echo "Searching wiki for: \"$QUERY\""
echo "---"

RESULTS=$(grep -rn --include="*.md" -i "$QUERY" "$WIKI_DIR" 2>/dev/null || true)

if [[ -z "$RESULTS" ]]; then
  echo "No results found."
  exit 0
fi

echo "$RESULTS"
echo "---"
COUNT=$(echo "$RESULTS" | wc -l | tr -d ' ')
echo "Total matches: $COUNT"
