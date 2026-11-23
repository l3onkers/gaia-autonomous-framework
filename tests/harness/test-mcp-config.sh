#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG="$REPO_ROOT/mcp_config.json"

echo "Testing MCP Configuration..."

if [[ ! -f "$CONFIG" ]]; then
    echo "  ✗ Missing mcp_config.json"
    exit 1
fi

# Verify JSON syntax and keys using Python
python3 -c "
import json, sys

with open('$CONFIG') as f:
    data = json.load(f)

if 'mcpServers' not in data:
    print('  ✗ Missing mcpServers root key', file=sys.stderr)
    sys.exit(1)

servers = data['mcpServers']
expected = ['filesystem', 'fetch', 'git', 'postgres']
for s in expected:
    if s not in servers:
        print(f'  ✗ Missing server: {s}', file=sys.stderr)
        sys.exit(1)
    if 'command' not in servers[s]:
        print(f'  ✗ Missing command for server: {s}', file=sys.stderr)
        sys.exit(1)

print('  ✓ MCP config contains all expected servers (filesystem, fetch, git, postgres)')
"

exit 0
