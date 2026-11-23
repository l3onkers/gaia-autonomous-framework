#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SKILLS_DIR="$REPO_ROOT/.github/skills"

echo "Testing Governed Skills SKILL.md & Frontmatter..."

total=0
errors=0

for skill_dir in "$SKILLS_DIR"/*/; do
    [[ -d "$skill_dir" ]] || continue
    skill_name="$(basename "$skill_dir")"
    skill_md="$skill_dir/SKILL.md"
    total=$((total + 1))

    if [[ ! -f "$skill_md" ]]; then
        echo "  ✗ Missing SKILL.md in $skill_name"
        errors=$((errors + 1))
        continue
    fi

    if ! grep -q "^name:" "$skill_md"; then
        echo "  ✗ Skill $skill_name missing 'name:' in frontmatter"
        errors=$((errors + 1))
    fi

    if ! grep -q "^description:" "$skill_md"; then
        echo "  ✗ Skill $skill_name missing 'description:' in frontmatter"
        errors=$((errors + 1))
    fi
done

if [[ $errors -eq 0 && $total -ge 40 ]]; then
    echo "  ✓ All $total governed skills verified with valid SKILL.md frontmatter"
    exit 0
else
    echo "  ✗ Skill verification failed: $errors errors out of $total skills"
    exit 1
fi
