#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Critical Root Files & Directories..."

REQUIRED_FILES=(
    "AGENTS.md"
    ".gitignore"
    "mcp_config.json"
    "package.json"
    "CHANGELOG.md"
    "docs/PLATFORMS.md"
    "knowledge/README.md"
    "knowledge/learnings/conventions.md"
    ".agents/skills.json"
)

errors=0
for f in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$REPO_ROOT/$f" ]]; then
        echo "  ✗ Missing required file: $f"
        errors=$((errors + 1))
    fi
done

if [[ $errors -eq 0 ]]; then
    echo "  ✓ All critical architecture and documentation files exist"
    exit 0
else
    echo "  ✗ Missing $errors critical files"
    exit 1
fi
