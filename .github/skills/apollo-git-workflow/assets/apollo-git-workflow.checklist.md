# Git Workflow Checklist

## Branch
- [ ] Branch was created from the correct base branch (not committed directly to `main`).
- [ ] Branch name matches `^(feat|fix|hotfix|docs|chore)/[a-z0-9][a-z0-9-]*$`.
- [ ] Branch name validated with `./scripts/validate-branch-name.sh` (exit 0).
- [ ] Branch prefix matches the change-type mapping in `./references/branch-prefix-mapping.md` (e.g., `refactor` â†’ `feat/`, not `refactor/`).
- [ ] Branch scope is focused to one logical change.

## Commit
- [ ] Commit subject matches `^(feat|fix|docs|chore|refactor|test)(\([a-z0-9-]+\))?: .+$`.
- [ ] Commit subject validated with `./scripts/validate-commit-message.sh` (exit 0).
- [ ] Scope, if present, is one of: `data`, `features`, `validation`, `metrics`, `modeling`, `io`, `ci`, `minerva`.
- [ ] Scope is omitted (not guessed) when not clearly evident from context.
- [ ] Breaking changes include `BREAKING CHANGE:` in commit body or footer (subject-line `!` alone is insufficient).
- [ ] Commit type is from the allowed set â€” no `style`, `perf`, `hephaestus`, or `ci` types (see `./references/gotchas.md`).

## Pull Request
- [ ] PR body contains a **Problem Statement** section.
- [ ] PR body contains a **Behavior Summary** section.
- [ ] PR body contains a **Test Evidence** section.
- [ ] PR body contains a **Risk and Rollback** section.
- [ ] PR body contains a **Reviewer Checklist** with all five items.
- [ ] All HTML comment placeholders from the template have been replaced with real content.
- [ ] If notebook-driven, PR body contains: Notebook Path, Objective, Dataset/Input Source, Extracted Library Code, Tests Covering Extraction.

## General
- [ ] No `--no-verify` flag used on commit or push.
- [ ] No direct commits to `main`.
- [ ] `./references/gotchas.md` was reviewed before finalizing output.
