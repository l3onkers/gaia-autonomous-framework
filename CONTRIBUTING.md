# Contributing to G.A.I.A. Autonomous Framework

First off, thank you for considering contributing! 🎉

## How Can I Contribute?

### 🐛 Reporting Bugs

- Use the [GitHub Issues](https://github.com/l3onkers/gaia-autonomous-framework/issues) tab
- Include steps to reproduce, expected behavior, and actual behavior
- Include your environment details (Antigravity App / `agy` CLI, VS Code / GitHub Copilot, Cursor, or Claude Code)

### 💡 Suggesting New Agents or Skills

Have an idea for a new agent or skill? Open an issue with:
- **Title:** `[Agent]` or `[Skill]` prefix
- **Description:** What problem it solves, what inputs/outputs it has
- **Example request:** A sample user prompt that would trigger the agent/skill

### 🔧 Pull Requests

1. **Fork** the repository
2. **Create** a governed feature branch from `develop`: `git checkout -b feat/my-new-skill`
3. **Follow** the framework patterns:
   - Agents go in `.github/agents/` (with subagent bridges in `.agents/agents/`)
   - Skills go in `.github/skills/` (exposed via `.agents/skills`)
   - Knowledge & few-shot examples go in `knowledge/`
   - Use the `hephaestus` agent (`hephaestus-build-skill` / `hephaestus-build-agent`) and `apollo` supervisor to create new bundles
4. **Test** your changes locally by running `bash tests/run-all.sh`
5. **Submit** a PR targeting `develop` with a clear description of the change

### 📝 Documentation

Documentation improvements are always welcome! Whether it's:
- Fixing typos
- Improving explanations or platform deployment guides ([docs/PLATFORMS.md](docs/PLATFORMS.md))
- Adding domain-agnostic few-shot examples in `knowledge/examples/`
- Translating content

## Development Guidelines

### Agent Structure

Every new or refactored agent must follow the canonical 7-section structure:
1. Objective
2. Output Contract
3. Evidence & Inference Usage Rules
4. Determinism Requirement
5. Applicability Rules
6. Process Definition
7. Validation Layer

See [docs/CREATING_AGENTS.md](docs/CREATING_AGENTS.md) for the full guide.

### Skill Structure

Every skill must remain **100% domain-agnostic** and include:
- `SKILL.md` — The skill manifest with the 6 required governance headings
- `assets/` — Templates (`*.tpl.md`) and checklists (`*.checklist.md`)
- Clear input/output contract
- Validation layer

See [docs/CREATING_SKILLS.md](docs/CREATING_SKILLS.md) for the full guide.

### Frontend Policy

- New frontend skills should default to React first.
- Use Angular only when the governed stack or existing repository conventions require it.
- Keep frontend choices explicit in the skill manifest and in the generated output contract.

### Structural Validation

- Repository-level consistency checks live in `.github/workflows/scripts/validate-structure.sh` and the local test suite (`bash tests/run-all.sh`).
- Do not fold repository governance checks into product-specific pipelines unless the workflow explicitly requires it.

### Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Agent | `{name}.agent.md` | `minerva.agent.md` |
| Subagent bridge | `.agents/agents/{name}.md` | `.agents/agents/minerva.md` |
| Skill | `{skill-name}/SKILL.md` | `apollo-git-workflow/SKILL.md` |
| Skill template | `{skill-name}/assets/{skill-name}.tpl.md` | `eleuthia-net-api/assets/eleuthia-net-api.tpl.md` |
| Skill checklist | `{skill-name}/assets/{skill-name}.checklist.md` | `minerva-review/assets/minerva-review.checklist.md` |

### Commit Messages & Branch Prefixes

Follow the rules enforced by `apollo-git-workflow`:
- Allowed branch prefixes: `feat/`, `fix/`, `hotfix/`, `docs/`, `chore/`
- Allowed conventional commit types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`

```text
feat(agent): add new data-pipeline coordinator
fix(skill): correct layer dependency in py-build
docs(readme): update ARCHITECTURE.md with new diagram
```

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Questions?

Open a [Discussion](https://github.com/l3onkers/gaia-autonomous-framework/discussions) for questions or ideas that aren't ready for an issue yet.
