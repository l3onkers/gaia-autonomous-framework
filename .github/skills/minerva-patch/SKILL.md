---
name: minerva-patch
description: 'Use when: a security workflow must propose minimal, evidence-justified code patches for known security vulnerabilities without altering business logic, always requiring human approval before application.'
---

# Security Patch

## Purpose
- This skill owns proposing minimal code patches for known security vulnerabilities, with mandatory human approval before application.
- This skill is used by the `minerva` coordinator agent or invoked directly for patch requests.
- This skill stays within the identified vulnerability scope — no refactoring, no unrelated changes, no automatic application.

## Output Contract
- Create or update exactly one report file: `SECURITY_PATCH.md` (repository root).
- Copy the structure verbatim from `./assets/minerva-patch.tpl.md`.

Downstream skill dependency (mandatory):
- `.github/skills/apollo-git-workflow/SKILL.md` — required for branch creation, commit message formatting, and PR creation when a patch is approved.

Generation constraints:
- `SECURITY_PATCH.md` headings, numbering, and section order MUST NOT change.
- Sections MUST NOT be removed.
- `TBD` placeholders may be replaced only with evidence-based content or `Unknown`.
- The approval section MUST always present explicit "Apply / Reject / Modify" options.
- Task completion requires persisting `SECURITY_PATCH.md` and presenting the approval prompt; applying the patch without approval is forbidden.

If the vulnerability cannot be verified from static evidence, stop and request clarification.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/minerva-patch.tpl.md`
- Owned `*.checklist.md` assets: `./assets/minerva-patch.checklist.md`
- Additional governed inputs: `.github/skills/apollo-git-workflow/SKILL.md` (downstream dependency for post-approval operations).

## When to Use
- The user or a coordinating agent provides a known security vulnerability reference and requests a fix proposal.
- A finding ID from a `SECURITY_AUDIT.md`, `SECURITY_TRIAGE.md`, or `SECURITY_REVIEW.md` report needs a fix.
- A GitHub security alert ID or Dependabot alert reference needs a patch.
- An explicit vulnerability description with enough detail to locate the affected code is provided.
- The `minerva` coordinator routes a patch generation request.

## Procedure
1. Receive vulnerability reference (finding ID, alert, or description) from the user or coordinating agent.
2. Locate the vulnerable code with line-level evidence using the evidence anchor format rules.
3. Analyze the code path to understand business logic context and confirm the vulnerability is reproducible from static evidence.
4. Design the smallest possible fix that resolves the vulnerability without altering business logic.
5. Generate the proposed patch as a unified diff.
6. Write impact analysis documenting what behavior is preserved and what changes.
7. Populate `SECURITY_PATCH.md` from `./assets/minerva-patch.tpl.md`, replacing only template placeholders with evidence-based content.
8. Present the patch for human approval — do not apply. The approval section MUST include explicit "Apply / Reject / Modify" options.
9. If approved: invoke `.github/skills/apollo-git-workflow/SKILL.md` for branch creation (`fix/security-<short-desc>`), commit message formatting (`fix(security): <subject>`), and PR creation with the patch diff.
10. Validate output against `./assets/minerva-patch.checklist.md` before finalizing.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Output file MUST be exactly `SECURITY_PATCH.md`, persisted as the report artifact.
- Template structure copied verbatim from `./assets/minerva-patch.tpl.md` with headings and section order preserved.
- Approval section MUST be present with explicit "Apply / Reject / Modify" options.
- Proposed diff MUST address only the identified vulnerability with the smallest possible change.
- No business logic altered beyond minimum required for the fix.
- Every vulnerability claim MUST have explicit evidence in approved anchor format.
- Missing-evidence fields use only `Unknown`.
- If the skill cannot satisfy its declared contract without guessing, stop and request clarification.

## Evidence Rules
- Every claim about the vulnerability and its resolution MUST be backed by explicit repository evidence.
- Evidence MUST include file path, line range or stable anchor, and a short description or exact snippet.
- If explicit evidence is unavailable for a required field, use `Unknown`.
- Fabricated evidence is strictly forbidden.

Evidence anchor format (mandatory, preferred in order 1 > 2 > 3):
1. Line anchor: `<path>:<line_start>-<line_end>` — use when files have stable line numbers.
2. Structural anchor: `<path>#<structural_path>` — use when structural paths are more stable than line numbers.
3. Content anchor: `<path>"<unique_snippet>"` — use only if neither line nor structural anchors are reliable. Snippet MUST be unique within the file and no longer than 120 characters.

Additional rules:
- Always prefer anchor format order `1 > 2 > 3`.
- MUST NOT mix anchor formats within a single evidence reference.
- If no reliable anchor can be produced, mark the affected evidence field `Unknown`.
- Inference is not allowed for vulnerability identification or patch correctness claims.
- Inference is allowed only for structural details: file paths, section fit, and template binding.

## Determinism Rules
- Given identical vulnerability description and repository state, the proposed patch MUST be functionally identical.
- Patch generation MUST follow a fixed phase sequence: locate, analyze, design, diff, explain, present.
- The proposed diff MUST be deterministic for the same vulnerability and code state.
- If multiple equally valid fixes exist, prefer the one with the smallest line-count change.
- If a deterministic choice cannot be made, present alternatives and request human selection.

## Constraints
- MUST NOT apply patches automatically (human-in-the-loop is mandatory).
- MUST NOT refactor code beyond the minimum needed to fix the vulnerability.
- MUST NOT introduce new dependencies without explicit justification.
- MUST NOT propose patches for vulnerabilities it cannot verify from static evidence.
- MUST NOT modify test files unless the test directly exercises the vulnerable path.
- MUST NOT perform dynamic analysis or runtime scanning.
- MUST NOT dismiss or close security alerts.
- Full repository security audits are out of scope (use the `minerva` agent).
- Code review or vulnerability discovery is out of scope (use the `minerva-review` skill).
- Security triage and prioritization is out of scope (use the `minerva-triage` skill).
