---
name: eleuthia-net-worker
description: 'Use when: net-build must apply the profile-specific rules for the `worker` .NET setup profile.'
user-invocable: false
---

# Net Setup Worker Skill

## Purpose
- This skill owns the profile-specific `.NET` setup rules for the resolved `worker` profile.
- This skill is used by `eleuthia` after the coordinator resolves one bounded run to `worker`.
- This skill stays within the resolved `worker` profile while shared setup governance remains owned by the `eleuthia` coordinator.

## Output Contract
- One bounded profile-specific setup rule set for the resolved `worker` profile
- The skill-owned profile-specific contract is defined by `./assets/eleuthia-net-worker.tpl.md`

If the resolved active profile is not `worker`, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/eleuthia-net-worker.tpl.md`
- Owned `*.checklist.md` assets: `Not applicable.`
- Additional governed inputs: `Not applicable.`

## When to Use
- `eleuthia` has already resolved the bounded run to the `worker` profile.
- `eleuthia` has already resolved the bounded run and loaded its shared governance inputs.
- The run needs only the `worker`-specific rules owned by `./assets/eleuthia-net-worker.tpl.md`.
- No other routed `eleuthia` profile skill may satisfy the same run.

## Procedure
1. Confirm the already-resolved active profile is `worker`.
2. Consume the shared `eleuthia` governance already resolved and loaded by the coordinator.
3. Load only the skill-owned profile template asset `./assets/eleuthia-net-worker.tpl.md` after the shared inputs.
4. Apply shared setup rules provided by the coordinator first and then apply the `worker`-specific rules from `./assets/eleuthia-net-worker.tpl.md`.
5. Keep shared setup rules and setup-owned QA attributable to the `eleuthia` coordinator's shared governance, and keep only `worker`-specific rules attributable to `./assets/eleuthia-net-worker.tpl.md`.
6. If the owned profile template asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
7. Validate the bounded result against the coordinator's shared checklist, this skill manifest, and the owned profile template asset before finalizing.

## Validation and Compliance Decision Rules
- Validate that this skill is used only for the resolved `worker` profile.
- Validate that shared `eleuthia` governance inputs remain attributable to the coordinator's shared governance and are not duplicated in this skill.
- Validate that only `./assets/eleuthia-net-worker.tpl.md` is loaded as the skill-owned asset after the shared inputs.
- Validate that `worker`-specific rules remain attributable to `./assets/eleuthia-net-worker.tpl.md`.
- If shared and profile-specific rules conflict, shared setup governance wins unless the user explicitly overrides it.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. The resolved profile and bounded-run context supplied by `eleuthia`
  2. Shared setup governance provided by the `eleuthia` coordinator
  3. Shared validation rules provided by the `eleuthia` coordinator
  4. `./assets/eleuthia-net-worker.tpl.md`
  5. Explicit repository evidence inside the bounded setup scope
- Use `Unknown`, `Not applicable.`, and `To be defined.` exactly when the available governed inputs require them.
- Do not infer shared setup rules from this skill when they are already owned by the `eleuthia` coordinator's shared governance.
- If required `worker`-specific detail is absent from the owned profile template asset, stop and request clarification instead of guessing.

## Determinism Rules
- Resolve this skill only when the active profile has already been determined as `worker`.
- Consume the shared `eleuthia` governance inputs before loading any skill-owned asset.
- Load exactly one skill-owned asset for this skill: `./assets/eleuthia-net-worker.tpl.md`.
- Do not load any other routed `eleuthia` profile skill or any undeclared companion asset.
- Given identical resolved inputs and repository state, the loaded asset set and `worker`-specific output of this skill MUST be functionally identical.

## Validation
- Structural checks:
  - The six required headings remain present and ordered exactly as required by `.github/skills/apollo-supervise-skill/SKILL.md`.
  - The declared owned template path is skill-relative and exists for the current run.
- Ownership checks:
  - Shared setup rules remain attributable to the `eleuthia` coordinator's shared governance.
  - Shared setup QA remains attributable to the `eleuthia` coordinator's shared validation rules.
  - Only the resolved `worker` rules remain attributable to `./assets/eleuthia-net-worker.tpl.md`.
- Scope checks:
  - This skill remains bound to the `worker` profile only.
  - This skill does not widen the run beyond the already-resolved `eleuthia` scope.

## Constraints
- Do not widen the run beyond the resolved `worker` profile.
- Do not load another `eleuthia` profile skill for the same run.
- Do not modify shared `eleuthia` governance during normal setup execution.
- Do not treat this skill as a standalone top-level agent.
