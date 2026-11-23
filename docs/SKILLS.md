# Skills Catalog

> Detailed documentation for all 42 governed skills in the Copilot Governance Framework.

## Frontend Policy

New frontend skills should default to React first. Use Angular only when the governed stack explicitly requires it or when extending an existing Angular family already owned by the repository.

This policy applies to new skills and new families; it does not force a migration of the current governed Angular assets.

## How Skills Work

Skills are the **workhorses** of the framework. While agents are thin routers, skills contain:
- **Templates** (`.tpl.md`) — Detailed rules, code examples, and generation logic
- **Checklists** (`.checklist.md`) — Validation criteria the output must satisfy
- **References** — Documentation, contracts, and examples
- **Scripts** — Validation and generation helper scripts

Each skill has a `SKILL.md` manifest that declares its purpose, inputs, outputs, and owned assets.

---

## Build & Setup Skills

### .NET Profile Skills

These skills are routed by the `eleuthia` agent. Each defines a complete .NET project scaffold.

#### `eleuthia-net-api`
- **Path:** `.github/skills/eleuthia-net-api/`
- **Profile:** Standard REST API
- **What it generates:** Clean Architecture .NET 8+ API with controllers, services, dependency injection, health checks, and Swagger
- **Key assets:** `eleuthia-net-api.tpl.md`

#### `eleuthia-net-api-cqrs`
- **Path:** `.github/skills/eleuthia-net-api-cqrs/`
- **Profile:** CQRS API
- **What it generates:** Command/Query separation with MediatR, domain events, and request validation
- **Key assets:** `eleuthia-net-api-cqrs.tpl.md`

#### `eleuthia-net-api-modular`
- **Path:** `.github/skills/eleuthia-net-api-modular/`
- **Profile:** Modular Monolith
- **What it generates:** Feature-based module structure with explicit module boundaries
- **Key assets:** `eleuthia-net-api-modular.tpl.md`



#### `eleuthia-net-worker`
- **Path:** `.github/skills/eleuthia-net-worker/`
- **Profile:** Background Worker
- **What it generates:** .NET Worker Service with health checks, configuration, and Docker support
- **Key assets:** `eleuthia-net-worker.tpl.md`

#### `eleuthia-net-job`
- **Path:** `.github/skills/eleuthia-net-job/`
- **Profile:** Scheduled Job
- **What it generates:** Hosted service with scheduled execution patterns
- **Key assets:** `eleuthia-net-job.tpl.md`

---

### Angular Profile Skill

#### `eleuthia-ng-spa`
- **Path:** `.github/skills/eleuthia-ng-spa/`
- **Used by:** `eleuthia`
- **What it generates:** Angular 21+ SPA with:
  - Governed header wrapper component
  - Optional SSO login wrapper with token management
  - Corporate design system integration
  - HTTP interceptors (error handling, API key, session, token)
  - Environment configuration with file replacement
- **Key assets:**
  - `eleuthia-ng-spa.tpl.md` — SPA profile rules and structure
  - `eleuthia-ng-spa.login.tpl.md` — SSO login generation template
  - `eleuthia-ng-spa.checklist.md` — Validation checklist

---

### Python Layer Skills

These skills are routed by the `eleuthia` agent and execute in dependency order.

#### `eleuthia-py-environment`
- **Path:** `.github/skills/eleuthia-py-environment/`
- **Layer:** `environment`
- **Prerequisites:** None (base layer)
- **What it generates:** Python project foundation with:
  - Environment variable management
  - Secret key detection and masking
  - Configuration loading from `.env` files
  - Structured settings classes

#### `eleuthia-py-api`
- **Path:** `.github/skills/eleuthia-py-api/`
- **Layer:** `api`
- **Prerequisites:** `environment`
- **What it generates:** FastAPI application scaffold with:
  - Route definitions and request/response models
  - Middleware configuration
  - Health check endpoints
  - CORS configuration

#### `eleuthia-py-logger`
- **Path:** `.github/skills/eleuthia-py-logger/`
- **Layer:** `logger`
- **Prerequisites:** `environment`
- **What it generates:** Structured logging setup with configurable handlers and formatters

#### `eleuthia-py-connectors`
- **Path:** `.github/skills/eleuthia-py-connectors/`
- **Layer:** `connectors`
- **Prerequisites:** `environment`
- **What it generates:** Database and SFTP connector modules with:
  - SQL Server, PostgreSQL, and MySQL adapters
  - SFTP client with retry logic
  - Connection pooling and credential management

#### `eleuthia-py-pytest`
- **Path:** `.github/skills/eleuthia-py-pytest/`
- **Layer:** `pytest`
- **Prerequisites:** `environment`
- **What it generates:** Test suite with pytest configuration, fixtures, and coverage settings

#### `eleuthia-py-pytest-fastapi`
- **Path:** `.github/skills/eleuthia-py-pytest-fastapi/`
- **Layer:** `pytest-fastapi`
- **Prerequisites:** `environment`, `api`, `pytest`
- **What it generates:** FastAPI-specific test harness with TestClient, async fixtures, and API endpoint tests

#### `hephaestus-py-cicd`
- **Path:** `.github/skills/hephaestus-py-cicd/`
- **Layer:** `cicd`
- **Prerequisites:** `environment`, `api`
- **What it generates:** CI/CD pipeline configuration for Python applications

---

## Security Skills

### `minerva-review`
- **Path:** `.github/skills/minerva-review/`
- **Used by:** `minerva`
- **What it does:** Performs code-level vulnerability analysis on specified files or PR-scoped changes
- **Output:** `SECURITY_REVIEW.md` or PR review comments

### `minerva-triage`
- **Path:** `.github/skills/minerva-triage/`
- **Used by:** `minerva`
- **What it does:** Prioritizes and groups security evidence by severity
- **Output:** `SECURITY_TRIAGE.md`

### `minerva-patch`
- **Path:** `.github/skills/minerva-patch/`
- **Used by:** `minerva`
- **What it does:** Generates minimal, governed fix proposals with an explicit approval gate
- **Output:** `SECURITY_PATCH.md` with Apply / Reject / Modify options
- **Important:** Patches are never applied automatically — human approval is always required

### `pr-minerva-review`
- **Path:** `.github/skills/pr-minerva-review/`
- **Used by:** `minerva`
- **What it does:** Reviews security-relevant changes in pull requests
- **Output:** PR review comments with security findings

### `minerva-secret-scan`
- **Path:** `.github/skills/minerva-secret-scan/`
- **Used by:** `minerva`
- **What it does:** Detects secrets (API keys, tokens, passwords) in pushed commits
- **Detection patterns:** AWS, GCP, cloud provider keys, GitHub tokens, Stripe keys, and more

### `minerva-dep-check`
- **Path:** `.github/skills/minerva-dep-check/`
- **Used by:** `minerva`
- **What it does:** Reviews dependency manifest changes for known vulnerabilities
- **Output:** Dependency security findings in PR comment format

---

## Documentation & Governance Skills

### `apollo-readme`
- **Path:** `.github/skills/apollo-readme/`
- **Used by:** `apollo`
- **What it does:** Generates or refreshes README.md using bundled template assets
- **Templates:**
  - `README.generic.tpl.md` — General-purpose fallback
  - `README.agents.tpl.md` — Specialized for agent-based repositories

### `apollo-markdown`
- **Path:** `.github/skills/apollo-markdown/`
- **Used by:** `apollo` or direct invocation
- **What it does:** Converts Markdown to HTML, PDF, DOCX, TeX, or EPUB via Pandoc
- **Includes:** Governed HTML template with head injection and logo assets

### `apollo-git-workflow`
- **Path:** `.github/skills/apollo-git-workflow/`
- **Used by:** Any repository git action
- **What it does:** Generates compliant branch names, commit messages, and PR bodies
- **Enforces:** Conventional commit format, branch naming rules, PR template compliance

### `hephaestus-build-agent`
- **Path:** `.github/skills/hephaestus-build-agent/`
- **Used by:** `hephaestus`
- **What it does:** Scaffolds new agent bundles from `AGENT.base.tpl.md`
- **Validates through:** `apollo-supervise-agent`

### `hephaestus-build-skill`
- **Path:** `.github/skills/hephaestus-build-skill/`
- **Used by:** `hephaestus`
- **What it does:** Scaffolds new skill bundles from `SKILL.base.tpl.md` and `SKILL.block-catalog.md`
- **Validates through:** `apollo-supervise-skill`

### `apollo-supervise-agent`
- **Path:** `.github/skills/apollo-supervise-agent/`
- **Used by:** `hephaestus`, `apollo`
- **What it does:** Reviews agent bundles for compliance against the canonical scaffold

### `apollo-supervise-skill`
- **Path:** `.github/skills/apollo-supervise-skill/`
- **Used by:** `hephaestus`, `apollo`
- **What it does:** Reviews skill bundles for compliance against the canonical scaffold and block catalog

---

## Design System Skills

### `eleuthia-ui-components`
- **Path:** `.github/skills/eleuthia-ui-components/`
- **Used by:** `eleuthia`
- **What it contains:** Corporate UI component reference library including:
  - Header, footer, navigation components
  - Card, button, table, form components
  - Modal, dialog, notification components
  - Logo, icon, and typography assets

### `eleuthia-ui-mockups`
- **Path:** `.github/skills/eleuthia-ui-mockups/`
- **Used by:** `eleuthia`
- **What it contains:** Governed page layout patterns for common application views

### `eleuthia-ui-styles`
- **Path:** `.github/skills/eleuthia-ui-styles/`
- **Used by:** `eleuthia`
- **What it contains:** Utility CSS classes, design tokens, spacing, and color palette references

---

## Infrastructure Skills

### `eleuthia-py-frontend`
- **Path:** `.github/skills/eleuthia-py-frontend/`
- **Status:** Standalone (no agent currently routes to this skill)
- **What it does:** Adds a Python interactive frontend layer

### `hephaestus-net-cicd`
- **Path:** `.github/skills/hephaestus-net-cicd/`
- **Status:** Standalone
- **What it does:** Adds CI/CD pipeline configuration for .NET projects

### `poseidon-local-postgres`
- **Path:** `.github/skills/poseidon-local-postgres/`
- **Status:** Standalone
- **What it does:** Sets up local PostgreSQL via Docker Compose with init scripts and seed data

## Standalone Skills

The following skills are intentionally standalone or loosely routed. They are still governed, but they do not currently sit behind the same routing patterns as the core profile families:

- `eleuthia-py-frontend`
- `hephaestus-net-cicd`
- `poseidon-local-postgres`
