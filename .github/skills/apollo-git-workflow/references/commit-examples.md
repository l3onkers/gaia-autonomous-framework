# Commit Message Examples

Good and bad commit messages for calibrating conventional-commit output.

---

## Good Examples

### Simple feature, no scope
```
feat: add pagination to user list endpoint
```
Clear, concise subject. No scope needed because the change area is obvious from context.

### Feature with scope
```
feat(validation): add email format check on registration
```
Scope `validation` is from the allowed set and accurately describes the change area.

### Fix with scope
```
fix(io): handle timeout on external API retry
```

### Documentation change
```
docs: update API authentication guide with token refresh flow
```

### Chore with scope
```
chore(ci): pin dependency versions in build pipeline
```

### Refactor
```
refactor: extract shared parsing logic into utility module
```
Note: `refactor` is a valid commit type even though `refactor/` is not a branch prefix.

### Test addition
```
test(validation): add edge case tests for date parsing
```

### Breaking change with footer
```
feat: restructure configuration file format

The configuration file now uses a flat key-value structure instead of nested sections.
Migration steps are documented in docs/migration-v3.md.

BREAKING CHANGE: Configuration files from v2 are not compatible. Run the migration script before upgrading.
```

---

## Bad Examples

### Too vague
```
fix: fix bug
```
**Why bad:** Subject says nothing about what was fixed.
**Better:** `fix: prevent null pointer when user profile is missing`

### Disallowed type
```
style: reformat imports
```
**Why bad:** `style` is not in the allowed type set.
**Better:** `chore: reformat imports`

### Guessed scope
```
feat(misc): add logging to request handler
```
**Why bad:** `misc` is not in the allowed scope set. If no clear scope applies, omit it.
**Better:** `feat: add logging to request handler`

### Missing BREAKING CHANGE footer
```
feat!: rename all API endpoints
```
**Why bad:** The `!` convention alone is insufficient. The body must include `BREAKING CHANGE:`.

### Multiple concerns in one commit
```
feat: add user search and fix pagination and update docs
```
**Why bad:** This is three separate changes. Each should be its own commit.

### Uppercase or trailing period
```
Feat: Add new endpoint.
```
**Why bad:** Type must be lowercase. Subject should not end with a period.
**Better:** `feat: add new endpoint`
