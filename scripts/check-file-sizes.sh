#!/usr/bin/env bash
# check-file-sizes.sh
# Reports files exceeding the 300-line limit defined in Core Principle 3.
# Usage: ./scripts/check-file-sizes.sh [directory] (default: project root)

set -euo pipefail

LIMIT=300
SEARCH_DIR="${1:-.}"
VIOLATIONS=0

echo "Checking file sizes (limit: $LIMIT lines) in: $SEARCH_DIR"
echo "---"

while IFS= read -r -d '' file; do
  if [ -f "$file" ]; then
    lines=$(wc -l < "$file")
    if [ "$lines" -gt "$LIMIT" ]; then
      echo "OVER LIMIT: $file ($lines lines)"
      VIOLATIONS=$((VIOLATIONS + 1))
    fi
  fi
done < <(/usr/bin/git ls-files -z "$SEARCH_DIR" 2>/dev/null || find "$SEARCH_DIR" -type f -not -path '*/.*' -not -path '*/tmp/*' -print0)

echo "---"
if [ "$VIOLATIONS" -gt 0 ]; then
  echo "Found $VIOLATIONS file(s) exceeding $LIMIT lines."
  exit 1
else
  echo "All files are within the $LIMIT-line limit."
  exit 0
fi
