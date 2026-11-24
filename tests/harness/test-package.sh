#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PKG="$REPO_ROOT/package.json"

echo "Testing package.json Manifest..."

if [[ ! -f "$PKG" ]]; then
    echo "  ✗ Missing package.json"
    exit 1
fi

python3 -c "
import json, sys

with open('$PKG') as f:
    pkg = json.load(f)

assert pkg.get('name') == '@l3onkers/gaia-autonomous-framework', 'Invalid package name'
assert pkg.get('version') == '1.2.0', f'Invalid version: {pkg.get(\"version\")}'
assert 'publishConfig' in pkg, 'Missing publishConfig'
assert pkg['publishConfig'].get('registry') == 'https://npm.pkg.github.com', 'Invalid registry'
assert 'scripts' in pkg, 'Missing scripts'
print('  ✓ package.json matches release specification v1.2.0')
"

exit 0
