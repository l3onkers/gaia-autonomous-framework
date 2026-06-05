# Architecture

> How the Copilot Governance Framework routes requests through agents, skills, and governance templates to produce deterministic, governed results.

## Design Philosophy

The framework follows three core principles:

1. **Thin Coordinators** â€” Agents resolve *one bounded path* and delegate all detail to skills
2. **Skill-Owned Detail** â€” Skills own templates, checklists, validation, and generation logic
3. **Neutral Governance** â€” Shared scaffolds and standards are decoupled from any specific agent or skill

## System Overview

```mermaid
flowchart LR
    subgraph Input
        REQ[User Request]
    end

    subgraph Routing
        REQ --> TRIAGE[Triage Agent]
        TRIAGE -->|resolves| AGENT[Selected Agent]
    end

    subgraph Execution
        AGENT -->|loads| TPL[Agent Template]
        AGENT -->|loads| CHK[Agent Checklist]
        AGENT -->|delegates to| SKILL[Selected Skill]
        SKILL -->|uses| STPL[Skill Templates]
        SKILL -->|validates with| SCHK[Skill Checklists]
    end

    subgraph Governance
        SKILL -->|inherits from| GOV[Governance Scaffolds]
        SKILL -->|references| MOD[Governance Modules]
    end

    subgraph Output
        SKILL --> OUT[Governed Result]
    end

    style REQ fill:#4CAF50,color:#fff
    style TRIAGE fill:#FF9800,color:#fff
    style AGENT fill:#2196F3,color:#fff
    style SKILL fill:#2196F3,color:#fff
    style GOV fill:#9C27B0,color:#fff
    style MOD fill:#9C27B0,color:#fff
    style OUT fill:#4CAF50,color:#fff
```

## Request Lifecycle

Every request follows this deterministic flow:

### 1. Entry Point
The user either:
- Asks the **triage agent** to route their request (recommended for newcomers)
- Calls a **specific agent** directly (e.g., `eleuthia`, `eleuthia`)

### 2. Agent Resolution
The agent:
- Validates the request falls within its scope
- Loads its **companion template** (`.tpl.md`) and **checklist** (`.checklist.md`)
- Resolves which **skill(s)** to delegate to based on deterministic mapping rules

### 3. Skill Execution
The selected skill:
- Loads its own **templates**, **checklists**, and **reference assets**
- Applies governance rules from the shared governance layer
- Generates the governed output

### 4. Validation
Before finalizing:
- The skill validates against its own checklist
- The agent validates against its agent-level checklist
- Any failures require clarification instead of silent improvisation

## Component Relationships

### Agent â†’ Skill Mappings

```mermaid
graph LR
    BUILD[build] --> BA[build-agent]
    BUILD --> BS[build-skill]

    DOC[documentator] --> CR[create-or-update-readme]
    DOC --> MC[markdown-converter]

    NB["net-build"] --> NSA["net-setup-api"]
    NB --> NSW["net-setup-worker"]
    NB --> NSJ["net-setup-job"]
    NB --> NSC["net-setup-api-cqrs"]
    NB --> NSM["net-setup-api-modular"]


    NGB["ng-build"] --> NGS["ng-setup-spa"]
    NGB --> CC["components-catalog"]
    NGB --> ML["mockup-layouts"]
    NGB --> GS["global-styles"]

    PYB["py-build"] --> PE["add-layer-py-environment"]
    PYB --> PA["add-layer-py-api"]
    PYB --> PL["add-layer-py-logger"]
    PYB --> PC["add-layer-py-connectors"]
    PYB --> PT["add-layer-py-pytest"]
    PYB --> PF["add-layer-py-pytest-fastapi"]
    PYB --> PCI["add-layer-py-cicd"]

    SEC[security] --> SRV["security-review"]
    SEC --> STR["security-triage"]
    SEC --> SPT["security-patch"]
    SEC --> PRR["pr-security-review"]
    SEC --> CSS["commit-secret-scan"]
    SEC --> DSC["dependency-security-check"]

    SUP[supervisor] --> SAG["supervise-agent"]
    SUP --> SSK["supervise-skill"]

    style BUILD fill:#2196F3,color:#fff
    style DOC fill:#2196F3,color:#fff
    style NB fill:#2196F3,color:#fff
    style NGB fill:#2196F3,color:#fff
    style PYB fill:#2196F3,color:#fff
    style SEC fill:#2196F3,color:#fff
    style SUP fill:#2196F3,color:#fff
```

### Python Layer Dependency Graph

`eleuthia` resolves layer dependencies automatically:

```mermaid
graph TD
    ENV[environment] --> API[api]
    ENV --> LOG[logger]
    ENV --> CON[connectors]
    API --> PTF[pytest-fastapi]
    ENV --> PT[pytest]
    PT --> PTF
    API --> CICD[cicd]

    style ENV fill:#3776AB,color:#fff
    style API fill:#3776AB,color:#fff
```

If you request `pytest-fastapi`, the framework will automatically include `environment` â†’ `api` â†’ `pytest` â†’ `pytest-fastapi` in the correct order.

## File Organization

### Agent Bundle Structure

```
.github/agents/
â”œâ”€â”€ {name}.agent.md           # Agent entry point (7-section structure)
â””â”€â”€ {name}/                   # Companion directory
    â”œâ”€â”€ {name}.tpl.md          # Detailed template with rules and examples
    â””â”€â”€ {name}.checklist.md    # Validation checklist
```

### Skill Bundle Structure

```
.github/skills/{skill-name}/
â”œâ”€â”€ SKILL.md                  # Skill manifest
â”œâ”€â”€ assets/                   # Templates, checklists, examples
â”‚   â”œâ”€â”€ {skill-name}.tpl.md
â”‚   â”œâ”€â”€ {skill-name}.checklist.md
â”‚   â””â”€â”€ ...
â”œâ”€â”€ references/               # Reference documentation (optional)
â””â”€â”€ scripts/                  # Validation scripts (optional)
```

### Governance Layer

```
.github/governance/
â”œâ”€â”€ bundles/
â”‚   â”œâ”€â”€ agent/
â”‚   â”‚   â””â”€â”€ AGENT.base.tpl.md      # Canonical agent scaffold
â”‚   â””â”€â”€ skill/
â”‚       â”œâ”€â”€ SKILL.base.tpl.md      # Canonical skill scaffold
â”‚       â””â”€â”€ SKILL.block-catalog.md # Optional block catalog
â””â”€â”€ modules/
    â”œâ”€â”€ README.md                   # Module documentation
    â””â”€â”€ angular/                    # Package fallbacks
```

## Determinism Strategy

All agents use a **Hybrid** determinism strategy:

- **Deterministic:** Routing, profile selection, dependency resolution, and structural rules
- **Adaptive:** Content generation, code scaffolding, and user-facing composition

This means the *structure* of the output is always predictable, while the *content* adapts to the specific request.

## Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| Agents don't contain detailed rules | Keeps agents maintainable; rules live in skill-owned templates |
| Skills own their templates | Enables independent evolution without coordinator changes |
| Governance is neutral | Shared scaffolds work across different agents and skills |
| Checklists are mandatory | Every output must pass validation before being finalized |
| Clarification over improvisation | When in doubt, the system asks instead of guessing |
