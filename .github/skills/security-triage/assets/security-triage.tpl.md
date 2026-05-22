# Security Triage Report — <Repository / Branch>

## 1. Metadata
- Report artifact: `SECURITY_TRIAGE.md`
- Triage date: TBD
- Branch / ref: TBD
- Analyst: Security Triage Agent
- Analysis mode: Static repository analysis (read-only evidence collection)
- Limitations: No runtime scanning, no CVE enumeration, no exploit validation, no dynamic analysis

---

## 2. Executive Summary

### Posture Summary
TBD

### Top Risks (Evidence-Based)
1. TBD
2. TBD
3. TBD

### Fast Wins (≤ 1 day)
- TBD

---

## 3. Findings Inventory

Use allowed severities only: `Critical`, `High`, `Medium`, `Low`, `Info`.
If no findings exist, keep exactly one `Info` row with finding text: `No explicit security issues found from static repository evidence`.
Use canonical missing-evidence tokens only: `TBD` or `Unknown`. Do not invent custom variants.

### 3.1 Dependency & Supply Chain

| ID | Severity | Finding | Evidence | Exposure Context | Next Action | Effort |
|---:|:--------:|---------|----------|------------------|-------------|:------:|
| D-001 | TBD | TBD | TBD | TBD | TBD | TBD |

### 3.2 CI/CD Configuration

| ID | Severity | Finding | Evidence | Exposure Context | Next Action | Effort |
|---:|:--------:|---------|----------|------------------|-------------|:------:|
| C-001 | TBD | TBD | TBD | TBD | TBD | TBD |

### 3.3 Security Tooling

| ID | Severity | Finding | Evidence | Exposure Context | Next Action | Effort |
|---:|:--------:|---------|----------|------------------|-------------|:------:|
| T-001 | TBD | TBD | TBD | TBD | TBD | TBD |

### 3.4 Container & IaC

| ID | Severity | Finding | Evidence | Exposure Context | Next Action | Effort |
|---:|:--------:|---------|----------|------------------|-------------|:------:|
| I-001 | TBD | TBD | TBD | TBD | TBD | TBD |

### 3.5 Secrets & Credentials

| ID | Severity | Finding | Evidence | Exposure Context | Next Action | Effort |
|---:|:--------:|---------|----------|------------------|-------------|:------:|
| S-001 | TBD | TBD | TBD | TBD | TBD | TBD |

### 3.6 General Security Posture

| ID | Severity | Finding | Evidence | Exposure Context | Next Action | Effort |
|---:|:--------:|---------|----------|------------------|-------------|:------:|
| G-001 | TBD | TBD | TBD | TBD | TBD | TBD |

---

## 4. Priority Matrix

| Priority | Count | Finding IDs |
|:--------:|:-----:|-------------|
| Critical | TBD | TBD |
| High | TBD | TBD |
| Medium | TBD | TBD |
| Low | TBD | TBD |
| Info | TBD | TBD |

---

## 5. Recommended Actions

### Immediate (Critical / High)
- TBD

### Short-Term (Medium)
- TBD

### Long-Term (Low / Info)
- TBD

---

## 6. Evidence Inventory

Use canonical missing-evidence tokens only: `TBD` or `Unknown`.

### Dependency Manifests & Lockfiles
- TBD

### CI/CD Pipelines
- TBD

### Security Tooling Configuration
- TBD

### Container / IaC Files
- TBD

### Existing Audit Reports
- TBD

---

## 7. Cross-Reference with Existing Audits

If `SECURITY_AUDIT.md` is present, note overlapping or divergent findings here.

| Triage Finding | Audit Finding | Status | Notes |
|----------------|---------------|--------|-------|
| TBD | TBD | TBD | TBD |

If no existing audit report is present, state: `No existing SECURITY_AUDIT.md found.`

---

## 8. Limitations & Assumptions
- Analysis is based exclusively on static repository evidence at the time of triage.
- No runtime scanning, dynamic analysis, or network probing was performed.
- No CVE enumeration or exploit validation was performed.
- Severity assessments are posture-based and evidence-backed; they do not represent exploitability ratings.
- Findings outside the scanned file types may exist but are not covered by this triage.
