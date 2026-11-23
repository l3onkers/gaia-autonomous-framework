# 🎯 Verified Operational Conventions & Guidelines

---

## 1. Multi-Platform Interoperability
- **Root Configuration:** `AGENTS.md` is the single source of truth for repository rules across Antigravity App, Antigravity CLI, Cursor, and Copilot.
- **Skill Discovery:** Reusable skills live in `.github/skills/` and are registered in `.agents/skills.json` to prevent duplicated files.
- **Git Protocol:** Feature branches follow `apollo-git-workflow` (`feat/`, `fix/`, `chore/`). Direct pushes to `main` are blocked.

## 2. Scaffolding & Code Generation
- **Clean Root:** Application code belongs in generated target repositories or dedicated subdirectories; the GAIA framework root must remain pure governance and orchestration.
- **Frontend Standard:** New frontend scaffolds must default to React; Angular is preserved for existing `eleuthia-ng-*` profiles.

## 3. Resilience & Security
- **Strict Zero Trust:** Secrets must never be logged or echoed in markdown.
- **Destructive Actions:** Teardowns, schema drops, and chaos injections require explicit user approval.
