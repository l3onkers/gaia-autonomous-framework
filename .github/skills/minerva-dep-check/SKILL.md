---
name: minerva-dep-check
description: 'Use when: dependency manifest files are changed and must be checked for known vulnerable dependencies before merge.'
---

# Dependency Security Check

## Purpose
- This skill owns security review of dependency changes in pull requests.
- This skill is triggered when dependency manifest files are modified or invoked by the `minerva` coordinator agent.
- This skill stays within the dependency manifest changes — never audits the full dependency tree unless a manifest changed.

## Output Contract
- PR comment listing newly added or upgraded dependencies with known vulnerabilities.
- For each vulnerable dependency: evidence from manifest (file:line), the concern (outdated major version, known-vulnerable package, unpinned version), severity, and remediation recommendation.
- If no vulnerable dependencies found: summary comment confirming clean dependency changes.

If the PR diff contains no changes to dependency manifest files, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/dependency-report.tpl.md`
- Owned `*.checklist.md` assets: `./assets/dependency-check.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A PR modifies dependency manifest or lockfile content.
- A user explicitly requests dependency security review.
- The `minerva` coordinator routes a dependency check request.

## Procedure
1. Identify changed dependency manifests in the PR diff (e.g., `package.json`, `requirements.txt`, `Gemfile`, `pom.xml`, `*.csproj`, `go.mod`, and similar).
2. Extract newly added or version-changed dependencies.
3. Analyze dependency versions against known vulnerability patterns (outdated major versions, dependencies with known security history, unpinned versions).
4. For each finding: document the specific manifest entry, the concern, and the recommended action.
5. Compile findings with evidence references and severity.
6. Generate PR comment from `./assets/dependency-report.tpl.md`.
7. Validate against `./assets/dependency-check.checklist.md` before output.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Use `Unknown`, `Not applicable.`, and `To be defined.` exactly when the skill contract and available evidence require them.
- If the skill cannot satisfy its declared contract without guessing, stop and request clarification.

## Evidence Rules
- Every finding MUST reference the specific manifest file and line where the dependency is declared.
- Findings MUST be based on static evidence (version patterns, known-vulnerable dependency names, unpinned ranges).
- Version ranges MUST be exact (not approximate).
- If asserting absence of vulnerability, require proof-of-absence or downgrade to `Unknown`.
- When inference is used, label it clearly.

## Determinism Rules
- Given identical manifest diff and repository state, the same findings MUST result.
- Output ordering, severity, and evidence references MUST be functionally identical for identical inputs.

## Constraints
- MUST NOT modify dependency manifests.
- MUST NOT auto-upgrade dependencies.
- MUST NOT analyze unchanged dependencies.
- MUST NOT create issues or close alerts.
