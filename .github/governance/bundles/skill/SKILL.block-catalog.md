# Governed SKILL Optional Block Catalog

## Usage Rules
- Start from `./SKILL.base.tpl.md`.
- Keep the six mandatory headings exactly in this order before adding optional sections: `## Purpose`, `## Output Contract`, `## Governance Inputs`, `## When to Use`, `## Procedure`, `## Validation and Compliance Decision Rules`.
- Add optional sections only when they materially improve determinism, evidence handling, validation, or scope control.
- Append optional sections after the six mandatory headings.
- Prefer the canonical optional heading names listed below instead of inventing new top-level sections.

## Canonical Optional Heading Order
1. `## Asset Resolution`
2. `## Template Asset Resolution`
3. `## Canonical Terminology`
4. `## Evidence Rules`
5. `## Determinism Rules`
6. `## Target Bundle Resolution`
7. `## Primary Artifact Validation`
8. `## Validation`
9. `## Constraints`
10. `## Skill-Specific Constraints`
11. `## Compliance Decision and Report Binding`

## Archetype: Minimal Capability Skill
- Use only the six mandatory headings.
- Use when the skill owns one narrow capability, one fixed output, or one bounded transformation and does not resolve multiple candidate assets.
- Typical fit: small helper skills with a single owned output or a fixed governed action.

## Archetype: Selection or Routing Skill
- Recommended optional headings:
  - `## Asset Resolution`
  - `## Determinism Rules`
  - `## Constraints`
- Use when the skill must choose exactly one asset, template, profile, or family from a bounded set.
- Minimum expectations:
  - `## Asset Resolution` defines discovery scope, supported user designations, tie-break rules, and clarification behavior.
  - `## Determinism Rules` defines how ambiguity is handled and which defaults are allowed.
  - `## Constraints` defines what the skill must not do outside the resolved target.

## Archetype: Template Fill or Document Generation Skill
- Recommended optional headings:
  - `## Template Asset Resolution`
  - `## Evidence Rules`
  - `## Validation`
  - `## Skill-Specific Constraints`
- Use when the skill fills one owned document or artifact from a selected template and explicit repository evidence.
- Minimum expectations:
  - `## Template Asset Resolution` defines candidate discovery, explicit designation rules, fallback behavior, and ambiguity handling.
  - `## Evidence Rules` defines allowed evidence sources and missing-evidence literals.
  - `## Validation` defines the owned checklist or final quality gate.
  - `## Skill-Specific Constraints` locks down scope, output shape, and prohibited expansions.

## Archetype: Review or Compliance Skill
- Recommended optional headings:
  - `## Canonical Terminology`
  - `## Evidence Rules`
  - `## Determinism Rules`
  - `## Target Bundle Resolution`
  - `## Primary Artifact Validation`
  - `## Compliance Decision and Report Binding`
- Use when the skill reviews a governed artifact, resolves companions, emits findings, or binds a compliance report.
- Minimum expectations:
  - `## Canonical Terminology` defines review-state literals and evaluation vocabulary.
  - `## Evidence Rules` defines proof-of-absence and inference labeling.
  - `## Determinism Rules` defines the review mode and any ambiguity policy.
  - `## Target Bundle Resolution` defines the supported target designations and companion binding rules.
  - `## Primary Artifact Validation` defines structural, formatting, and contract checks.
  - `## Compliance Decision and Report Binding` defines severity, decision mapping, and report field rules.

## Archetype: Policy-Constrained Shared Skill
- Recommended optional headings:
  - `## Evidence Rules`
  - `## Validation`
  - `## Constraints`
- Use when the skill exposes a reusable shared capability but must operate within a strict policy boundary.
- Minimum expectations:
  - `## Evidence Rules` defines which inputs the skill may trust.
  - `## Validation` defines the final self-check or checklist gate.
  - `## Constraints` defines forbidden scope expansion, prohibited side effects, and ownership boundaries.

## Authoring Rule of Thumb
- Start with the smallest valid structure.
- Add optional blocks only when the skill would otherwise hide a routing rule, evidence rule, validation rule, or scope constraint inside a vague bullet.
- If a non-canonical top-level heading seems necessary, prefer tightening one of the canonical blocks first.