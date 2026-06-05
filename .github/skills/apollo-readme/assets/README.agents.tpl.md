# <Repository README>

> Bundled specialized template asset owned by `apollo-readme` for repositories organized around thin agent entrypoints, reusable shared skills, and neutral governance assets.
>
> Keep all headings and section order exactly as written. Optional sections are marked in the table of contents and MUST remain present in the generated `README.md`. If an optional section does not apply, replace the entire section body with the exact literal `Not applicable.`.
>
> Explain the operating model before inventories. A reader who is new to the repository should understand how requests move through agents, skills, templates, and checklists before they reach the detailed catalogs.

For dense tables, if a cell needs multiple paths, bundles, deliverables, or supporting artifacts, render one item per line using `<br>`. Prefer the shortest repository-relative path that remains unambiguous.

## Table of Contents
1. [Repository Purpose](#1-repository-purpose)
2. [Operating Philosophy](#2-operating-philosophy)
3. [Getting Started](./QUICKSTART.md)
4. [Repository Layout](#4-repository-layout)
5. [Agents, Skills, and Governance](#5-agents-skills-and-governance)
6. [Outputs and Workflows](#6-outputs-and-workflows)
7. [Extension Rules](#7-extension-rules)
8. [Maintenance Notes (Optional)](#8-maintenance-notes)
9. [Known Gaps and Open Questions (Optional)](#9-known-gaps-and-open-questions)

---

## 1. Repository Purpose

### Summary
`<Insert concise description of what the repository contains and why it exists. Mention agent entrypoints, shared skills, neutral governance assets, and persistent documentation or report outputs when explicit evidence supports them.>`

### Intended Audience
- `<Insert the primary maintainer, contributor, or operator groups expected to use this repository>`

### Scope
- In scope:
  - `<Insert governed artifact families, such as agent entrypoints, skill bundles, templates, checklists, and generated documentation or report outputs>`
- Out of scope:
  - `<Insert what the repository explicitly does not implement or own directly>`

### Primary Outcomes
- `<Insert the concrete outcomes enabled by the repository, such as governed bundle authoring, review, documentation, setup orchestration, or report generation>`

---

## 2. Operating Philosophy

### Core Principles
- `<Insert the evidence-based design principles that repeat across the repository, such as thin routers, skill-owned detail, deterministic selection, explicit validation, and single-target execution>`

### Responsibility Model

| Layer | Owns | Typical Artifacts | Does Not Own |
|-------|------|-------------------|--------------|
| Agents | `<Insert what top-level agents own>` | `<Insert representative *.agent.md entrypoints and agent-local companions>` | `<Insert the detailed logic they intentionally delegate>` |
| Skills | `<Insert what shared or routed skills own>` | `<Insert representative SKILL.md, assets/*.tpl.md, and assets/*.checklist.md artifacts>` | `<Insert what skills do not own directly>` |
| Neutral Governance | `<Insert what the shared neutral layer provides>` | `<Insert representative .github/governance/ assets>` | `<Insert what remains owned by agents or skills instead>` |
| Generated Outputs | `<Insert the persistent or bounded outputs created by workflows>` | `<Insert representative README, reports, or generated bundle roots>` | `<Insert what the repository does not persist automatically>` |

### Request Lifecycle
1. `<Insert how a caller starts with a top-level agent or a directly invocable skill>`
2. `<Insert how one skill, profile, template, or target is resolved>`
3. `<Insert how owned templates, checklists, or other governed inputs are loaded>`
4. `<Insert how validation runs and how persistent outputs are written>`

---

## 3. Quick Start

See [QUICKSTART.md](./QUICKSTART.md) for setup instructions and your first iteration.

### How to Approach the Repository
1. Determine the outcome you need and start from the matching top-level agent or directly invocable skill.
2. Provide one explicit target whenever the workflow resolves a bundle kind, profile, template, or review subject.
3. Let the selected skill own the detailed templates, checklists, and workflow-specific rules.
4. Review the generated or persisted output, then use the repository git workflow when you need branch, commit, or pull-request metadata.

### How to use Copilot in VSCode

Official site: https://code.visualstudio.com/docs/copilot/overview

> **Note:** The table below is a template. Customize the roles and steps to match your organization's workflow.

- Manual steps in applications generated with Copilot:
		EM: Engineering Manager (depending on the area)
		TO: Technical Office (technical.office@example.com)
		DO: Devops Office (devops.office@example.com)
 
| Where | Who | When | What |
|-------|------|-------------------|----|
| NG/NET/PY | EM | Before starting | Request a new repository. Provide name, application type, and team access |
| NG | EM | Before starting | Request Application Registration in your identity provider (if login is needed) |
| NG | EM | Runtime | Configure access to your private package registry |
| NG/NET | EM | Runtime | Create configuration entries (dev and prod) |
| NET/PY | TO | Runtime | Database creation (SQL and/or PostgreSQL), provide creation script |
| NG/NET/PY | EM | After finishing | Final code validation |
| NET/PY | TO | After finishing | API Gateway endpoint (only for applications with public URLs) |
| NG/NET/PY | DO | After finishing | Create CI/CD pipeline jobs |

### Common Starting Points

| Goal | Start Here | Delegates To / Uses | What to Provide | Expected Result |
|------|------------|---------------------|-----------------|-----------------|
| `<Insert goal>` | `<Insert agent or skill name>` | `<Insert resolved skill, template, or governed input>` | `<Insert the minimum explicit input needed to begin>` | `<Insert the expected output or decision>` |

### Example Requests

Use one row per high-frequency workflow. Keep examples short, concrete, and attributable to existing agents or skills.

| Scenario | Example Request | Why This Is the Right Starting Point |
|----------|-----------------|--------------------------------------|
| `<Insert scenario>` | `<Insert one concise example request or prompt>` | `<Insert why the selected agent or skill is the correct entrypoint>` |

### First Places to Read
- `<Insert the exact files a newcomer should read first, such as the main README, one or two top-level agents, and the neutral governance scaffolds>`

---

## 4. Repository Layout

### Key Paths

| Path or Pattern | Role | Ownership Model | Notes |
|-----------------|------|-----------------|-------|
| `.github/agents/*.agent.md` | `<Insert role>` | `<Insert ownership model>` | `<Insert notes>` |
| `.github/agents/*/` | `<Insert role>` | `<Insert ownership model>` | `<Insert notes>` |
| `.github/skills/*/SKILL.md` | `<Insert role>` | `<Insert ownership model>` | `<Insert notes>` |
| `.github/skills/*/assets/` | `<Insert role>` | `<Insert ownership model>` | `<Insert notes>` |
| `.github/governance/` | `<Insert role>` | `<Insert ownership model>` | `<Insert notes>` |
| `<Insert repository-root generated output paths or patterns>` | `<Insert role>` | `<Insert ownership model>` | `<Insert notes>` |

### Placement and Naming Rules
- `<Insert the stable placement rules for top-level agents>`
- `<Insert how skill-local assets differ from shared neutral governance assets>`
- `<Insert how new technology or domain areas should be added>`

---

## 5. Agents, Skills, and Governance

### Top-Level Agents

Use one row per top-level agent entrypoint.

| Agent | Entry Point | Delegates To / Resolves | Primary Responsibility | Main Output or Decision |
|-------|-------------|-------------------------|------------------------|-------------------------|
| `agent-name` | `path` | `<Insert resolved skill, profile, template, or fixed target>` | `<Insert responsibility>` | `<Insert output or decision>` |

### Shared and Routed Skills

Use one row per shared skill or routed skill family that materially affects repository behavior.

| Skill or Family | Path | Used By | Owns | Notes |
|-----------------|------|---------|------|-------|
| `skill-name` | `path` | `<Insert one consumer per line when needed>` | `<Insert owned templates, checklists, or outputs>` | `<Insert routing or usage notes>` |

### Neutral Governance Assets

| Asset | Path | Consumed By | Purpose |
|-------|------|-------------|---------|
| `<Insert asset>` | `path` | `<Insert one consumer per line when needed>` | `<Insert purpose>` |

---

## 6. Outputs and Workflows

### Persistent Outputs

| Producing Agent or Skill | Deliverable | Default Location | Preconditions / Notes |
|--------------------------|-------------|------------------|-----------------------|
| `producer` | `<Insert deliverable>` | `<Insert location>` | `<Insert constraints>` |

### Core Workflows

Use one row per explicit repository workflow.

| Workflow | Starting Point | Resolution Rule | Validation Layer | Outcome |
|----------|----------------|-----------------|------------------|---------|
| `<Insert workflow>` | `<Insert agent or skill>` | `<Insert how one target or skill is resolved>` | `<Insert checklist or review gate>` | `<Insert output or result>` |

### Documentation Template Selection
- Bundled documentation skill: `<Insert the single skill path that owns README generation>`
- General fallback template: `<Insert the generic README template asset path>`
- Specialized template for this repository shape: `<Insert the specialized bundled template asset path>`
- Selection rule: `<Insert how the documentation agent resolves the skill, how the skill evaluates README templates, when clarification is required, and when generic remains the fallback>`

---

## 7. Extension Rules

### When to Add a New Agent vs a New Skill
- `<Insert when a new top-level agent is justified>`
- `<Insert when a new shared or routed skill is the better fit>`
- `<Insert when shared neutral governance assets should be introduced or reused>`

### Authoring and Review Guardrails
- `<Insert the repeatable guardrails such as single-target scope, explicit asset ownership, deterministic resolution, and checklist-driven validation>`

### Recommended Extension Flow
1. `<Insert how a maintainer should decide the target layer>`
2. `<Insert how the new bundle or skill should be created>`
3. `<Insert how the result should be reviewed>`
4. `<Insert when repository documentation should be refreshed>`

---

## 8. Maintenance Notes

_Optional section. If it does not apply, replace the entire section body with `Not applicable.`._

### Update Triggers
- `<Insert when maintainers should refresh the README, catalog tables, or routing summaries>`

### Review Touchpoints
- `<Insert the review or checklist paths maintainers should use after repository changes>`

---

## 9. Known Gaps and Open Questions

_Optional section. If it does not apply, replace the entire section body with `Not applicable.`._

### Confirmed Gaps
- `<Insert explicit documentation, governance, or coverage gaps>`

### Open Questions
- `<Insert unresolved structure, ownership, or scope questions>`
