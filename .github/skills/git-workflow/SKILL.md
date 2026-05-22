---
name: git-workflow
description: 'Use when: agent or user must create a branch, commit, or pull request that complies with Company git standards.'
user-invocable: true
---

# Git Workflow

## Purpose
- This skill owns the branching, commit-message, and pull-request compliance workflow.
- This skill is used by any agent or user performing git operations in this repository.
- This skill stays within git metadata (branch names, commit messages, PR bodies); it does not own source-code changes.

## Output Contract
- Compliant branch name following `<prefix>/<short-description>` where prefix is one of `feat`, `fix`, `hotfix`, `docs`, `chore`.
- Compliant commit message following Company conventional-commit format.
- Compliant PR body containing: problem statement, behavior summary, test evidence, risk and rollback note, and reviewer checklist.
- For notebook-driven PRs, the PR body additionally contains: Notebook Path, Objective, Dataset/Input Source, Extracted Library Code, and Tests Covering Extraction.

If the caller's intent cannot be mapped to one of the allowed branch prefixes or commit types, stop and request clarification.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/pull-request.tpl.md`
- Owned `*.checklist.md` assets: `./assets/git-workflow.checklist.md`
- Reference files (progressive disclosure — read on demand):
  - `./references/gotchas.md` — common failure points and how to avoid them.
  - `./references/commit-examples.md` — good and bad commit messages with explanations.
  - `./references/branch-prefix-mapping.md` — change-type to branch-prefix mapping table.
- Example outputs:
  - `./examples/pr-body-standard.md` — filled PR template for a standard change.
  - `./examples/pr-body-notebook.md` — filled PR template for a notebook-driven change.
- Validation scripts:
  - `./scripts/validate-branch-name.sh <branch-name>` — deterministic regex check, exit 0 = valid.
  - `./scripts/validate-commit-message.sh <subject>` — deterministic regex check, exit 0 = valid.

## When to Use
- When creating a new topic branch.
- When composing a commit message for staged changes.
- When opening or updating a pull request.
- When validating that an existing branch name, commit, or PR conforms to standards.

## Procedure
1. Determine the operation type: **branch creation**, **commit**, or **pull request**.
2. Read `./references/gotchas.md` to prime awareness of common failure points.
3. **Branch creation:**
   1. Switch to the base branch and pull latest: `git switch <base> && git pull`.
   2. Derive the branch prefix from the change type using `./references/branch-prefix-mapping.md`. The mapping is **not 1:1** — see the reference for details.
   3. Create topic branch: `git switch -c <prefix>/<short-description>`.
   4. Allowed prefixes: `feat`, `fix`, `hotfix`, `docs`, `chore`.
   5. Use lowercase kebab-case for `<short-description>`.
   6. Run `./scripts/validate-branch-name.sh <branch-name>` to confirm compliance.
4. **Commit:**
   1. Format the subject line as `<type>(<scope>): <short explicit subject>` or `<type>: <short explicit subject>` when no scope applies.
   2. Allowed types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`.
   3. Suggested scopes: `data`, `features`, `validation`, `metrics`, `modeling`, `io`, `ci`, `security`.
   4. If the scope is not clearly evident from context, omit the parenthetical rather than guessing.
   5. If the change is breaking, include `BREAKING CHANGE:` in the commit body or footer.
   6. Run `./scripts/validate-commit-message.sh "<subject>"` to confirm compliance.
   7. Consult `./references/commit-examples.md` for calibration on good and bad messages.
5. **Pull request:**
   1. Fill `./assets/pull-request.tpl.md` with concrete content for every section.
   2. Mandatory sections: Problem Statement, Behavior Summary, Test Evidence, Risk and Rollback, Reviewer Checklist.
   3. For notebook-driven PRs, additionally fill: Notebook Path, Objective, Dataset/Input Source, Extracted Library Code, Tests Covering Extraction.
   4. Consult `./examples/pr-body-standard.md` or `./examples/pr-body-notebook.md` for a filled-in reference.
6. Push the branch: `git push -u origin <branch-name>`.
7. Open the PR: `gh pr create --base <target-branch> --title "<type>(<scope>): <subject>" --body-file <filled-template>` or pass the body inline.
8. Self-validate against `./assets/git-workflow.checklist.md`.

## Validation and Compliance Decision Rules
- Branch name must match pattern: `^(feat|fix|hotfix|docs|chore)/[a-z0-9][a-z0-9-]*$`. Use `./scripts/validate-branch-name.sh` for deterministic verification.
- Commit subject must match pattern: `^(feat|fix|docs|chore|refactor|test)(\([a-z0-9-]+\))?: .+$`. Use `./scripts/validate-commit-message.sh` for deterministic verification.
- PR body must contain all five mandatory sections: Problem Statement, Behavior Summary, Test Evidence, Risk and Rollback, Reviewer Checklist.
- Notebook-driven PRs must additionally contain all five notebook metadata fields.
- Use `Unknown` if the change type cannot be determined from context; do not guess.
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.

## Evidence Rules
- The caller must state, or the skill must infer from the staged diff or explicit instruction, the change type (`feat`, `fix`, `docs`, `chore`, `refactor`, `test`).
- If no scope is evident from context, omit the scope parenthetical rather than guessing.
- Branch prefix is derived from the change type using `./references/branch-prefix-mapping.md`. Key merges: `refactor` → `feat/`; `test` → `chore/`.
- If the caller explicitly names a prefix, use it as-is provided it is in the allowed set.
- When inference is used, label it: `Inferred (source: staged diff, confidence: High|Medium|Low)`.
- Review `./references/gotchas.md` for known failure patterns before finalizing any output.

## Validation
- Run `./scripts/validate-branch-name.sh` on the branch name before pushing.
- Run `./scripts/validate-commit-message.sh` on the commit subject before committing.
- Run `./assets/git-workflow.checklist.md` before finalizing any output.
- Every checklist item must pass; any failure blocks the output.

## Constraints
- Never commit directly to `main`.
- Never modify source files; this skill owns only git metadata (branch names, commit messages, PR bodies).
- Do not bypass git hooks (no `--no-verify`).
- Keep branch scope focused to one logical change.
- Do not invent branch prefixes or commit types outside the allowed sets.
