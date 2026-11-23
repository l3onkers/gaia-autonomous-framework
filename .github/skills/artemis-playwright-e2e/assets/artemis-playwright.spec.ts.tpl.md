---
name: artemis-playwright-e2e
description: 'Use when: artemis resolves a request to generate End-to-End (E2E) UI testing boilerplate using Playwright.'
user-invocable: false
---

# Playwright E2E Setup

## Purpose
- Bootstraps a Playwright testing suite.
- Configures parallel execution and retries.

## Output Contract
- 	ests/e2e/playwright.config.ts
- 	ests/e2e/example.spec.ts
"@ | Out-File -FilePath "d:\BONKERS\Documents\GitHub\IA-Agents\.github\skills\artemis-playwright-e2e\SKILL.md" -Encoding UTF8 -Force

@"
import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto(process.env.TARGET_URL || 'https://staging.example.com');
  await expect(page).toHaveTitle(/App/);
});
