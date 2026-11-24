#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CHANGELOG="$REPO_ROOT/CHANGELOG.md"

echo "Testing CHANGELOG.md..."

if [[ ! -f "$CHANGELOG" ]]; then
    echo "  ✗ Missing CHANGELOG.md"
    exit 1
fi

if ! grep -q "\[1.2.0\]" "$CHANGELOG"; then
    echo "  ✗ CHANGELOG.md missing [1.2.0] release entry"
    exit 1
fi

if ! grep -q "\[1.1.0\]" "$CHANGELOG"; then
    echo "  ✗ CHANGELOG.md missing [1.1.0] release entry"
    exit 1
fi

if ! grep -q "\[1.0.0\]" "$CHANGELOG"; then
    echo "  ✗ CHANGELOG.md missing [1.0.0] baseline entry"
    exit 1
fi

echo "  ✓ CHANGELOG.md contains entries for [1.2.0], [1.1.0] and [1.0.0]"
exit 0
