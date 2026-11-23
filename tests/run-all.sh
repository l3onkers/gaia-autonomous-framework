#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}${BLUE}═════════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${BLUE}  G.A.I.A. Autonomous Framework — Local Test Battery${NC}"
echo -e "${BOLD}${BLUE}═════════════════════════════════════════════════════════════════${NC}"
echo ""

TEST_SUITES=(
    "tests/harness/test-governance.sh"
    "tests/harness/test-agents.sh"
    "tests/harness/test-skills.sh"
    "tests/harness/test-symlinks.sh"
    "tests/harness/test-mcp-config.sh"
    "tests/harness/test-package.sh"
    "tests/harness/test-changelog.sh"
    "tests/harness/test-root-files.sh"
    "tests/harness/test-encoding.sh"
    "tests/harness/test-no-secrets.sh"
    "tests/agents/test-agent-definitions.sh"
    "tests/skills/test-skill-validation.sh"
)

passed=0
failed=0
total=${#TEST_SUITES[@]}

for test_script in "${TEST_SUITES[@]}"; do
    script_path="$REPO_ROOT/$test_script"
    suite_name="$(basename "$test_script")"
    dir_name="$(basename "$(dirname "$test_script")")"

    echo -e "${BOLD}▶ Running [${dir_name}/${suite_name}]...${NC}"
    if bash "$script_path"; then
        echo -e "${GREEN}  ✓ SUITE PASSED: ${dir_name}/${suite_name}${NC}"
        passed=$((passed + 1))
    else
        echo -e "${RED}  ✗ SUITE FAILED: ${dir_name}/${suite_name}${NC}"
        failed=$((failed + 1))
    fi
    echo ""
done

echo -e "${BOLD}${BLUE}═════════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}  Test Battery Summary${NC}"
echo -e "${BOLD}${BLUE}═════════════════════════════════════════════════════════════════${NC}"
echo -e "  Total Test Suites: $total"
echo -e "  Passed:            ${GREEN}${passed}${NC}"
echo -e "  Failed:            ${RED}${failed}${NC}"
echo -e "${BOLD}${BLUE}═════════════════════════════════════════════════════════════════${NC}"

if [[ $failed -eq 0 ]]; then
    echo -e "${GREEN}${BOLD}🎉 ALL $passed TEST SUITES PASSED LOCALLY! Ready for deployment.${NC}"
    exit 0
else
    echo -e "${RED}${BOLD}❌ $failed TEST SUITE(S) FAILED! Fix issues before pushing.${NC}"
    exit 1
fi
