# Secret Detection Alert

## Summary

| Field                | Value                    |
|----------------------|--------------------------|
| **Scan scope**       | {{ commit_range }}       |
| **Findings count**   | {{ findings_count }}     |
| **Highest severity** | {{ highest_confidence }} |

---

## Findings

### Finding {{ finding_number }}

| Field            | Value                                      |
|------------------|--------------------------------------------|
| **File**         | `{{ file_path }}`                          |
| **Line**         | {{ line_number }}                          |
| **Secret type**  | {{ secret_type }}                          |
| **Confidence**   | {{ confidence_level }}                     |
| **Masked value** | `{{ first_4_chars }}...{{ last_4_chars }}` |

**Remediation steps:**

1. **Revoke** — Immediately revoke or invalidate the exposed credential.
2. **Rotate** — Generate a new credential and update all consumers.
3. **Remove from history** — Use `git filter-repo` or BFG Repo-Cleaner to purge the secret from git history.
4. **Audit** — Check access logs for any unauthorized usage during the exposure window.

<!-- Repeat the "### Finding" block for each detected secret. -->

---

## No Findings

<!-- Include this section only when invoked explicitly and no secrets are detected. -->

> ✅ No secrets detected in the scanned commits.
