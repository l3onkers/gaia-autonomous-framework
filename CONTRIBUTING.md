# Contributing to Copilot Governance Framework

First off, thank you for considering contributing! ðŸŽ‰

## How Can I Contribute?

### ðŸ› Reporting Bugs

- Use the [GitHub Issues](https://github.com/l3onkers/gaia-autonomous-framework/issues) tab
- Include steps to reproduce, expected behavior, and actual behavior
- Include your environment details (VS Code version, Copilot version)

### ðŸ’¡ Suggesting New Agents or Skills

Have an idea for a new agent or skill? Open an issue with:
- **Title:** `[Agent]` or `[Skill]` prefix
- **Description:** What problem it solves, what inputs/outputs it has
- **Example request:** A sample user prompt that would trigger the agent/skill

### ðŸ”§ Pull Requests

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/my-new-skill`
3. **Follow** the framework patterns:
   - Agents go in `.github/agents/`
   - Skills go in `.github/skills/`
   - Use the `hephaestus` agent or the governance scaffolds to create new bundles
4. **Test** your changes by running the agent/skill through Copilot Chat
5. **Submit** a PR with a clear description of the change

### ðŸ“ Documentation

Documentation improvements are always welcome! Whether it's:
- Fixing typos
- Improving explanations
- Adding examples
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

Every skill must include:
- `SKILL.md` â€” The skill manifest
- `assets/` â€” Templates, checklists, and references
- Clear input/output contract
- Validation layer

See [docs/CREATING_SKILLS.md](docs/CREATING_SKILLS.md) for the full guide.

### Frontend Policy

- New frontend skills should default to React first.
- Use Angular only when the governed stack or existing repository conventions require it.
- Keep frontend choices explicit in the skill manifest and in the generated output contract.

### Structural Validation

- Repository-level consistency checks should live in the dedicated structure validation workflow.
- Do not fold repository governance checks into product-specific pipelines unless the workflow explicitly requires it.

### Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Agent | `{name}.agent.md` | `minerva.agent.md` |
| Agent companion | `{agent-name}/{agent-name}.tpl.md` | `ng-build/eleuthia-ng.tpl.md` |
| Skill | `{skill-name}/SKILL.md` | `apollo-git-workflow/SKILL.md` |
| Skill template | `{skill-name}/assets/{skill-name}.tpl.md` | `eleuthia-net-api/assets/eleuthia-net-api.tpl.md` |
| Skill checklist | `{skill-name}/assets/{skill-name}.checklist.md` | `minerva-review/assets/minerva-review.checklist.md` |

### Commit Messages

Use conventional commit format:
```
feat(agent): add new data-pipeline coordinator
fix(skill): correct layer dependency in py-build
docs: update ARCHITECTURE.md with new diagram
```

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Questions?

Open a [Discussion](https://github.com/l3onkers/gaia-autonomous-framework/discussions) for questions or ideas that aren't ready for an issue yet.

