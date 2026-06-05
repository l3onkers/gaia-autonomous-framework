---
name: artemis-k6-load-test
description: 'Use when: artemis resolves a request to generate a k6 load and performance testing script.'
user-invocable: false
---

# k6 Load Testing Script

## Purpose
- Generates a production-grade k6 load testing script with stages and thresholds.

## Output Contract
- 	ests/load/script.js

## Governance Rules
- Thresholds MUST be strictly defined (e.g., p(95) < 500ms).
- Scenarios MUST include a ramp-up, holding, and ramp-down phase.

## Assets
- ssets/artemis-k6.checklist.md
- ssets/artemis-k6.js.tpl.md
"@ | Out-File -FilePath "d:\BONKERS\Documents\GitHub\IA-Agents\.github\skills\artemis-k6-load-test\SKILL.md" -Encoding UTF8 -Force

@"
# k6 Load Test Checklist

- [ ] Execution stages (ramp-up, hold, ramp-down) are defined.
- [ ] Success thresholds (e.g., Error rate < 1%, p(95) < 500ms) are configured.
- [ ] Script uses environment variables for target URLs, not hardcoded strings.
