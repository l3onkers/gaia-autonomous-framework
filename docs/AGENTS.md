# Agent Catalog

> Detailed documentation for all 8 callable agents in the Copilot Governance Framework.

## How Agents Work

Agents are **thin coordinators** â€” they don't contain business logic. Instead, they:
1. Validate the incoming request
2. Resolve which skill(s) to delegate to
3. Load their companion templates and checklists
4. Orchestrate the skill execution
5. Validate the result

Every agent follows a standard **7-section structure**:
1. Objective â†’ What the agent does
2. Output Contract â†’ What it produces
3. Evidence & Inference Usage Rules â†’ How it handles ambiguity
4. Determinism Requirement â†’ How decisions are made
5. Applicability Rules â†’ When to use (and not use) this agent
6. Process Definition â†’ Step-by-step execution flow
7. Validation Layer â†’ How results are verified

---

## ðŸ”€ Triage Agent

**File:** `.github/agents/gaia.agent.md`

**Purpose:** Routes any request to the strongest matching agent when the user doesn't know which agent to use.

**When to use:**
- You're new to the framework
- Your request could map to multiple agents
- You want the system to figure out the right path

**Example requests:**
```
"I need to create a new Python API with database connectors"
â†’ Routes to py-build

"Review the security of this codebase"
â†’ Routes to security

"Generate a README for this repository"
â†’ Routes to documentator
```

---

## ðŸ—ï¸ hephaestus agent

**File:** `.github/agents/hephaestus.agent.md`

**Purpose:** Authors new governed agent bundles or skill bundles using the canonical governance scaffolds.

**Delegates to:**
- `build-agent` â€” When creating a new agent
- `build-skill` â€” When creating a new skill
- Governance update paths â€” When modifying shared governance assets

**When to use:**
- Creating a new agent for a new workflow family
- Creating a new skill for reusable task-specific behavior
- Updating governance scaffolds or templates

**Example:**
```
"Build a new governed agent bundle for data pipeline orchestration"
```

---

## ðŸ“„ apollo agent

**File:** `.github/agents/apollo.agent.md`

**Purpose:** Generates or refreshes repository documentation using governed templates and live repository state.

**Delegates to:**
- `create-or-update-readme` â€” For README generation/refresh
- `markdown-converter` â€” For format conversion (HTML, PDF, DOCX, etc.)

**Companion files:**
- `documentator/documentator.checklist.md` â€” Validation checklist

**When to use:**
- Generating a new README from a template
- Refreshing the README to reflect repository changes
- Converting Markdown to other formats

**Example:**
```
"Regenerate the repository README.md using the current template"
"Convert README.md to HTML"
```

---

## ðŸŸ£ .NET hephaestus agent

**File:** `.github/agents/net-hephaestus.agent.md`

**Purpose:** Orchestrates .NET project scaffolding by routing to one of 6 supported profile skills.

**Supported profiles:**

| Profile | Skill | Description |
|---------|-------|-------------|
| `api` | `net-setup-api` | Standard REST API with Clean Architecture |
| `api-cqrs` | `net-setup-api-cqrs` | CQRS-pattern API with MediatR |
| `api-modular` | `net-setup-api-modular` | Modular monolith architecture |

| `worker` | `net-setup-worker` | Background worker service |
| `job` | `net-setup-job` | Scheduled job / hosted service |

**Companion files:**
- `net-build/net-build.tpl.md` â€” Shared .NET governance rules
- `net-build/net-build.checklist.md` â€” Validation checklist

**Example:**
```
"Use net-build to scaffold a CQRS API for user management"
```

---

## ðŸ”´ Angular hephaestus agent

**File:** `.github/agents/ng-hephaestus.agent.md`

**Purpose:** Orchestrates Angular SPA scaffolding with governed UI composition and optional SSO login.

**Supported profiles:**
- `spa` â€” Single-page application with header wrapper and optional SSO login

**Delegates to:**
- `ng-setup-spa` â€” SPA-specific structure and login generation
- `components-catalog` â€” Corporate UI component references
- `mockup-layouts` â€” Page layout patterns
- `global-styles` â€” Design tokens and utility classes

**Companion files:**
- `ng-build/ng-build.tpl.md` â€” Shared Angular governance (dependencies, folder structure, coding standards)
- `ng-build/ng-build.checklist.md` â€” Validation checklist

**Example:**
```
"Use ng-build to scaffold a SPA called 'my-dashboard' with SSO login"
```

---

## ðŸ Python hephaestus agent

**File:** `.github/agents/py-hephaestus.agent.md`

**Purpose:** Orchestrates Python project scaffolding by resolving and executing layers in dependency order.

**Supported layers:**

| Layer | Skill | Prerequisites |
|-------|-------|--------------|
| `environment` | `add-layer-py-environment` | None |
| `logger` | `add-layer-py-logger` | `environment` |
| `api` | `add-layer-py-api` | `environment` |
| `connectors` | `add-layer-py-connectors` | `environment` |
| `pytest` | `add-layer-py-pytest` | `environment` |
| `pytest-fastapi` | `add-layer-py-pytest-fastapi` | `environment`, `api`, `pytest` |
| `cicd` | `add-layer-py-cicd` | `environment`, `api` |

**Automatic dependency resolution:** Request `pytest-fastapi` and the agent will automatically include `environment` â†’ `api` â†’ `pytest` â†’ `pytest-fastapi`.

**Companion files:**
- `py-build/py-build.tpl.md` â€” Shared Python governance
- `py-build/py-build.checklist.md` â€” Validation checklist

**Example:**
```
"Use py-build to add the api and pytest-fastapi layers"
```

---

## ðŸ”’ minerva agent

**File:** `.github/agents/minerva.agent.md`

**Purpose:** Routes security requests to 6 specialized skills covering audits, reviews, triage, patches, and event-driven scans.

**Routes:**

| Request Type | Skill | Output |
|-------------|-------|--------|
| Repository audit | In-place audit route | `SECURITY_AUDIT.md` |
| Code-level review | `security-review` | `SECURITY_REVIEW.md` or PR comments |
| Evidence triage | `security-triage` | `SECURITY_TRIAGE.md` |
| Patch proposal | `security-patch` | `SECURITY_PATCH.md` + approval gate |
| PR review event | `pr-security-review` | PR security comments |
| Commit secret scan | `commit-secret-scan` | Secret alert or confirmation |
| Dependency check | `dependency-security-check` | Dependency findings comment |

**Companion files:**
- `security/security.tpl.md` â€” Audit template
- `security/security.checklist.md` â€” Audit validation

**Example:**
```
"Generate SECURITY_AUDIT.md for this repository"
"Review the changed API files for security vulnerabilities"
"Prepare a minimal patch proposal for finding SR-002"
```

---

## ðŸ‘ï¸ apollo agent

**File:** `.github/agents/apollo.agent.md`

**Purpose:** Reviews governed bundles (agents and skills) for compliance against the canonical governance scaffolds.

**Delegates to:**
- `supervise-agent` â€” Reviews agent bundles against `AGENT.base.tpl.md`
- `supervise-skill` â€” Reviews skill bundles against `SKILL.base.tpl.md` and `SKILL.block-catalog.md`

**Output:** One compliance report per reviewed bundle.

**Example:**
```
"Review .github/skills/create-or-update-readme/SKILL.md"
"Supervise the ng-hephaestus agent bundle"
```
