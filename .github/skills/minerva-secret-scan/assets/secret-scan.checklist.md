# Commit Secret Scan Checklist

## Pre-Output Validation

- [ ] Commit diff(s) were fully retrieved for the push event scope.
- [ ] All changed lines were scanned against known secret patterns.
- [ ] Each finding includes exact file path and line number.
- [ ] Each finding includes secret type classification.
- [ ] Each finding includes a confidence level (`Confirmed`, `High`, `Medium`, or `Low`).
- [ ] Secret values are partially masked in all output (first 4 and last 4 characters only).
- [ ] No full secret values appear in any output.
- [ ] Ambiguous findings are flagged with severity `Medium` and label `Potential secret — requires human verification`.
- [ ] False-positive patterns and `.gitignore` rules were cross-referenced.
- [ ] Alert uses `./assets/secret-alert.tpl.md` template.

## Scope Compliance

- [ ] Only commits within the current push event scope were scanned.
- [ ] No commits outside the push event scope were accessed.
- [ ] No secrets were revoked or rotated automatically.
- [ ] No commit history was modified.
- [ ] No source code files were created or modified.

## Output Compliance

- [ ] If secrets found: alert includes file:line references, secret type, and remediation steps.
- [ ] If no secrets found and invoked explicitly: confirmation comment emitted.
- [ ] If no secrets found and triggered automatically: silent pass (no output).
