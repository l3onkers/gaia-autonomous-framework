---
name: apollo-supervise-skill
description: 'Use when: build or supervisor resolves a run to validate one governed `.github/skills/<skill>/SKILL.md` bundle and emit a compliance report from the owned ./assets/apollo-supervise-skill.tpl.md template.'
user-invocable: false
---

# Supervise Skill Review Skill

## Purpose
- This skill owns one reusable governed skill-bundle review path for `hephaestus` and `apollo`.
- This skill owns target skill-bundle resolution, skill companion artifact binding, primary artifact validation, compliance decision rules, and report template binding for governed `SKILL.md` bundles.
- This skill validates governed `SKILL.md` bundles against the neutral base scaffold and optional block catalog under `.github/governance/bundles/skill/` rather than owning those assets itself.

## Output Contract
- `apollo-supervise-skill.<reviewed_bundle>.report.md`

If the target designation does not resolve to exactly one governed skill bundle, stop and do not emit a report.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- `./assets/apollo-supervise-skill.tpl.md`
- `.github/governance/bundles/skill/SKILL.base.tpl.md`
- `.github/governance/bundles/skill/SKILL.block-catalog.md`
- Governed bundle discovery scope:
  - `.github/skills/*/SKILL.md`
- Governed companion scope:
  - resolved `*.tpl.md` and `*.checklist.md` artifacts declared by the selected target skill bundle

## When to Use
- `hephaestus` must validate an assembled governed skill bundle before finalization.
- `apollo` has resolved the run to a direct governed-skill review path.
- The target is exactly one governed `.github/skills/<skill>/SKILL.md` bundle and the output must be exactly one skill compliance report.
- Direct neutral-governance review or other review resources are not sufficient to satisfy the run by themselves.
- If the requested designation is not unambiguously a skill bundle, use an exact readable `.github/skills/<skill>/SKILL.md` path.

## Canonical Terminology
- Artifact state: committed snapshot of governed artifacts at evaluation time.
- Evidence: reproducible reference into artifact state.
- Unknown: insufficient evidence to decide within artifact state; MUST NOT be replaced by guessing.
- To be defined: intentional placeholder indicating the spec is expected to be completed later; MUST NOT be used to mask missing evidence.
- Not applicable: explicit inapplicability within scope; MUST be expressed as the exact literal `Not applicable.`.
- Not present: proven absence; proof-of-absence is required.
- Deterministic: repeatable output for the same artifact state and configuration.
- Bundle: the unit of evaluation consisting of one primary governed markdown artifact and its optional companion artifact sets resolved for the current run.
- Target bundle: the specific skill bundle explicitly selected for evaluation in the current run.
- Declared companion artifact: a `*.tpl.md` or `*.checklist.md` path explicitly declared by the target skill and resolvable to one concrete file for the current run.
- Declared companion artifact pattern: a skill-relative or repository-relative governed glob declared by the target skill that expands deterministically to zero or more `*.tpl.md` or `*.checklist.md` files.
- Declared companion artifact set: the ordered distinct list of declared companion artifacts of one type (`tpl` or `checklist`) resolved for the current run.

## Evidence Rules
- All claims MUST be grounded in governed artifacts. No external data.
- If asserting something is absent, record proof-of-absence with:
  - Scope
  - Method
  - Pattern
  - Result
- If proof-of-absence is missing, absence claims MUST be downgraded to `Unknown`.
- Inference is allowed ONLY when explicitly labeled and limited to structural inferences from explicit declarations.
- Inferred content MUST be labeled exactly as:
  - `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`
- The skill MUST NOT infer business intent or undocumented requirements.

## Determinism Rules
- Review flow is Strict: resolve one target skill bundle, resolve its companion sets deterministically, validate it, and emit one report.
- Each governed `SKILL.md` MUST make deterministic ownership and routing possible from explicit text in the skill itself.
- At minimum, a governed skill MUST:
  - declare its output scope explicitly
  - declare its governance inputs explicitly
  - describe a deterministic resolution rule, explicit clarification step, or both when it resolves multiple candidate assets
  - keep owned assets attributable to the skill rather than relying on unstated external defaults
- If a skill can resolve multiple candidate assets but provides no deterministic selection or clarification rule, emit at least a Medium finding.

## Target Bundle Resolution
- The target MUST be identified by either:
  - an exact readable primary artifact path to `.github/skills/X/SKILL.md`, or
  - a skill bundle basename `X`
- Supported primary artifact is `.github/skills/X/SKILL.md`.
- If the caller provides an exact readable primary artifact path, it MUST resolve to one governed `SKILL.md`; any other exact path is out of scope and MUST be treated as a Blocker.
- If the caller provides only basename `X`, resolve `.github/skills/X/SKILL.md`.
- If basename `X` resolves to the supported primary artifact, use that candidate.
- If basename `X` resolves to no primary artifact candidate, emit a Blocker with proof-of-absence.
- Companion resolution MUST be deterministic and performed independently for each companion type (`tpl`, `checklist`) as an ordered distinct set.

Skill bundle companion resolution rules:
- The primary artifact is `.github/skills/X/SKILL.md`.
- Explicit declaration discovery scope is limited to bullet items inside `## Governance Inputs`.
- Allowed declaration forms inside that scope are:
  - a backticked exact path ending in `.tpl.md` or `.checklist.md` that is either skill-relative or repository-relative
  - a markdown-link target that is either skill-relative or repository-relative and ends in `.tpl.md` or `.checklist.md`
  - a backticked glob ending in `*.tpl.md` or `*.checklist.md` that is either skill-relative or repository-relative
- Exact skill-relative declarations MUST be resolved relative to the owning skill root and preserved in first-appearance order.
- Exact repository-relative declarations MUST be resolved relative to the repository root and preserved in first-appearance order.
- Declared companion artifact patterns MUST be expanded relative to the owning skill root or repository root according to the declaration form, sorted by ascending repository-relative path, inserted at the declaration point, and deduplicated after first occurrence.
- Same-basename fallback MUST NOT be used for skill bundles.
- If a declared exact companion artifact does not exist, emit a Blocker with proof-of-absence for that path.
- If a declared companion artifact pattern matches zero files, emit a Blocker with proof-of-absence for that pattern.
- Directory-only references, placeholder paths, repository-external paths, and non-relative external globs MUST NOT count as declared companion artifacts or patterns by themselves.

Shared bundle rules:
- Companion artifacts are evaluated in the context of the owning bundle; findings MUST reference the bundle name and kind.
- Missing companions are allowed and MUST be handled as `Unknown` unless proven `Not present` via proof-of-absence.
- The skill MUST evaluate only the target bundle selected for the current run.
- Unreferenced `*.tpl.md` or `*.checklist.md` files outside explicit declarations MUST NOT be auto-bound.

## Primary Artifact Validation
Front matter rules:
- Each governed `SKILL.md` primary artifact MUST begin with YAML front matter delimited by `---` on its own line.
- Required keys:
  - `name`
  - `description`
- `name` MUST be unique across the evaluated artifact set, equal the owning skill directory basename, and use kebab-case.
- `description` MUST be non-empty.
- `user-invocable`, if present, MUST be boolean.
- Malformed YAML or missing required keys => Blocker.

Required structure rules:
- Governed `SKILL.md` files MUST contain these required top-level headings, in order:
  1. `## Purpose`
  2. `## Output Contract`
  3. `## Governance Inputs`
  4. `## When to Use`
  5. `## Procedure`
  6. `## Validation and Compliance Decision Rules`
- These six headings define the mandatory skill contract and MUST appear exactly once in that order.
- `.github/governance/bundles/skill/SKILL.base.tpl.md` is the neutral canonical default scaffold for new governed `SKILL.md` files when no stronger caller-provided or governed example is explicitly designated.
- `.github/governance/bundles/skill/SKILL.block-catalog.md` is the advisory neutral canonical optional block catalogue for governed `SKILL.md` files when additional structure is required.
- Additional top-level `##` headings are allowed only when they do not appear before the required headings and do not reorder the required headings.
- When additional top-level headings are needed in a governed `SKILL.md`, they SHOULD use one of these canonical names when applicable:
  - `## Asset Resolution`
  - `## Template Asset Resolution`
  - `## Canonical Terminology`
  - `## Evidence Rules`
  - `## Determinism Rules`
  - `## Target Bundle Resolution`
  - `## Primary Artifact Validation`
  - `## Validation`
  - `## Constraints`
  - `## Skill-Specific Constraints`
  - `## Compliance Decision and Report Binding`
- If a governed skill introduces a non-canonical additional top-level heading without explicit repository precedent or a clear scope-specific need, emit a Low finding rather than treating it as a structural blocker.
- If a required section is not applicable, it MUST contain exactly `Not applicable.`.

Companion artifact checks:
- If resolved companion `*.tpl.md` or `*.checklist.md` artifacts exist, validate them at least for:
  - valid UTF-8 text and readability
  - deterministic binding source and preserved order
  - no obvious self-contradiction with the owning bundle output contract
  - no normative governance override
  - resolved skill-owned companions SHOULD remain within the owning skill root unless explicit governed evidence says they are shared externally; neutral governance assets under `.github/governance/` are valid shared governed inputs when explicitly declared
- If deeper validation is not possible from explicit evidence, mark the result `Unknown` rather than inventing semantics.

Formatting rules:
- Governed primary artifacts MUST NOT embed or copy entire templates verbatim.
- Required headings MUST match exactly.
- Use canonical literals exactly: `Unknown`, `Not applicable.`, `Not present`, `To be defined.`.

## Procedure
1. Read the target designation from the run input.
2. Resolve the unique skill primary artifact using the target bundle resolution rules above.
3. Resolve companion artifact sets for the selected target skill bundle.
4. Form the target bundle from the primary artifact plus resolved optional companion sets.
5. Validate the primary artifact against the front matter, structure, determinism, companion, and formatting rules above.
6. If resolved companions exist, validate each resolved artifact.
7. Emit findings tagged with the bundle name and bundle kind `skill`.
8. Populate `apollo-supervise-skill.<reviewed_bundle>.report.md` exactly from the owned report template.

## Compliance Decision and Report Binding
Severity levels:
- Blocker
- High
- Medium
- Low

Compliance decision:
- Any Blocker => Non-compliant
- Otherwise, if any High => Non-compliant
- Otherwise => Compliant
- If evaluation cannot be completed due to missing artifact state, output `Unknown` decision with explanation.

Common Blockers (non-exhaustive):
- missing YAML front matter or required keys in the primary artifact
- missing required headings in the primary artifact
- wrong ordering of required headings in the primary artifact
- any declared companion artifact not found, with proof-of-absence
- any declared skill companion artifact pattern that matches zero files, with proof-of-absence
- target primary artifact not found, with proof-of-absence

Report field rules:
- The Target Bundle Kind line is fixed to `skill` by the owned template.
- The Governance Boundary section is fixed by the owned template and MUST mirror the governed artifact scope above.
- For each companion type, the report MUST state the resolution method, declared companions, resolved companions, and status.
- Resolution methods MUST use `declared-set` or `unresolved`.
- Resolution statuses MUST use `Resolved`, `Unknown`, `Not present`, or `Blocked`.
- Companion lists MUST preserve resolution order; when no list applies, use `Unknown`, `Not present`, `Blocked`, or `Not applicable.` as supported by the evidence.
- `{{EVALUATED_ARTIFACT_SET_REFERENCE}}` MUST use a stable artifact-state reference when one is available; otherwise it MUST be exactly `Unknown (<reason>)`.
- `{{COMPLIANCE_RATIONALE}}` MUST be one concise sentence tied to the decision.
- `{{RUN_NOTES}}` MUST be exactly `Not applicable.` when no supplemental notes are needed; otherwise use a short flat bullet list.
- Each entry in `{{FINDINGS_LIST}}` MUST include `Severity`, `Bundle`, `Bundle Kind`, `Rule`, `Artifact`, `Summary`, and `Evidence`.
- `Bundle Kind` MUST be `skill` in every finding entry.
- If no findings exist, `{{FINDINGS_LIST}}` MUST be exactly `Not applicable.`.
- Each entry in `{{PROOF_OF_ABSENCE_LOG}}` MUST include `Scope`, `Method`, `Pattern`, and `Result`.
- If no proof-of-absence entries exist, `{{PROOF_OF_ABSENCE_LOG}}` MUST be exactly `Not applicable.`.