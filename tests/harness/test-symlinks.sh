#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Multi-Platform Symlinks..."

EXPECTED_SYMLINKS=(
    "$REPO_ROOT/.agents/skills:$REPO_ROOT/.github/skills"
    "$REPO_ROOT/.agents/rules/AGENTS.md:$REPO_ROOT/AGENTS.md"
    "$REPO_ROOT/.agents/mcp_config.json:$REPO_ROOT/mcp_config.json"
    "$REPO_ROOT/.mcp.json:$REPO_ROOT/mcp_config.json"
)

errors=0

for item in "${EXPECTED_SYMLINKS[@]}"; do
    link="${item%%:*}"
    target="${item##*:}"

    if [[ ! -L "$link" ]]; then
        echo "  ✗ Not a symlink: $link"
        errors=$((errors + 1))
        continue
    fi

    resolved="$(readlink -f "$link")"
    expected="$(readlink -f "$target")"

    if [[ "$resolved" != "$expected" ]]; then
        echo "  ✗ Symlink $link resolves to $resolved, expected $expected"
        errors=$((errors + 1))
    fi
done

if [[ $errors -eq 0 ]]; then
    echo "  ✓ All 4 multi-platform bridge symlinks resolve correctly"
    exit 0
else
    echo "  ✗ Symlink verification failed with $errors errors"
    exit 1
fi
