#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Governance CI Structure..."
if bash "$REPO_ROOT/.github/workflows/scripts/validate-structure.sh"; then
    echo "  ✓ Governance validation passed"
    exit 0
else
    echo "  ✗ Governance validation failed"
    exit 1
fi
