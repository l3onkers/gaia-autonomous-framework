# Gotchas — Git Workflow

Common failure points when using this skill. Read this before creating branches, commits, or PRs.

---

## Branch Naming

### Wrong prefix for refactors
`refactor` is a **commit type**, not a branch prefix. Refactoring changes use the `feat/` branch prefix.

**Wrong:** `refactor/extract-helper-class`
**Right:** `feat/extract-helper-class`

### Mapping table is not 1:1
Branch prefixes and commit types are **not** the same set. The mapping has deliberate merges:
- `feat` and `refactor` → `feat/`
- `fix` → `fix/`
- `docs` → `docs/`
- `chore` and `test` → `chore/`

Always check `references/branch-prefix-mapping.md` when uncertain.

### Uppercase or underscores in branch names
Branch names must be **lowercase kebab-case** after the prefix. Underscores, camelCase, and uppercase are all invalid.

**Wrong:** `feat/Add_User_Auth`
**Right:** `feat/add-user-auth`

---

## Commit Messages

### Guessing the scope when unsure
If the scope is not clearly evident from the staged changes, **omit the parenthetical entirely**. Do not guess.

**Wrong:** `feat(misc): add retry logic` — `misc` is not an allowed scope
**Right:** `feat: add retry logic`

### Forgetting BREAKING CHANGE footer
If the change is breaking, the commit body or footer **must** include `BREAKING CHANGE:`. The subject line alone is not enough.

**Wrong:**
```
feat!: change API response format
```

**Right:**
```
feat: change API response format

BREAKING CHANGE: The /users endpoint now returns an array instead of an object wrapper.
```

### Using disallowed commit types
Only these types are allowed: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`. Common mistakes:
- `style` → use `chore`
- `perf` → use `feat` or `refactor`
- `hephaestus` → use `chore`
- `ci` → use `chore`

---

## Pull Requests

### Copy-pasting and leaving placeholder comments
The PR template contains HTML comments as hints. These **must be replaced** with real content, not left as-is or supplemented beside the comment.

### Missing mandatory sections
All five sections are required even for small changes: Problem Statement, Behavior Summary, Test Evidence, Risk and Rollback, Reviewer Checklist. Omitting "Risk and Rollback" for a small fix is still a violation.

### Notebook-driven PR without metadata table
If the PR involves notebook-extracted code, the five additional metadata fields are **mandatory**, not optional. Missing even one blocks the checklist.

---

## General

### Using `--no-verify`
Never use `--no-verify` on commit or push. If a hook is failing, fix the underlying issue.

### Committing directly to `main`
Always create a topic branch first. Even single-line documentation fixes go through a branch.

### Overly broad branch scope
One branch = one logical change. If the branch touches unrelated areas, split it. Signs of scope creep:
- Commit messages use different types (e.g., `feat` and `fix` in the same branch)
- The PR description needs multiple problem statements
- Reviewers ask "why is this in the same PR?"
