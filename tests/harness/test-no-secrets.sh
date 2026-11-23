#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Zero Leaked Secrets & Private Keys..."

cd "$REPO_ROOT"
errors=0

# 1. Private keys (excluding test files themselves)
if git ls-files | grep -v '^tests/' | xargs grep -l "PRIVATE KEY" 2>/dev/null; then
    echo "  ✗ Found private key pattern in tracked files"
    errors=$((errors + 1))
fi

# 2. AWS Access Keys
if git ls-files | grep -v '^tests/' | xargs grep -l -E 'AKIA[0-9A-Z]{16}' 2>/dev/null; then
    echo "  ✗ Found AWS Access Key pattern in tracked files"
    errors=$((errors + 1))
fi

# 3. Hardcoded passwords in non-templates
if git ls-files | grep -v '^tests/' | grep -v -E '(\.md$|\.yaml$|\.yml$|\.json$|\.tpl\.md$|\.checklist\.md$|SKILL\.md$)' | xargs grep -l -i -E '(password|passwd|secret|token|api_key|apikey|api-key)\s*[:=]' 2>/dev/null; then
    echo "  ✗ Found possible credentials in non-doc tracked files"
    errors=$((errors + 1))
fi

if [[ $errors -eq 0 ]]; then
    echo "  ✓ No leaked credentials or private keys detected"
    exit 0
else
    echo "  ✗ Security check failed with $errors findings"
    exit 1
fi
