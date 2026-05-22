# Security Review Agent Checklist

Quality and determinism checklist for `security-review` agent outputs.

---

## A. Output Integrity
- [ ] Output is `SECURITY_REVIEW.md` (report mode) or structured PR review comments (comment mode)
- [ ] In report mode, output is persisted as the report artifact and not left as a review-only or chat-only result
- [ ] Template structure copied verbatim from `security-review.tpl.md` (report mode)
- [ ] Template headings and section order preserved
- [ ] No section removed or reordered

---

## B. Scope Discipline
- [ ] Only files specified in the request scope were analyzed
- [ ] No code was modified
- [ ] No files outside the declared scope were read for finding evidence
- [ ] File list is explicitly documented in the Scope & Coverage section

---

## C. Evidence Discipline
- [ ] Every finding has explicit evidence
- [ ] Evidence includes exact file path + line anchor in `<path>:<line_start>-<line_end>` format
- [ ] Code snippets are verbatim from the analyzed file (not paraphrased or fabricated)
- [ ] No fabricated files, paths, or line numbers
- [ ] Missing-evidence fields use only canonical tokens: `TBD` / `Unknown`
- [ ] Custom placeholder variants such as `TBD (no explicit evidence found)` are not used

---

## D. Findings Quality
- [ ] Every finding includes a CWE category
- [ ] CWE identifiers are valid and correctly matched to the vulnerability type
- [ ] Severity is justified by static evidence using the deterministic calibration
- [ ] Every finding includes specific, actionable remediation guidance
- [ ] Finding IDs are sequential (`SR-001`, `SR-002`, …) in file order, then line order
- [ ] No CVE identifiers generated or suggested
- [ ] No runtime exploitability claims without static evidence
- [ ] Ambiguous findings use `Medium` severity with explicit caveat
- [ ] If no findings exist, exactly one `Info` row is present

---

## E. Security Pattern Coverage
For each analyzed file, verify scans covered applicable patterns:
- [ ] Input handling and validation
- [ ] Authentication and authorization checks
- [ ] Cryptographic usage
- [ ] SQL and query construction
- [ ] Output encoding
- [ ] File operations and path traversal
- [ ] Network calls and SSRF vectors
- [ ] Deserialization safety
- [ ] Secrets and hardcoded credentials

---

## F. Final Sanity Check
- [ ] No runtime assumptions
- [ ] No speculation beyond what code evidence supports
- [ ] Limitations clearly stated in metadata
- [ ] Output is reproducible from the same file set and repository state
- [ ] Output satisfies all criteria in this checklist
