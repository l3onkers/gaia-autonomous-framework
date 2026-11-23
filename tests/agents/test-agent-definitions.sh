#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Per-Agent Unit Scenarios (10 Subroutines)..."

AGENTS=(
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

errors=0

for agent in "${AGENTS[@]}"; do
    agent_gh="$REPO_ROOT/.github/agents/${agent}.agent.md"
    agent_antigravity="$REPO_ROOT/.agents/agents/${agent}.md"

    # 1. Copilot Agent bundle exists
    if [[ ! -f "$agent_gh" ]]; then
        echo "  ✗ [$agent] Missing .github/agents/${agent}.agent.md"
        errors=$((errors + 1))
        continue
    fi

    # 2. Antigravity Subagent definition exists
    if [[ ! -f "$agent_antigravity" ]]; then
        echo "  ✗ [$agent] Missing .agents/agents/${agent}.md"
        errors=$((errors + 1))
        continue
    fi

    # 3. Check name matches in both
    if ! grep -q "^name: \"\?${agent}\"\?" "$agent_gh"; then
        echo "  ✗ [$agent] Name mismatch or missing in $agent_gh"
        errors=$((errors + 1))
    fi

    if ! grep -q "^name: \"\?${agent}\"\?" "$agent_antigravity"; then
        echo "  ✗ [$agent] Name mismatch or missing in $agent_antigravity"
        errors=$((errors + 1))
    fi

    # 4. Check companion directory if it exists
    comp_dir="$REPO_ROOT/.github/agents/${agent}"
    if [[ -d "$comp_dir" ]]; then
        file_count=$(find "$comp_dir" -type f | wc -l)
        if [[ $file_count -eq 0 ]]; then
            echo "  ✗ [$agent] Empty companion directory: $comp_dir"
            errors=$((errors + 1))
        fi
    fi

    echo "  ✓ Agent [$agent] unit checks passed (Copilot bundle + Antigravity subagent)"
done

if [[ $errors -eq 0 ]]; then
    echo "  ✓ All 10 agent units passed individual validation"
    exit 0
else
    echo "  ✗ Agent unit testing failed with $errors errors"
    exit 1
fi
