#!/usr/bin/env bash
# Validates a commit message subject line against the Company conventional-commit pattern.
# Usage: validate-commit-message.sh <commit-subject>
#   or:  validate-commit-message.sh   (reads from stdin, one subject per line)
# Exit 0 = all valid, Exit 1 = any invalid

set -euo pipefail

PATTERN='^(feat|fix|docs|chore|refactor|test)(\([a-z0-9-]+\))?: .+$'
ALLOWED_SCOPES="data, features, validation, metrics, modeling, io, ci, security"

validate_subject() {
  local subject="$1"
  if [[ "$subject" =~ $PATTERN ]]; then
    echo "✓ Valid: $subject"
    return 0
  else
    echo "✗ Invalid: $subject" >&2
    echo "  Expected pattern: <type>(<scope>): <subject>  or  <type>: <subject>" >&2
    echo "  Allowed types: feat, fix, docs, chore, refactor, test" >&2
    echo "  Suggested scopes: $ALLOWED_SCOPES" >&2
    return 1
  fi
}

exit_code=0

if [[ $# -ge 1 ]]; then
  validate_subject "$*" || exit_code=1
else
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    validate_subject "$line" || exit_code=1
  done
fi

exit "$exit_code"
