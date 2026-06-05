# Branch Prefix Mapping

Maps change types (commit types) to the correct branch prefix. The mapping is **not 1:1** — some commit types share a branch prefix.

## Mapping Table

| Change Type | Branch Prefix | Example Branch Name |
|---|---|---|
| `feat` | `feat/` | `feat/add-user-search` |
| `refactor` | `feat/` | `feat/extract-parsing-logic` |
| `fix` | `fix/` | `fix/null-pointer-on-login` |
| `docs` | `docs/` | `docs/update-api-guide` |
| `chore` | `chore/` | `chore/pin-dependency-versions` |
| `test` | `chore/` | `chore/add-validation-tests` |

## Additional Prefix

| Prefix | When to Use | Example |
|---|---|---|
| `hotfix/` | Urgent production fix requiring expedited review | `hotfix/critical-auth-bypass` |

## Rules

1. **Caller-explicit prefix wins.** If the caller explicitly names a prefix from the allowed set (`feat`, `fix`, `hotfix`, `docs`, `chore`), use it as-is.
2. **Infer from change type otherwise.** Use the mapping table above to derive the prefix from the commit type.
3. **When in doubt, ask.** If the change type cannot be confidently mapped, request clarification rather than guessing.

## Common Mistakes

| Mistake | Why It's Wrong | Correct |
|---|---|---|
| `refactor/extract-helper` | `refactor` is not an allowed branch prefix | `feat/extract-helper` |
| `test/add-edge-cases` | `test` is not an allowed branch prefix | `chore/add-edge-cases` |
| `feature/add-search` | `feature` is not an allowed prefix (use `feat`) | `feat/add-search` |
| `bugfix/login-error` | `bugfix` is not an allowed prefix (use `fix`) | `fix/login-error` |
