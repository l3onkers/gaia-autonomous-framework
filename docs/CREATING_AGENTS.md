# Creating Custom Agents

> Step-by-step guide to creating your own agent in the Copilot Governance Framework.

## Prerequisites

- Understanding of the [Architecture](ARCHITECTURE.md)
- Familiarity with the existing [Agent Catalog](AGENTS.md)

---

## When to Create an Agent

Create a new agent when:
- ✅ You need a **new callable coordinator** for a distinct workflow family
- ✅ The workflow requires **routing to multiple skills**
- ✅ You want **wrapper-level validation** across the skills it delegates to

Don't create an agent when:
- ❌ A skill would suffice (prefer skills for single-task behavior)
- ❌ An existing agent already covers the workflow
- ❌ You just need to add a template or checklist (add it to an existing skill instead)

---

## Step 1: Plan Your Agent

Answer these questions:

| Question | Example |
|----------|---------|
| What bounded workflow does it coordinate? | "Data pipeline orchestration" |
| What skills will it delegate to? | `setup-pipeline`, `validate-pipeline` |
| What inputs does it need? | Pipeline name, source type, target type |
| What does it produce? | One governed pipeline scaffold |
| When should it NOT be used? | Non-pipeline infrastructure requests |

---

## Step 2: Use the hephaestus agent (Recommended)

The fastest way to create a new agent:

```
@workspace Use build to create a new governed agent bundle for data pipeline orchestration.
```

The `hephaestus` agent will:
1. Load the canonical scaffold from `.github/governance/bundles/agent/AGENT.base.tpl.md`
2. Generate your agent entry point and companion files
3. Validate the result through `apollo-supervise-agent`

---

## Step 3: Manual Creation

If you prefer to create the agent manually, follow this structure:

### File Structure

```
.github/agents/
├── {name}.agent.md           # Entry point
└── {name}/                   # Companion directory
    ├── {name}.tpl.md          # Detailed template
    └── {name}.checklist.md    # Validation checklist
```

### Agent Entry Point Template

Create `.github/agents/{name}.agent.md`:

```markdown
---
name: {name}
target: vscode
description: {one-line description}
---

## 1. Objective
{What this agent does and what it MUST/MUST NOT do}

## 2. Output Contract
{What it produces, what skills it delegates to, supported profiles/modes}

## 3. Evidence & Inference Usage Rules
{Evidence priority order, deterministic mapping rules, inference policy}

## 4. Determinism Requirement
Determinism Strategy: Hybrid
{Deterministic orchestration rules}

## 5. Applicability Rules
{When to use, supported input kinds, out of scope}

## 6. Process Definition
{Step-by-step execution flow}

## 7. Validation Layer
{Structural checks, execution checks}
```

### Key Rules

1. **YAML Front Matter** — Must include `name`, `target`, and `description`
2. **Exactly 7 sections** — In the order shown above
3. **Determinism Strategy** — Must be `Hybrid` on the first non-empty line of Section 4
4. **Keep it thin** — Detailed rules go in the companion `.tpl.md`, not in the agent itself

---

## Step 4: Create Companion Files

### Template (`.tpl.md`)

The template contains all the detailed rules, code examples, and generation logic:

```markdown
# {name} Template

## Purpose
{Why this template exists}

## Required Inputs
{Variables and defaults}

## Scope Rules
{What's in and out of scope}

## Dependency and Library Policy
{Approved packages and versions}

## Architecture and Coding Standards
{Patterns, folder structure, naming conventions}

## Quality and Expected Outputs
{Quality gates, expected files, completion checklist}
```

### Checklist (`.checklist.md`)

The checklist is used for validation:

```markdown
# {name} Checklist

## A. Bundle Integrity
- [ ] Companion artifacts exist with matching basename
- [ ] Agent references template and checklist as governed inputs

## B. Agent Governance Structure
- [ ] YAML front matter exists with required keys
- [ ] Exactly seven core sections exist in order
- [ ] Determinism Strategy is declared

## C. Standards Coverage
- [ ] Required variables are preserved
- [ ] {stack-specific checks}

## D. Skill Routing
- [ ] Skill resolution uses deterministic rules
- [ ] Exactly one skill is resolved per run

## E. Safety
- [ ] No secrets or credentials are introduced
- [ ] Dependency rules enforce the allowlist
```

---

## Step 5: Register the Agent

1. Add the agent to [`.github/AGENT.md`](../.github/AGENT.md):

```markdown
| `{name}` | `.github/agents/{name}.agent.md` | {When to use} |
```

2. Update the triage agent ([`.github/agents/gaia.agent.md`](../.github/agents/gaia.agent.md)) to include routing rules for your new agent.
3. If the agent has companion assets, keep them inside `.github/agents/{name}/` and keep the basename identical to the entrypoint.

---

## Step 6: Validate

Run the supervisor to check compliance:

```
@workspace Use supervisor to review .github/agents/{name}.agent.md
```

This will check your agent against the canonical scaffold and report any compliance issues.

---

## Examples

### Existing Agents to Study

| Agent | Complexity | Good example of |
|-------|-----------|----------------|
| `gaia` | Simple | Core routing and deterministic triage |
| `hephaestus` | Medium | Bundle authoring and governance scaffolding |
| `eleuthia` | Complex | Multi-profile scaffolding and companion asset resolution |
| `minerva` | Complex | Security triage and specialized skill routing |

## Agent Authoring Policy

- Treat the 7-section structure as the canonical specification for new and refactored agents.
- Keep the entrypoint thin; move detailed rules into the companion template and checklist.
- Do not introduce aliases or alternate agent names in the docs unless the repository actually ships them.
