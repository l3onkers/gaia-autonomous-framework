---
name: hephaestus-build-agent
description: 'Use when: build resolves a run to author exactly one governed `.github/agents/<bundle>.agent.md` bundle from explicit evidence, free-text requirements, and the neutral agent scaffold.'
user-invocable: false
---

# hephaestus agent Bundle Skill

## Purpose
- This skill owns one reusable authoring path for exactly one new governed agent bundle for `hephaestus`.
- This skill owns requirement extraction, conflict resolution, bundle placement, draft assembly, same-run owned companion creation, and the bounded `apollo-supervise-agent` validation gate for agent bundles.
- This skill stays within exactly one new bundle root under `.github/agents/` per run.

## Output Contract
- `.github/agents/<bundle-name>.agent.md`
- Optional owned companions created only when explicitly required by the new agent contract:
  - `.github/agents/<bundle-name>/<bundle-name>.tpl.md`
  - `.github/agents/<bundle-name>/<bundle-name>.checklist.md`
  - or one explicit family-owned companion path inherited from governed evidence

If the request cannot resolve exactly one new agent bundle root and one bundle name, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Neutral agent scaffold: `.github/governance/bundles/agent/AGENT.base.tpl.md`
- Agent review gate: `.github/skills/apollo-supervise-agent/SKILL.md`
- Caller-provided governed inputs for the current run:
  - `*.agent.md`
  - `SKILL.md`
  - `*.tpl.md`
  - `*.checklist.md`
- Free-text requirements, notes, and partial drafts.

## When to Use
- `hephaestus` has resolved the run to the new callable top-level bundle path or a new `*.agent.md` entrypoint.
- The run must emit exactly one governed agent bundle root.
- The result must be built from explicit evidence plus bounded structural inference and must pass `apollo-supervise-agent`.
- Direct neutral-governance updates or other build resources are not sufficient to satisfy the run by themselves.
- If the request is still compatible with a skill bundle, `hephaestus` must clarify before invoking this skill.

## Procedure
1. Extract explicit constraints, required outputs, forbidden actions, source artifacts, and the candidate bundle name from the current request and provided materials.
2. If no exact bundle name can be resolved, or more than one plausible new agent bundle root remains, stop and request clarification.
3. Resolve conflicts using the evidence rules below and normalize unresolved items to `Unknown` or `To be defined.` when scaffold intent is explicit.
4. Plan bundle placement at `.github/agents/<bundle-name>.agent.md` and create any explicitly required owned companion files in the same run.
5. Initialize the draft from `.github/governance/bundles/agent/AGENT.base.tpl.md` unless a stronger caller-provided or governed agent example is explicitly designated.
6. Write YAML front matter, the seven mandatory sections, the determinism declaration, and any required owned companion references using canonical literals exactly.
7. Reuse explicit governed wording when it reduces drift, but do not paste whole templates or unrelated material.
8. Invoke `.github/skills/apollo-supervise-agent/SKILL.md` in-memory on the assembled bundle, apply at most two evidence-based fix passes, and stop rather than emitting a known non-compliant draft.
9. Emit exactly one new governed agent bundle root plus any required owned companions.

## Validation and Compliance Decision Rules
- The output MUST stay within exactly one new agent bundle root and its declared owned companions.
- The primary artifact MUST satisfy the neutral scaffold structure and the `apollo-supervise-agent` validation rules.
- Every declared bundle-local governed companion required by the generated agent MUST be created in the same run.
- If the bounded `apollo-supervise-agent` gate cannot restore compliance within two fix passes, stop and do not emit a known non-compliant bundle.
- If required evidence is missing, prefer `Unknown` or `To be defined.` over guessed content.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit constraints in caller-provided governed artifacts.
  2. Explicit constraints in caller-provided notes or partial drafts.
  3. Free-text requirements in the current request.
  4. Structural inference labeled in the required format.
- Inference is allowed only for structural details such as paths, shapes, section fit, and owned companion necessity.
- If asserting absence, require proof-of-absence or downgrade the claim to `Unknown`.
- The skill MUST NOT infer business intent or undocumented requirements.

## Determinism Rules
- Default draft assembly is deterministic for identical inputs and repository state.
- If the user does not specify a determinism strategy for the generated agent, use `Hybrid`.
- The first non-empty line under `## 4. Determinism Requirement` in the generated agent MUST be exactly `Determinism Strategy: <Strict|Inference|Hybrid>`.
- If the user requires `Strict` but available evidence cannot support a concrete value, keep `Strict` and use `Unknown` instead of inferring.
- Owned companion creation, output paths, and section ordering MUST be functionally identical for identical inputs.

## Validation
- Structural checks:
  - YAML front matter exists and `name`, `target`, and `description` are non-empty and canonical.
  - Exactly seven core sections exist in the neutral scaffold order.
  - Any appendix appears only after section 7 and remains non-normative.
- Scope checks:
  - The skill modifies only `.github/agents/<bundle-name>.agent.md` and any explicitly required owned companions.
  - No second bundle root is emitted.
- Review checks:
  - The final draft is attributable to this skill and passes or conservatively fails closed under the bounded `apollo-supervise-agent` gate.

## Constraints
- Do not implement runtime code or unrelated repository changes.
- Do not modify coordinators when a single new agent bundle satisfies the request.
- Do not mix agent authoring with unrelated shared-skill authoring in the same run.
- Do not emit placeholder references to bundle-local governed artifacts that were not also created in the same run.