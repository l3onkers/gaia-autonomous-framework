#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing UTF-8 Encoding, BOM & Mojibake Cleanliness..."

cd "$REPO_ROOT"
bom_files=$(git ls-files | while IFS= read -r f; do
    if [[ -f "$f" ]]; then
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
fi
echo "  ✓ No UTF-8 BOM detected across all tracked files"

python3 -c '
import subprocess, re, sys

mojibake_re = re.compile(r"(\u00f0\u0178|\u00e2\u20ac|\u00c2\u00a7|\ufffd)")
files = subprocess.check_output(["git", "ls-files"]).decode("utf-8").splitlines()
bad = []
for f in files:
    if f.endswith((".png", ".jpg", ".jpeg", ".gif", ".ico", ".svg")) or f == "tests/harness/test-encoding.sh":
        continue
    try:
        text = open(f, "r", encoding="utf-8").read()
    except Exception:
        continue
    if mojibake_re.search(text):
        bad.append(f)

if bad:
    print("  ✗ Found UTF-8 Mojibake corruption in files:", ", ".join(bad))
    sys.exit(1)
print("  ✓ No UTF-8 Mojibake sequences detected across all tracked files")
'
exit 0
