#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Specific Governed Skills & Validation Tools..."

errors=0

# 1. Test governed platform skills (SKILL.md + tpl.md + checklist.md + 6 required headings)
GOVERNED_SKILLS=(
    "gaia-knowledge-ingest"
    "aether-k8s-gateway-api"
    "hephaestus-argocd-gitops"
    "apollo-observability-stack"
)

REQUIRED_HEADINGS=(
    "## Purpose"
    "## Output Contract"
    "## Governance Inputs"
    "## When to Use"
    "## Procedure"
    "## Validation and Compliance Decision Rules"
)

for s in "${GOVERNED_SKILLS[@]}"; do
    SKILL_DIR="$REPO_ROOT/.github/skills/$s"
    if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
        echo "  ✗ $s is missing SKILL.md"
        errors=$((errors + 1))
        continue
    fi
    if [[ ! -f "$SKILL_DIR/assets/${s}.tpl.md" ]]; then
        echo "  ✗ $s is missing assets/${s}.tpl.md"
        errors=$((errors + 1))
    fi
    if [[ ! -f "$SKILL_DIR/assets/${s}.checklist.md" ]]; then
        echo "  ✗ $s is missing assets/${s}.checklist.md"
        errors=$((errors + 1))
    fi
    for h in "${REQUIRED_HEADINGS[@]}"; do
        if ! grep -q "^${h}$" "$SKILL_DIR/SKILL.md"; then
            echo "  ✗ $s SKILL.md missing required heading: $h"
            errors=$((errors + 1))
        fi
    done
done

# 2. Test apollo-git-workflow validation scripts
APOLLO_DIR="$REPO_ROOT/.github/skills/apollo-git-workflow"
BRANCH_VAL="$APOLLO_DIR/scripts/validate-branch-name.sh"
COMMIT_VAL="$APOLLO_DIR/scripts/validate-commit-message.sh"

if [[ ! -x "$BRANCH_VAL" ]]; then
    echo "  ✗ $BRANCH_VAL is missing or not executable"
    errors=$((errors + 1))
else
    # Test valid and invalid branch names
    if ! bash "$BRANCH_VAL" "feat/test-sample" >/dev/null 2>&1; then
        echo "  ✗ $BRANCH_VAL failed on valid branch feat/test-sample"
        errors=$((errors + 1))
    fi
    if bash "$BRANCH_VAL" "invalid_branch" >/dev/null 2>&1; then
        echo "  ✗ $BRANCH_VAL erroneously accepted invalid_branch"
        errors=$((errors + 1))
    fi
fi

if [[ ! -x "$COMMIT_VAL" ]]; then
    echo "  ✗ $COMMIT_VAL is missing or not executable"
    errors=$((errors + 1))
else
    # Test valid and invalid commit messages
    if ! bash "$COMMIT_VAL" "feat(test): valid message" >/dev/null 2>&1; then
        echo "  ✗ $COMMIT_VAL failed on valid message"
        errors=$((errors + 1))
    fi
    if bash "$COMMIT_VAL" "bad commit" >/dev/null 2>&1; then
        echo "  ✗ $COMMIT_VAL erroneously accepted bad commit"
        errors=$((errors + 1))
    fi
fi

if [[ $errors -eq 0 ]]; then
    echo "  ✓ Governed skills and executable validation scripts pass all checks"
    exit 0
else
    echo "  ✗ Skill verification failed with $errors errors"
    exit 1
fi
