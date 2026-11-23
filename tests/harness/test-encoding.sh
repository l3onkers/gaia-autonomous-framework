#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing UTF-8 Encoding & BOM Cleanliness..."

cd "$REPO_ROOT"
bom_files=$(git ls-files | while IFS= read -r f; do
    if [[ -f "$f" ]]; then
        # check if starts with BOM (\xef\xbb\xbf)
        head_bytes=$(head -c 3 "$f" | od -An -tx1 | tr -d ' \n')
        if [[ "$head_bytes" == "efbbbf" ]]; then
            echo "$f"
        fi
    fi
done)

if [[ -n "$bom_files" ]]; then
    echo "  ✗ Found UTF-8 BOM in files:"
    echo "$bom_files" | sed 's/^/    /'
    exit 1
else
    echo "  ✓ No UTF-8 BOM detected across all tracked files"
    exit 0
fi
