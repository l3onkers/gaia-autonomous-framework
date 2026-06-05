---
name: pr-minerva-review
description: 'Use when: a pull request is created or updated and changed files must be reviewed for security vulnerabilities before merge.'
user-invocable: true
---

# PR Security Review

## Purpose
- This skill owns automated security review of changed files in a pull request.
- This skill is triggered by PR events or invoked by the `minerva` coordinator agent.
- This skill stays within the PR's changed file set â€” never reviews the entire repository.

## Output Contract
- PR review comments on specific lines with security findings.
- Summary comment on the PR with overall security assessment (always emitted; content varies by finding state).
- Findings follow the same severity/evidence format as the `minerva-review` skill.

If no changed files contain security-relevant code, produce a single summary comment: `No security-relevant changes detected in this PR.`

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/pr-review-comment.tpl.md`
- Owned `*.checklist.md` assets: `./assets/pr-review.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A PR is opened or updated with new commits.
- A user explicitly requests security review of a PR.
- The `minerva` coordinator routes a PR-scoped review request.

## Procedure
1. Retrieve the PR changed files list from the PR context provided by the triggering workflow or coordinator.
2. Filter to security-relevant files (source code, config, CI, dependency manifests â€” exclude docs, images, and other non-security-relevant content).
3. For each security-relevant file: analyze the changes (diff) for vulnerability patterns.
4. For each finding: create a PR review comment using `./assets/pr-review-comment.tpl.md` with line reference, severity, CWE category, and remediation suggestion.
5. If findings exist with severity â‰¥ High: add a summary comment recommending merge block.
6. If no findings: add a summary comment confirming no issues found.
7. Validate all comments against `./assets/pr-review.checklist.md` before posting.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Every finding MUST include: file path, line reference, severity, CWE category, code snippet, and remediation suggestion.
- Every finding MUST pass all items in `./assets/pr-review.checklist.md` before posting.
- If the skill cannot retrieve the PR changed files list, stop and request clarification.
- Use `Unknown` when severity cannot be determined from the code change context; do not guess.

## Evidence Rules
- Every finding MUST reference a specific line in the PR diff.
- Code snippets MUST be from the PR's changed content â€” never from unchanged or unrelated code.
- Severity MUST be justified by the code change context, not by general vulnerability databases alone.
- If asserting absence of a vulnerability class, require proof-of-absence from the diff or downgrade the claim to `Unknown`.
- Inference is allowed only for structural details (e.g., file type classification) and MUST be labeled: `Inferred (source: <path>:<symbol>, confidence: High|Medium|Low)`.

## Determinism Rules
- Given identical PR diff state, the same findings MUST result.
- Finding order: by severity (descending), then by file path (ascending), then by line number (ascending).
- File classification as security-relevant or not MUST be deterministic for identical file paths and extensions.
- If multiple CWE categories apply to a single finding, select the most specific category supported by the code context.

## Constraints
- MUST NOT review files outside the PR's changed file set.
- MUST NOT approve or merge the PR.
- MUST NOT modify the PR's code.
- MUST NOT create or close issues.
- MUST NOT post findings that fail the validation checklist.
- MUST NOT infer business intent or undocumented security requirements.
