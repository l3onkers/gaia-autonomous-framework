# Security Patch Proposal — <Vulnerability Reference>

## 1. Metadata
- Report artifact: `SECURITY_PATCH.md`
- Patch date: TBD
- Branch / ref: TBD
- Author: Security Patch Agent
- Vulnerability reference: TBD
- Source report: TBD

---

## 2. Vulnerability Summary

### Reference
TBD

### Description
TBD

### Severity
TBD

### Affected Code
- File: TBD
- Lines: TBD
- Evidence: TBD

---

## 3. Business Logic Context

### Code Path Analysis
TBD

### Behavior Preserved
TBD

---

## 4. Proposed Patch

### Unified Diff

```diff
TBD
```

### Explanation
TBD

---

## 5. Impact Analysis

### What Changes
TBD

### What Stays the Same
TBD

### New Dependencies
None.

### Risk Assessment
TBD

---

## 6. Approval

> **Action Required:** Review the proposed patch and select one option.

| Option | Action |
|--------|--------|
| **Apply** | Approve the patch — the agent will create a branch, commit, and PR via `apollo-git-workflow` |
| **Reject** | Reject the patch — no changes will be made |
| **Modify** | Request modifications — provide feedback for the agent to revise the patch |

**Decision:** TBD

---

## 7. Git Workflow Plan (Post-Approval)

- Branch: `fix/security-<short-description>`
- Commit: `fix(security): <subject>`
- PR target: TBD
- PR template: per `.github/skills/apollo-git-workflow/SKILL.md`
