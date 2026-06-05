# minerva agent Checklist

Quality and determinism checklist for `minerva` agent outputs.

---

## A. Output Integrity
- [ ] Output file is exactly `SECURITY_AUDIT.md`
- [ ] Output is persisted as the report artifact and not left as a review-only or chat-only result
- [ ] Template copied verbatim from `minerva.tpl.md`
- [ ] Template headings and section order preserved
- [ ] No section removed or reordered

---

## B. Evidence Discipline
- [ ] Every finding has explicit evidence
- [ ] Evidence includes file path + anchor (line / structural / content per agent rules)
- [ ] Findings table `Evidence` cells use a consistent format: `<path>:<line_start>-<line_end> â€” <what this proves>` (or approved anchor format)
- [ ] No fabricated files or tools
- [ ] Missing-evidence fields use only canonical tokens: `TBD` / `Unknown`
- [ ] Custom placeholder variants such as `TBD (no explicit evidence found)` are not used

---

## C. Findings Quality
- [ ] Findings are configuration-based
- [ ] No CVE or exploit claims
- [ ] Severity justified by posture
- [ ] Includes Effort and Owner fields
- [ ] Includes Info finding if no issues detected

---

## D. Controls Review
For every control section:
- [ ] Status is one of: Found / Partial / Missing / Unknown / Not applicable
- [ ] Evidence is present or explicitly missing
- [ ] If Status is `Not applicable`, Evidence explicitly proves why the control cannot apply
- [ ] If Status is `Not applicable`, Next step is exactly `Not applicable.`
- [ ] Otherwise, Next step is actionable and stack-appropriate

---

## E. Common Security Signals (Evidence-Based)
- [ ] SECURITY.md present or Missing
- [ ] Dependency lockfiles present or Missing
- [ ] CI/CD permissions reviewed
- [ ] Third-party CI actions pinned or Unknown
- [ ] Secrets handling checked
- [ ] Container/IaC security reviewed if applicable
- [ ] Security tooling configuration detected or Missing

---

## F. Final Sanity Check
- [ ] No runtime assumptions
- [ ] No inferred infrastructure
- [ ] Limitations clearly stated
- [ ] Output is reproducible from repo state alone
- [ ] Output satisfies all criteria in this checklist