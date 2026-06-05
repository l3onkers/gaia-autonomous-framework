---
name: commit-secret-scan
description: 'Use when: commits are pushed and must be scanned for accidentally committed secrets, credentials, or sensitive tokens.'
---

# Commit Secret Scan

## Purpose
- This skill owns detection of committed secrets, API keys, tokens, and credentials in pushed commits.
- This skill is triggered by commit push events or invoked by the `minerva` coordinator agent.
- This skill stays within the commit's changed content â€” never scans the full repository history.

## Output Contract
- If secrets found: alert via PR comment or issue with exact file:line references, secret type classification, and remediation steps (revoke, rotate, remove from history).
- If no secrets found: silent pass (no output unless invoked explicitly, in which case: confirmation comment).

If the commit diff cannot be retrieved or is empty, stop and do not produce output.

If the skill cannot determine whether a string is a real secret or a placeholder, it MUST flag it with severity `Medium` and label `Potential secret â€” requires human verification`.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/secret-alert.tpl.md`
- Owned `*.checklist.md` assets: `./assets/secret-scan.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- Commits are pushed to any branch.
- A user explicitly requests secret scanning on specific commits.
- The `minerva` coordinator routes a secret scanning request.

## Procedure
1. Retrieve commit diff(s) for the push event.
2. Scan changed lines for patterns matching known secret formats:
   - API keys (AWS, GCP, Azure, GitHub, Stripe, etc.)
   - Database connection strings with credentials
   - Private keys (RSA, SSH, PGP)
   - OAuth tokens and refresh tokens
   - JWT secrets and signing keys
   - Generic high-entropy strings in sensitive contexts (env files, config files)
3. For each potential secret: classify type, assess confidence, extract exact location.
4. Cross-reference against `.gitignore` and known false-positive patterns.
5. For confirmed/high-confidence findings: generate alert using `./assets/secret-alert.tpl.md` with remediation steps.
6. Validate against `./assets/secret-scan.checklist.md` before output.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Every finding MUST reference the exact file path and line number from the commit diff.
- Secret content MUST be partially masked in all output (show first 4 and last 4 characters only).
- Ambiguous findings MUST be flagged with severity `Medium` and label `Potential secret â€” requires human verification`.
- Use `Unknown`, `Not applicable.`, and `To be defined.` exactly when the skill contract and available evidence require them.
- If the skill cannot satisfy its declared contract without guessing, stop and request clarification.

## Evidence Rules
- Every finding MUST include exact file path and line number in the commit diff.
- Secret content MUST be partially masked in output (show first 4 and last 4 characters only).
- Classification MUST specify the secret type (e.g., "AWS Access Key", "GitHub PAT", "RSA Private Key").
- When inference is used for secret classification, label it: `Inferred (pattern: <pattern-name>, confidence: Confirmed|High|Medium|Low)`.
- If asserting absence of secrets, require proof-of-absence (full diff scanned with zero pattern matches) or downgrade to `Unknown`.

## Determinism Rules
- Given identical commit content, the same findings MUST result.
- Confidence levels: `Confirmed`, `High`, `Medium`, `Low`.
- Pattern matching is deterministic: identical input lines produce identical classifications.
- If confidence cannot be assessed, default to `Medium` and flag for human verification.

## Constraints
- MUST NOT display full secret values in any output.
- MUST NOT revoke or rotate secrets automatically.
- MUST NOT modify commit history.
- MUST NOT scan commits outside the current push event scope.
- MUST NOT create or modify source code files.
- MUST NOT dismiss or downgrade findings without explicit evidence of a false positive.
