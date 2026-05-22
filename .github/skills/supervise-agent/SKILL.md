---
name: supervise-agent
description: 'Use when: build or supervisor resolves a run to validate one governed `*.agent.md` bundle and emit a compliance report from the owned ./assets/supervise-agent.tpl.md template.'
user-invocable: false
---

# Supervise Agent Review Skill

## Purpose
- This skill owns one reusable governed agent-bundle review path for `build` and `supervisor`.
- This skill owns target bundle resolution, agent companion artifact binding, primary artifact validation, compliance decision rules, and report template binding for governed `*.agent.md` bundles.
- This skill validates governed `*.agent.md` bundles against the neutral base scaffold under `.github/governance/bundles/agent/AGENT.base.tpl.md` rather than owning that scaffold itself.

## Output Contract
- `supervise-agent.<reviewed_bundle>.report.md`

If the target designation does not resolve to exactly one governed agent bundle, stop and do not emit a report.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- `./assets/supervise-agent.tpl.md`
- `.github/governance/bundles/agent/AGENT.base.tpl.md`
- Governed bundle discovery scope:
  - `.github/agents/*.agent.md`
- Governed companion scope:
  - resolved `*.tpl.md` and `*.checklist.md` artifacts declared by the selected target agent bundle

## When to Use
- `build` must validate an assembled governed agent bundle before finalization.
- `supervisor` has resolved the run to a direct governed-agent review path.
- The target is exactly one governed `*.agent.md` bundle and the output must be exactly one agent compliance report.
- Direct neutral-governance review or other review resources are not sufficient to satisfy the run by themselves.
- If the requested designation is not unambiguously an agent bundle, use an exact readable `.github/agents/<name>.agent.md` path.

## Canonical Terminology
- Artifact state: committed snapshot of governed artifacts at evaluation time.
- Evidence: reproducible reference into artifact state.
- Unknown: insufficient evidence to decide within artifact state; MUST NOT be replaced by guessing.
- To be defined: intentional placeholder indicating the spec is expected to be completed later; MUST NOT be used to mask missing evidence.
- Not applicable: explicit inapplicability within scope; MUST be expressed as the exact literal `Not applicable.`.
- Not present: proven absence; proof-of-absence is required.
- Deterministic: repeatable output for the same artifact state and configuration.
- Bundle: the unit of evaluation consisting of one primary governed markdown artifact and its optional companion artifact sets resolved for the current run.
- Target bundle: the specific agent bundle explicitly selected for evaluation in the current run.
- Declared companion artifact: a `*.tpl.md` or `*.checklist.md` path explicitly declared by the target agent and resolvable to one concrete file for the current run.
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
- Review flow is Strict: resolve one target agent bundle, resolve its companion sets deterministically, validate it, and emit one report.
- Each governed `*.agent.md` MUST declare its determinism strategy in Section 4 as the first non-empty line under `## 4. Determinism Requirement` using exactly:
  - `Determinism Strategy: <Strict|Inference|Hybrid>`
- Missing agent determinism declaration => Medium by default.
- Missing agent determinism declaration escalates to High when the agent synthesizes outputs without clearly stating whether inference is allowed.
- Missing agent determinism declaration MUST NOT be classified as a Blocker unless some other independent Blocker condition also applies.

## Target Bundle Resolution
- The target MUST be identified by either:
  - an exact readable primary artifact path to `.github/agents/X.agent.md`, or
  - an agent bundle basename `X`
- Supported primary artifact is `.github/agents/X.agent.md`.
- If the caller provides an exact readable primary artifact path, it MUST resolve to one governed `*.agent.md`; any other exact path is out of scope and MUST be treated as a Blocker.
- If the caller provides only basename `X`, resolve `.github/agents/X.agent.md`.
- If basename `X` resolves to the supported primary artifact, use that candidate.
- If basename `X` resolves to no primary artifact candidate, emit a Blocker with proof-of-absence.
- Companion resolution MUST be deterministic and performed independently for each companion type (`tpl`, `checklist`) as an ordered distinct set.

Agent bundle companion resolution rules:
- The primary artifact is `X.agent.md`.
- Explicit declaration discovery scope is limited to bullet items in Section 2 or Section 3 whose sole content is a literal repository-relative path enclosed in backticks and ending in `.tpl.md` or `.checklist.md`.
- Resolution order for each companion type is:
  1. Ordered distinct explicitly declared companion artifacts in `X.agent.md`
  2. If none are declared for that type, exact same-basename companion artifact (`X.tpl.md` or `X.checklist.md`)
  3. Otherwise unresolved
- Multiple declared same-type companions are allowed; preserve first-appearance order and collapse duplicates after their first occurrence.
- Same-basename fallback candidate scope MUST be the full governed artifact set searched by exact basename match for that type and sorted by ascending repository-relative path before evaluation.
- If same-basename fallback yields exactly one candidate, resolve that candidate.
- If same-basename fallback yields more than one candidate, do not auto-bind any of them; treat that companion type as unresolved, record the sorted candidate list in report notes, and emit a Medium finding for ambiguous same-basename fallback.
- If an explicitly declared companion artifact does not exist, emit a Blocker with proof-of-absence for that path.
- Catalog roots, glob patterns, filename rules, placeholder paths, and directory-only references MUST NOT count as declared companion artifacts by themselves.

Shared bundle rules:
- Companion artifacts are evaluated in the context of the owning bundle; findings MUST reference the bundle name and kind.
- Missing companions are allowed and MUST be handled as `Unknown` unless proven `Not present` via proof-of-absence.
- The skill MUST evaluate only the target bundle selected for the current run.
- Unreferenced non-basename `*.tpl.md` or `*.checklist.md` files MUST NOT be auto-bound and MUST NOT trigger ambiguity by themselves.

## Primary Artifact Validation
Front matter rules:
- Each governed `*.agent.md` primary artifact MUST begin with YAML front matter delimited by `---` on its own line.
- Required keys:
  - `name`
  - `target`
  - `description`
- `name` MUST be unique across the evaluated artifact set, equal the `*.agent.md` basename, and use kebab-case.
- `target` MUST be non-empty.
- `description` MUST be non-empty.
- Malformed YAML or missing required keys => Blocker.

Required structure rules:
- Governed `*.agent.md` files MUST contain exactly these top-level headings, in order:
  1. `## 1. Objective`
  2. `## 2. Output Contract`
  3. `## 3. Evidence & Inference Usage Rules`
  4. `## 4. Determinism Requirement`
  5. `## 5. Applicability Rules`
  6. `## 6. Process Definition`
  7. `## 7. Validation Layer`
- These seven headings define the mandatory agent contract and MUST appear exactly once in that order.
- `.github/governance/bundles/agent/AGENT.base.tpl.md` is the neutral canonical default scaffold for new governed `*.agent.md` files when no stronger caller-provided or governed example is explicitly designated.
- If a required section is not applicable, it MUST contain exactly `Not applicable.`.
- If an agent core section is intentionally left as a placeholder, it MAY contain exactly `To be defined.`.

Companion artifact checks:
- If resolved companion `*.tpl.md` or `*.checklist.md` artifacts exist, validate them at least for:
  - valid UTF-8 text and readability
  - deterministic binding source and preserved order
  - no obvious self-contradiction with the owning bundle output contract
  - no normative governance override
- If deeper validation is not possible from explicit evidence, mark the result `Unknown` rather than inventing semantics.

Formatting rules:
- Agent bundle appendices are allowed only after section 7 and MUST begin with `Appendix: <title>`.
- Appendix content in agents MUST be non-normative except within quotes or examples.
- Governed primary artifacts MUST NOT embed or copy entire templates verbatim.
- Required headings MUST match exactly.
- Use canonical literals exactly: `Unknown`, `Not applicable.`, `Not present`, `To be defined.`.

## Procedure
1. Read the target designation from the run input.
2. Resolve the unique agent primary artifact using the target bundle resolution rules above.
3. Resolve companion artifact sets for the selected target agent bundle.
4. Form the target bundle from the primary artifact plus resolved optional companion sets.
5. Validate the primary artifact against the front matter, structure, determinism, companion, and formatting rules above.
6. If resolved companions exist, validate each resolved artifact.
7. Emit findings tagged with the bundle name and bundle kind `agent`.
8. Populate `supervise-agent.<reviewed_bundle>.report.md` exactly from the owned report template.

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
- non-canonical determinism strategy token in a governed `*.agent.md`
- appendices inserted before section 7 in a governed `*.agent.md`
- any declared companion artifact not found, with proof-of-absence
- target primary artifact not found, with proof-of-absence

Report field rules:
- The Target Bundle Kind line is fixed to `agent` by the owned template.
- The Governance Boundary section is fixed by the owned template and MUST mirror the governed artifact scope above.
- For each companion type, the report MUST state the resolution method, declared companions, resolved companions, and status.
- Resolution methods MUST use `declared-set`, `same-basename fallback`, or `unresolved`.
- Resolution statuses MUST use `Resolved`, `Unknown`, `Not present`, or `Blocked`.
- Companion lists MUST preserve resolution order; when no list applies, use `Unknown`, `Not present`, `Blocked`, or `Not applicable.` as supported by the evidence.
- `{{EVALUATED_ARTIFACT_SET_REFERENCE}}` MUST use a stable artifact-state reference when one is available; otherwise it MUST be exactly `Unknown (<reason>)`.
- `{{COMPLIANCE_RATIONALE}}` MUST be one concise sentence tied to the decision.
- `{{RUN_NOTES}}` MUST be exactly `Not applicable.` when no supplemental notes are needed; otherwise use a short flat bullet list.
- Each entry in `{{FINDINGS_LIST}}` MUST include `Severity`, `Bundle`, `Bundle Kind`, `Rule`, `Artifact`, `Summary`, and `Evidence`.
- `Bundle Kind` MUST be `agent` in every finding entry.
- If no findings exist, `{{FINDINGS_LIST}}` MUST be exactly `Not applicable.`.
- Each entry in `{{PROOF_OF_ABSENCE_LOG}}` MUST include `Scope`, `Method`, `Pattern`, and `Result`.
- If no proof-of-absence entries exist, `{{PROOF_OF_ABSENCE_LOG}}` MUST be exactly `Not applicable.`.