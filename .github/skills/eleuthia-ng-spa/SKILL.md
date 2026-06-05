---
name: eleuthia-ng-spa
description: 'Use when: an Angular build workflow must apply the profile-specific rules for the `spa` Angular setup profile.'
user-invocable: false
---

# Ng Setup SPA Skill

## Purpose
- This skill owns profile-specific Angular setup behavior for the `spa` profile.
- This skill is used by any caller that has already resolved the active Angular profile to `spa`.
- This skill stays within the `spa` profile scope while keeping its Angular setup governance and SPA shell rules inside skill-owned companion assets.
- This skill defines the current supported corporate Angular frontend shape as a no-routing single-page shell with a shared header wrapper and optional SSO login wrapper.

## Output Contract
- One profile-specific setup rule set for the `spa` profile
- The owned profile template asset `./assets/eleuthia-ng-spa.tpl.md`
- The owned login template asset `./assets/eleuthia-ng-spa.login.tpl.md`
- The owned validation checklist `./assets/eleuthia-ng-spa.checklist.md`

If the active profile is not `spa`, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets:
  - `./assets/eleuthia-ng-spa.tpl.md`
  - `./assets/eleuthia-ng-spa.login.tpl.md`
- Owned `*.checklist.md` assets: `./assets/eleuthia-ng-spa.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller has resolved the active profile to `spa`.
- The run needs Angular setup governance plus SPA-specific shell structure, wrapper-component generation, or login-feature handling captured in this skill's owned assets.
- The skill must remain independent from `.github/agents/*.md` files while preserving its integrated execution flow.

## Procedure
1. Confirm the active profile is `spa`.
2. Load `./assets/eleuthia-ng-spa.checklist.md` and `./assets/eleuthia-ng-spa.tpl.md`.
3. Load `./assets/eleuthia-ng-spa.login.tpl.md` only when the user requests login generation or authentication-feature scaffolding.
4. Use `./assets/eleuthia-ng-spa.tpl.md` as the single authoritative template for Angular setup defaults, SPA-specific inputs, no-routing shell structure, wrapper components, and validation behavior.
5. Follow the owned template asset for the governed Angular setup and SPA shell rules for the selected run.
6. If the owned template asset or required login companion is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
7. Validate the result against `./assets/eleuthia-ng-spa.checklist.md`, the owned template asset, and the login companion when used.

## Validation and Compliance Decision Rules
- Validate that only one active profile skill is used for the run.
- Validate that integrated Angular setup and `spa`-specific rules remain attributable to `./assets/eleuthia-ng-spa.tpl.md`.
- Validate that login-specific rules remain attributable to `./assets/eleuthia-ng-spa.login.tpl.md` when login generation is requested.
- Validate that the active `spa` profile remains a no-routing single-page shell rather than a routed feature scaffold.
- If the integrated Angular setup and SPA-specific rules cannot satisfy the request without guessing, stop and request clarification instead of inventing a hybrid rule.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Validation

- Validate that every governed companion declared in `## Governance Inputs` exists within the owning skill root.
- Validate that the procedure keeps the working set bounded to the profile asset, the checklist, and the optional login asset.
- Validate that no `.github/agents/*.md` file is required for normal execution of this skill.

## Constraints
- Do not widen the run beyond the resolved `spa` profile.
- Do not depend on `.github/agents/*.md` files during normal setup execution.
- Do not treat this skill as a standalone top-level agent.
- Do not bypass the governed login companion when the requested output is a login feature.