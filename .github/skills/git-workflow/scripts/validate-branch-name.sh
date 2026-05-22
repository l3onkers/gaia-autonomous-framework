#!/usr/bin/env bash
# Validates a branch name against the Company git-workflow pattern.
# Usage: validate-branch-name.sh <branch-name>
# Exit 0 = valid, Exit 1 = invalid

set -euo pipefail

PATTERN='^(feat|fix|hotfix|docs|chore)/[a-z0-9][a-z0-9-]*$'

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <branch-name>" >&2
  exit 2
fi

BRANCH="$1"

if [[ "$BRANCH" =~ $PATTERN ]]; then
  echo "✓ Valid branch name: $BRANCH"
  exit 0
else
  echo "✗ Invalid branch name: $BRANCH" >&2
  echo "  Expected pattern: $PATTERN" >&2
  echo "  Allowed prefixes: feat, fix, hotfix, docs, chore" >&2
  echo "  Description must be lowercase kebab-case starting with [a-z0-9]" >&2
  exit 1
fi
