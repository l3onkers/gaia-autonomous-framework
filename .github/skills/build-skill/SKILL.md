---
name: build-skill
description: 'Use when: build resolves a run to author exactly one governed `.github/skills/<skill>/SKILL.md` bundle from explicit evidence, free-text requirements, and the neutral skill scaffold.'
user-invocable: false
---

# Build Skill Bundle Skill

## Purpose
- This skill owns one reusable authoring path for exactly one new governed skill bundle for `hephaestus`.
- This skill owns requirement extraction, conflict resolution, skill placement, scaffold selection, optional block selection, same-run owned asset creation, and the bounded `supervise-skill` validation gate for skill bundles.
- This skill stays within exactly one new bundle root under `.github/skills/` per run.

## Output Contract
- `.github/skills/<skill-name>/SKILL.md`
- Optional owned companions created only when explicitly required by the new skill contract:
  - `.github/skills/<skill-name>/assets/*.tpl.md`
  - `.github/skills/<skill-name>/assets/*.checklist.md`

If the request cannot resolve exactly one new skill bundle root and one skill name, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Neutral skill scaffold: `.github/governance/bundles/skill/SKILL.base.tpl.md`
- Neutral skill block catalog: `.github/governance/bundles/skill/SKILL.block-catalog.md`
- Skill review gate: `.github/skills/supervise-skill/SKILL.md`
- Caller-provided governed inputs for the current run:
  - `*.agent.md`
  - `SKILL.md`
  - `*.tpl.md`
  - `*.checklist.md`
- Free-text requirements, notes, and partial drafts.

## When to Use
- `hephaestus` has resolved the run to the new reusable routed specialty path, delegated shared behavior path, or a new shared skill.
- The run must emit exactly one governed skill bundle root.
- The result must be built from explicit evidence plus bounded structural inference and must pass `supervise-skill`.
- Direct neutral-governance updates or other build resources are not sufficient to satisfy the run by themselves.
- If the request is still compatible with a top-level callable agent bundle, `hephaestus` must clarify before invoking this skill.

## Procedure
1. Extract explicit constraints, required outputs, forbidden actions, source artifacts, and the candidate skill name from the current request and provided materials.
2. If no exact skill name can be resolved, or more than one plausible new skill bundle root remains, stop and request clarification.
3. Resolve conflicts using the evidence rules below and normalize unresolved items to `Unknown` or `To be defined.` when scaffold intent is explicit.
4. Plan bundle placement at `.github/skills/<skill-name>/SKILL.md` and create any explicitly required owned template or checklist assets in the same run under `assets/`.
5. Initialize the draft from `.github/governance/bundles/skill/SKILL.base.tpl.md` unless a stronger caller-provided or governed skill example is explicitly designated.
6. Write YAML front matter, the six mandatory sections, and only the smallest matching optional canonical block set needed from `.github/governance/bundles/skill/SKILL.block-catalog.md`.
7. Declare owned governance inputs using skill-local paths whenever the generated skill owns those assets, and avoid placeholder references to governed files that were not created in the same run.
8. Invoke `.github/skills/supervise-skill/SKILL.md` in-memory on the assembled bundle, apply at most two evidence-based fix passes, and stop rather than emitting a known non-compliant draft.
9. Emit exactly one new governed skill bundle root plus any required owned assets.

## Validation and Compliance Decision Rules
- The output MUST stay within exactly one new skill bundle root and its declared owned assets.
- The primary artifact MUST satisfy the neutral scaffold structure, block-catalog usage constraints, and the `supervise-skill` validation rules.
- Every declared owned template or checklist required by the generated skill MUST be created in the same run.
- If the bounded `supervise-skill` gate cannot restore compliance within two fix passes, stop and do not emit a known non-compliant bundle.
- If required evidence is missing, prefer `Unknown` or `To be defined.` over guessed content.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit constraints in caller-provided governed artifacts.
  2. Explicit constraints in caller-provided notes or partial drafts.
  3. Free-text requirements in the current request.
  4. Structural inference labeled in the required format.
- Inference is allowed only for structural details such as paths, section fit, optional block necessity, and owned asset necessity.
- If asserting absence, require proof-of-absence or downgrade the claim to `Unknown`.
- The skill MUST NOT infer business intent or undocumented requirements.

## Determinism Rules
- Default draft assembly is deterministic for identical inputs and repository state.
- The generated skill MUST start from the minimal six-section scaffold and add only the smallest canonical optional block set required by explicit evidence.
- Output paths, required headings, and declared owned asset sets MUST be functionally identical for identical inputs.
- If explicit evidence does not justify an optional top-level section, omit it rather than guessing.
- If required content is still under-specified after conflict resolution, use `Unknown` or `To be defined.` rather than inventing semantics.

## Validation
- Structural checks:
  - YAML front matter exists and `name` and `description` are non-empty and canonical.
  - The six mandatory headings exist in the required order.
  - Any optional headings come after the mandatory headings and use canonical names when a direct block-catalog fit exists.
- Scope checks:
  - The skill modifies only `.github/skills/<skill-name>/SKILL.md` and any explicitly required owned assets under `.github/skills/<skill-name>/assets/`.
  - No second bundle root is emitted.
- Review checks:
  - The final draft is attributable to this skill and passes or conservatively fails closed under the bounded `supervise-skill` gate.

## Constraints
- Do not implement runtime code or unrelated repository changes.
- Do not hard-code a new routed specialty into an existing coordinator when a new shared skill under `.github/skills/` is sufficient.
- Do not mix shared-skill authoring with unrelated top-level agent authoring in the same run.
- Do not emit placeholder references to governed assets that were not also created in the same run.