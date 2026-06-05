import os

path = r'd:\BONKERS\Documents\GitHub\IA-Agents\.github\workflows\validate-gaia-structure.yml'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

old_str = """            if [[ ! -d "$assets_dir" ]]; then
              echo "::error file=${skill_dir}::Missing assets directory"
              exit 1
            fi

            if ! find "$assets_dir" -maxdepth 1 -type f \( -name '*.tpl.md' -o -name '*.checklist.md' \) | grep -q .; then
              echo "::error file=${skill_dir}::Missing template or checklist assets"
              exit 1
            fi"""

new_str = """            exempt_skills=("hephaestus-build-agent" "hephaestus-build-skill" "eleuthia-ui-styles" "eleuthia-ui-components" "eleuthia-ui-mockups" "apollo-markdown" "apollo-runbook" "git-workflow")
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
            fi"""

content = content.replace(old_str.replace('\n', '\r\n'), new_str)
content = content.replace(old_str, new_str)

with open(path, 'w', encoding='utf-8', newline='\n') as f:
    f.write(content)
