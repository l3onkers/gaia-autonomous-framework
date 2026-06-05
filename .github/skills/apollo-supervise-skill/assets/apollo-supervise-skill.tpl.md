# Supervise Skill Compliance Report

## Run Metadata

- Supervisor: apollo-supervise-skill
- Determinism Strategy: Strict
- Target Bundle: {{TARGET_BUNDLE_BASENAME}}
- Target Bundle Kind: skill
- Evaluated Artifact Set Reference: {{EVALUATED_ARTIFACT_SET_REFERENCE}}

---

## Bundle Resolution

- Primary Artifact: {{PRIMARY_ARTIFACT_PATH}}
- Template Resolution Method: {{TPL_RESOLUTION_METHOD}}
- Template Declared Companions: {{TPL_DECLARED_COMPANIONS}}
- Template Resolved Companions: {{TPL_RESOLVED_COMPANIONS}}
- Template Resolution Status: {{TPL_RESOLUTION_STATUS}}
- Checklist Resolution Method: {{CHECKLIST_RESOLUTION_METHOD}}
- Checklist Declared Companions: {{CHECKLIST_DECLARED_COMPANIONS}}
- Checklist Resolved Companions: {{CHECKLIST_RESOLVED_COMPANIONS}}
- Checklist Resolution Status: {{CHECKLIST_RESOLUTION_STATUS}}

---

## Governance Boundary

- Governed Artifacts: SKILL.md; *.tpl.md; *.checklist.md
- Out of Scope: *.agent.md and everything else are out of scope.

---

## Compliance Decision

- Decision: {{COMPLIANCE_DECISION}}
- Rationale: {{COMPLIANCE_RATIONALE}}

---

## Findings Summary

- Blocker: {{COUNT_BLOCKER}}
- High: {{COUNT_HIGH}}
- Medium: {{COUNT_MEDIUM}}
- Low: {{COUNT_LOW}}

---

## Findings (ordered by severity; include Severity, Bundle, Bundle Kind, Rule, Artifact, Summary, and Evidence for each entry)

{{FINDINGS_LIST}}

---

## Proof-of-Absence Log (include Scope, Method, Pattern, and Result for each entry; otherwise `Not applicable.`)

{{PROOF_OF_ABSENCE_LOG}}

---

## Notes

{{RUN_NOTES}}