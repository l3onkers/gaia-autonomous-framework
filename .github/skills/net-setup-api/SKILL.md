---
name: net-setup-api
description: 'Use when: net-build must apply the profile-specific rules for the `api` .NET setup profile.'
user-invocable: false
---

# Net Setup API Skill

## Purpose
- This skill owns the profile-specific `.NET` setup rules for the resolved `api` profile.
- This skill is used by `net-build` after the coordinator resolves one bounded run to `api`.
- This skill stays within the resolved `api` profile while shared setup governance remains owned by the `net-build` coordinator.

## Output Contract
- One bounded profile-specific setup rule set for the resolved `api` profile
- The skill-owned profile-specific contract is defined by `./assets/net-setup-api.tpl.md`

If the resolved active profile is not `api`, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/net-setup-api.tpl.md`
- Owned `*.checklist.md` assets: `Not applicable.`
- Additional governed inputs: `Not applicable.`

## When to Use
- `net-build` has already resolved the bounded run to the `api` profile.
- `net-build` has already resolved the bounded run and loaded its shared governance inputs.
- The run needs only the `api`-specific rules owned by `./assets/net-setup-api.tpl.md`.
- No other routed `net-build` profile skill may satisfy the same run.

## Procedure
1. Confirm the already-resolved active profile is `api`.
2. Consume the shared `net-build` governance already resolved and loaded by the coordinator.
3. Load only the skill-owned profile template asset `./assets/net-setup-api.tpl.md` after the shared inputs.
4. Apply shared setup rules provided by the coordinator first and then apply the `api`-specific rules from `./assets/net-setup-api.tpl.md`.
5. Keep shared setup rules and setup-owned QA attributable to the `net-build` coordinator's shared governance, and keep only `api`-specific rules attributable to `./assets/net-setup-api.tpl.md`.
6. If the owned profile template asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
7. Validate the bounded result against the coordinator's shared checklist, this skill manifest, and the owned profile template asset before finalizing.

## Validation and Compliance Decision Rules
- Validate that this skill is used only for the resolved `api` profile.
- Validate that shared `net-build` governance inputs remain attributable to the coordinator's shared governance and are not duplicated in this skill.
- Validate that only `./assets/net-setup-api.tpl.md` is loaded as the skill-owned asset after the shared inputs.
- Validate that `api`-specific rules remain attributable to `./assets/net-setup-api.tpl.md`.
- If shared and profile-specific rules conflict, shared setup governance wins unless the user explicitly overrides it.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. The resolved profile and bounded-run context supplied by `net-build`
  2. Shared setup governance provided by the `net-build` coordinator
  3. Shared validation rules provided by the `net-build` coordinator
  4. `./assets/net-setup-api.tpl.md`
  5. Explicit repository evidence inside the bounded setup scope
- Use `Unknown`, `Not applicable.`, and `To be defined.` exactly when the available governed inputs require them.
- Do not infer shared setup rules from this skill when they are already owned by the `net-build` coordinator's shared governance.
- If required `api`-specific detail is absent from the owned profile template asset, stop and request clarification instead of guessing.

## Determinism Rules
- Resolve this skill only when the active profile has already been determined as `api`.
- Consume the shared `net-build` governance inputs before loading any skill-owned asset.
- Load exactly one skill-owned asset for this skill: `./assets/net-setup-api.tpl.md`.
- Do not load any other routed `net-build` profile skill or any undeclared companion asset.
- Given identical resolved inputs and repository state, the loaded asset set and `api`-specific output of this skill MUST be functionally identical.

## Validation
- Structural checks:
  - The six required headings remain present and ordered exactly as required by `.github/skills/supervise-skill/SKILL.md`.
  - The declared owned template path is skill-relative and exists for the current run.
- Ownership checks:
  - Shared setup rules remain attributable to the `net-build` coordinator's shared governance.
  - Shared setup QA remains attributable to the `net-build` coordinator's shared validation rules.
  - Only the resolved `api` rules remain attributable to `./assets/net-setup-api.tpl.md`.
- Scope checks:
  - This skill remains bound to the `api` profile only.
  - This skill does not widen the run beyond the already-resolved `net-build` scope.

## Constraints
- Do not widen the run beyond the resolved `api` profile.
- Do not load another `net-build` profile skill for the same run.
- Do not modify shared `net-build` governance during normal setup execution.
- Do not treat this skill as a standalone top-level agent.
