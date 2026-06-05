# Security Triage Agent Checklist

Quality and determinism checklist for `minerva-triage` agent outputs.

---

## A. Output Integrity
- [ ] Output file is exactly `SECURITY_TRIAGE.md`
- [ ] Output is persisted as the report artifact and not left as a review-only or chat-only result
- [ ] Template copied verbatim from `minerva-gaia.tpl.md`
- [ ] Template headings and section order preserved
- [ ] No section removed or reordered

---

## B. Evidence Discipline
- [ ] Every finding has explicit evidence
- [ ] Evidence includes file path + anchor (line / structural / content per agent rules)
- [ ] Findings table `Evidence` cells use a consistent approved anchor format
- [ ] No fabricated files, tools, or evidence anchors
- [ ] Missing-evidence fields use only canonical tokens: `TBD` / `Unknown`
- [ ] Custom placeholder variants such as `TBD (no explicit evidence found)` are not used

---

## C. Findings Quality
- [ ] Findings are configuration-based and posture-scored
- [ ] No CVE or exploit claims
- [ ] Severity justified by static evidence using deterministic severity calibration
- [ ] Every finding includes Exposure Context
- [ ] Every finding includes a clear Next Action
- [ ] Every finding includes Effort estimate
- [ ] Includes Info finding if no issues detected

---

## D. Grouping & De-Duplication
- [ ] Related findings are grouped (same pattern across multiple files)
- [ ] Findings sharing the same root cause are de-duplicated
- [ ] Finding IDs use category-appropriate prefixes (D-, C-, T-, I-, S-, G-)

---

## E. Priority Matrix
- [ ] Priority matrix is present and complete
- [ ] Counts match the actual number of findings per severity
- [ ] Finding IDs in the matrix match findings in the inventory
- [ ] Matrix is ordered: Critical â†’ High â†’ Medium â†’ Low â†’ Info

---

## F. Recommended Actions
- [ ] Immediate actions correspond to Critical and High findings
- [ ] Short-term actions correspond to Medium findings
- [ ] Long-term actions correspond to Low and Info findings
- [ ] Each action is specific and actionable

---

## G. Evidence Inventory
- [ ] All scanned file categories are listed
- [ ] Discovered files are enumerated per category
- [ ] Categories with no discovered files use `TBD` or `Unknown`

---

## H. Cross-Reference with Existing Audits
- [ ] If `SECURITY_AUDIT.md` exists, overlapping or divergent findings are noted
- [ ] If `SECURITY_AUDIT.md` does not exist, section states: `No existing SECURITY_AUDIT.md found.`

---

## I. Common Security Signals (Evidence-Based)
- [ ] Dependency manifests/lockfiles scanned or noted as Missing
- [ ] CI/CD pipeline permissions reviewed or noted as Unknown
- [ ] Third-party CI actions pinned status checked or noted as Unknown
- [ ] Security tooling configuration detected or noted as Missing
- [ ] Container/IaC security reviewed if applicable
- [ ] Existing audit reports cross-referenced if present

---

## J. Final Sanity Check
- [ ] No runtime assumptions
- [ ] No inferred infrastructure
- [ ] No speculation or invented severity
- [ ] Limitations clearly stated
- [ ] Output is reproducible from repository state alone
- [ ] Output satisfies all criteria in this checklist
