---
name: minerva-triage
description: 'Use when: a security workflow must analyze security-relevant repository evidence (dependency manifests, CI configurations, security tooling configs, existing audit reports) and produce prioritized, evidence-based triage reports from static analysis.'
---

# Security Triage

## Purpose
- This skill owns security evidence analysis and prioritized triage report generation from static repository evidence.
- This skill is used by the `minerva` coordinator agent or invoked directly for triage requests.
- This skill stays within static repository evidence — no runtime scanning, dynamic analysis, or cross-repository data.

## Output Contract
- Create or update exactly one report file: `SECURITY_TRIAGE.md` (repository root).
- Copy the structure verbatim from `./assets/minerva-gaia.tpl.md`.

Findings are categorized by:
- Dependency & Supply Chain (prefix: `D-`)
- CI/CD Configuration (prefix: `C-`)
- Security Tooling (prefix: `T-`)
- Container & IaC (prefix: `I-`)
- Secrets & Credentials (prefix: `S-`)
- General Security Posture (prefix: `G-`)

Generation constraints:
- `SECURITY_TRIAGE.md` headings, numbering, and section order MUST NOT change.
- Sections MUST NOT be removed.
- `TBD` placeholders may be replaced only with evidence-based content, `Unknown`, or `Not applicable` / `Not applicable.` where the template explicitly allows those values.
- Task completion requires persisting `SECURITY_TRIAGE.md`; a read-only assessment alone is insufficient.

If no security-relevant files exist in the repository, stop and request clarification.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/minerva-gaia.tpl.md`
- Owned `*.checklist.md` assets: `./assets/minerva-gaia.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- The user requests a security triage, security evidence scan, or prioritized security assessment.
- The `minerva` coordinator routes a triage or prioritization request.
- The repository contains at least one security-relevant file (dependency manifest, CI config, security tooling config, or existing audit report).
- Optional scope narrowing to specific categories (e.g., "triage dependencies only").

## Procedure
1. **Repository scanning:** scan for security-relevant files including dependency manifests/lockfiles, CI/CD pipeline configurations, security tooling configs (`dependabot.yml`, `codeql-config.yml`, `.snyk`, etc.), container/IaC files, and existing audit reports (`SECURITY_AUDIT.md`).
2. **Evidence extraction:** for each discovered evidence source, extract security-relevant signals using static analysis. Record file path, anchor, and signal description for every observation.
3. **Exposure assessment:** cross-reference extracted signals with repository configuration to assess actual exposure context (e.g., a misconfigured CI permission is higher severity if the workflow has write access).
4. **Grouping and de-duplication:** group related findings (e.g., same unpinned action pattern across multiple workflows, same outdated dependency across multiple manifests). De-duplicate findings that share the same root cause.
5. **Priority matrix construction:** assign severity to each finding group using the deterministic severity calibration rules. Produce priority matrix ordered: Critical → High → Medium → Low → Info.
6. **Report generation:** copy `./assets/minerva-gaia.tpl.md` verbatim, replace only template placeholders with evidence-based content or canonical missing-evidence tokens, and write `SECURITY_TRIAGE.md` while preserving headings and section order exactly.
7. **Validation:** validate the assembled report against `./assets/minerva-gaia.checklist.md` before finalizing. Any failed checklist item MUST be corrected before output. If validation cannot be completed, the skill MUST NOT produce final output.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Output file MUST be exactly `SECURITY_TRIAGE.md`, persisted as the report artifact.
- Template structure copied verbatim from `./assets/minerva-gaia.tpl.md` with headings and section order preserved.
- Every finding MUST have explicit evidence in approved anchor format.
- Related findings MUST be grouped and de-duplicated.
- Priority matrix MUST be ordered by severity descending with counts matching actual findings.
- Missing-evidence fields use only canonical tokens: `TBD` or `Unknown`.
- If the skill cannot satisfy its declared contract without guessing, stop and request clarification.

## Evidence Rules
- Every non-trivial statement MUST be backed by explicit repository evidence.
- Evidence MUST include file path, line range or stable anchor, and a short description or exact snippet.
- If explicit evidence is unavailable for a required field, preserve `TBD` or use `Unknown`.
- Fabricated evidence is strictly forbidden.

Evidence anchor format (mandatory, preferred in order 1 > 2 > 3):
1. Line anchor: `<path>:<line_start>-<line_end>` — use when files have stable line numbers.
2. Structural anchor: `<path>#<structural_path>` — use when structural paths are more stable than line numbers.
3. Content anchor: `<path>"<unique_snippet>"` — use only if neither line nor structural anchors are reliable. Snippet MUST be unique within the file and no longer than 120 characters.

Additional rules:
- Always prefer anchor format order `1 > 2 > 3`.
- MUST NOT mix anchor formats within a single evidence reference.
- If no reliable anchor can be produced, mark the affected evidence field or conclusion `Unknown`.
- Custom missing-evidence variants such as `TBD (no explicit evidence found)` are forbidden.
- Absence claims require explicit evidence and MUST NOT be inferred from intuition.

## Determinism Rules
- Given identical repository state and inputs, output MUST be functionally identical.
- Severity MUST be posture-based and evidence-backed.
- If severity cannot be justified by evidence, downgrade conservatively.

Allowed severities: `Critical`, `High`, `Medium`, `Low`, `Info`.

Deterministic severity calibration:
- `Critical`: evidence-backed control gap with immediate, broad exposure that directly threatens repository integrity or secret safety (e.g., committed secrets, publicly exposed credentials).
- `High`: clear, evidence-backed control gap that directly weakens build/release integrity or secret safety in-repo (e.g., overly broad CI permissions, unpinned third-party actions).
- `Medium`: partial controls or inconsistent enforcement with mitigating signals.
- `Low` or `Info`: hygiene improvements, optional hardening, or limited-impact best-practice alignment.

If no findings exist, include exactly one `Info` finding with:
`No explicit security issues found from static repository evidence`

## Constraints
- MUST NOT dismiss or auto-close issues.
- MUST NOT fabricate severity assessments not supported by static evidence.
- MUST NOT perform runtime verification or dynamic analysis.
- MUST NOT access data from repositories outside the current scope.
- MUST NOT invent CVEs or claim specific vulnerability IDs without static evidence.
- MUST NOT treat a chat-only review or summary as task completion when the report file can be written.
- Patching, fixing, or auto-closing of findings is out of scope (use the `minerva-patch` skill).
- Creating or updating `SECURITY_AUDIT.md` is out of scope (use the `minerva` agent).
