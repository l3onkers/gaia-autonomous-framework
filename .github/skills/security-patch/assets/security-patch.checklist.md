# Security Patch Agent Checklist

Quality and determinism checklist for `security-patch` agent outputs.

---

## A. Output Integrity
- [ ] Output file is exactly `SECURITY_PATCH.md`
- [ ] Output is persisted as the report artifact and not left as a review-only or chat-only result
- [ ] Template copied verbatim from `security-patch.tpl.md`
- [ ] Template headings and section order preserved
- [ ] No section removed or reordered
- [ ] Approval section present with "Apply / Reject / Modify" options

---

## B. Vulnerability Evidence
- [ ] Vulnerability reference is specific (finding ID, alert ID, or explicit description)
- [ ] Affected code located with line-level evidence
- [ ] Evidence includes file path + anchor (line / structural / content per agent rules)
- [ ] Evidence anchor format follows priority order: line > structural > content
- [ ] No fabricated evidence
- [ ] Missing-evidence fields use only `Unknown`

---

## C. Patch Quality
- [ ] Proposed diff is in unified format
- [ ] Diff addresses only the identified vulnerability
- [ ] Diff is the smallest change that resolves the vulnerability
- [ ] No business logic altered beyond minimum required for the fix
- [ ] No unrelated refactoring included
- [ ] No new dependencies introduced without explicit justification
- [ ] No test files modified unless directly exercising the vulnerable path
- [ ] Diff applies cleanly to current code state

---

## D. Impact Analysis
- [ ] "What Changes" section explicitly documents behavior changes
- [ ] "What Stays the Same" section explicitly confirms preserved behavior
- [ ] New dependencies listed or explicitly stated as "None"
- [ ] Risk assessment provided

---

## E. Human-in-the-Loop Gate
- [ ] Patch is NOT applied automatically
- [ ] Approval section presents explicit "Apply / Reject / Modify" options
- [ ] Decision field is present and awaiting human input
- [ ] Git workflow plan documented for post-approval execution

---

## F. Git Workflow Compliance (Post-Approval Only)
- [ ] Branch creation follows `git-workflow` skill rules
- [ ] Branch prefix is `fix/` for security patches
- [ ] Commit message follows `fix(security): <subject>` format
- [ ] PR body follows `git-workflow` PR template
- [ ] No direct commits to `main`

---

## G. Final Sanity Check
- [ ] No runtime assumptions
- [ ] No speculation about vulnerability impact beyond static evidence
- [ ] Explanation connects vulnerability to proposed fix with evidence
- [ ] Output is reproducible from repository state and vulnerability reference alone
- [ ] All criteria in this checklist satisfied
