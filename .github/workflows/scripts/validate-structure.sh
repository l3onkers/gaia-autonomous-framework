#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$REPO_ROOT"

required_files=(
  "README.md"
  "QUICKSTART.md"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "docs/AGENTS.md"
  "docs/ARCHITECTURE.md"
  "docs/CREATING_AGENTS.md"
  "docs/CREATING_SKILLS.md"
  "docs/CUSTOMIZATION.md"
  "docs/INTERNAL_REFERENCE.md"
  "docs/SKILLS.md"
  ".github/AGENT.md"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "::error file=$file::Missing required governed file"
    exit 1
  fi
done

expected_agents=10
actual_agents=$(find .github/agents -maxdepth 1 -name '*.agent.md' | wc -l | tr -d ' ')
if [[ "$actual_agents" -ne "$expected_agents" ]]; then
  echo "::error file=.github/agents::Expected ${expected_agents} agent entrypoints but found ${actual_agents}"
  exit 1
fi

while IFS= read -r agent_file; do
  agent_name=$(basename "$agent_file" .agent.md)
  companion_dir=".github/agents/${agent_name}"
  if [[ -d "$companion_dir" ]]; then
    if ! find "$companion_dir" -maxdepth 1 -type f \( -name '*.tpl.md' -o -name '*.checklist.md' \) | grep -q .; then
      echo "::error file=${companion_dir}::Companion directory exists but has no template or checklist assets"
      exit 1
    fi
  fi
done < <(find .github/agents -maxdepth 1 -name '*.agent.md' | sort)

while IFS= read -r skill_dir; do
  manifest_file="${skill_dir}/SKILL.md"
  assets_dir="${skill_dir}/assets"

  if [[ ! -f "$manifest_file" ]]; then
    echo "::error file=${skill_dir}::Missing SKILL.md manifest"
    exit 1
  fi

  exempt_skills=("hephaestus-build-agent" "hephaestus-build-skill" "eleuthia-ui-styles" "eleuthia-ui-components" "eleuthia-ui-mockups" "apollo-markdown" "apollo-runbook" "git-workflow")
  skill_name=$(basename "$skill_dir")
  is_exempt=0
  for exempt in "${exempt_skills[@]}"; do
    if [[ "$exempt" == "$skill_name" ]]; then
      is_exempt=1
      break
    fi
  done

  if [[ "$is_exempt" -eq 1 ]]; then
    continue
  fi

  if [[ ! -d "$assets_dir" ]]; then
    echo "::error file=${skill_dir}::Missing assets directory"
    exit 1
  fi

  if ! find "$assets_dir" -maxdepth 1 -type f \( -name '*.tpl.md' -o -name '*.checklist.md' \) | grep -q .; then
    echo "::error file=${skill_dir}::Missing template or checklist assets"
    exit 1
  fi
done < <(find .github/skills -mindepth 1 -maxdepth 1 -type d | sort)

echo "Repository governance structure validated successfully."
exit 0
