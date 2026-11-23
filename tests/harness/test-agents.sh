#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
AGENTS_DIR="$REPO_ROOT/.github/agents"

EXPECTED_AGENTS=(
    "gaia"
    "hephaestus"
    "minerva"
    "apollo"
    "eleuthia"
    "demeter"
    "aether"
    "hades"
    "poseidon"
    "artemis"
)

echo "Testing Governed Agents Frontmatter & Existence..."

missing=0
invalid=0

for agent in "${EXPECTED_AGENTS[@]}"; do
    file="$AGENTS_DIR/${agent}.agent.md"
    if [[ ! -f "$file" ]]; then
        echo "  ✗ Missing agent definition: $file"
        missing=$((missing + 1))
        continue
    fi

    # Check YAML frontmatter (starts with ---, has name: and description:, closes with ---)
    if ! grep -q "^name:" "$file"; then
        echo "  ✗ Agent $agent is missing 'name:' in frontmatter"
        invalid=$((invalid + 1))
    fi

    if ! grep -q "^description:" "$file"; then
        echo "  ✗ Agent $agent is missing 'description:' in frontmatter"
        invalid=$((invalid + 1))
    fi
done

if [[ $missing -eq 0 && $invalid -eq 0 ]]; then
    echo "  ✓ All 10 governed agents verified with valid frontmatter"
    exit 0
else
    echo "  ✗ Agent verification failed: $missing missing, $invalid invalid"
    exit 1
fi
