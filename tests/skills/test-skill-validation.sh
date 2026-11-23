#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "Testing Specific Governed Skills & Validation Tools..."

errors=0

# 1. Test gaia-knowledge-ingest
SKILL_DIR="$REPO_ROOT/.github/skills/gaia-knowledge-ingest"
if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
    echo "  ✗ gaia-knowledge-ingest is missing SKILL.md"
    errors=$((errors + 1))
fi

if [[ ! -f "$SKILL_DIR/assets/gaia-knowledge-ingest.tpl.md" ]]; then
    echo "  ✗ gaia-knowledge-ingest is missing assets/gaia-knowledge-ingest.tpl.md"
    errors=$((errors + 1))
fi

if [[ ! -f "$SKILL_DIR/assets/gaia-knowledge-ingest.checklist.md" ]]; then
    echo "  ✗ gaia-knowledge-ingest is missing assets/gaia-knowledge-ingest.checklist.md"
    errors=$((errors + 1))
fi

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
