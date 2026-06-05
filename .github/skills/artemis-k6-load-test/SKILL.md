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
