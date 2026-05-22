# Skills Catalog

> Detailed documentation for all 33 governed skills in the Copilot Governance Framework.

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

These skills are routed by the `net-build` agent. Each defines a complete .NET project scaffold.

#### `net-setup-api`
- **Path:** `.github/skills/net-setup-api/`
- **Profile:** Standard REST API
- **What it generates:** Clean Architecture .NET 8+ API with controllers, services, dependency injection, health checks, and Swagger
- **Key assets:** `net-setup-api.tpl.md`

#### `net-setup-api-cqrs`
- **Path:** `.github/skills/net-setup-api-cqrs/`
- **Profile:** CQRS API
- **What it generates:** Command/Query separation with MediatR, domain events, and request validation
- **Key assets:** `net-setup-api-cqrs.tpl.md`

#### `net-setup-api-modular`
- **Path:** `.github/skills/net-setup-api-modular/`
- **Profile:** Modular Monolith
- **What it generates:** Feature-based module structure with explicit module boundaries
- **Key assets:** `net-setup-api-modular.tpl.md`



#### `net-setup-worker`
- **Path:** `.github/skills/net-setup-worker/`
- **Profile:** Background Worker
- **What it generates:** .NET Worker Service with health checks, configuration, and Docker support
- **Key assets:** `net-setup-worker.tpl.md`

#### `net-setup-job`
- **Path:** `.github/skills/net-setup-job/`
- **Profile:** Scheduled Job
- **What it generates:** Hosted service with scheduled execution patterns
- **Key assets:** `net-setup-job.tpl.md`

---

### Angular Profile Skill

#### `ng-setup-spa`
- **Path:** `.github/skills/ng-setup-spa/`
- **Used by:** `ng-build`
- **What it generates:** Angular 21+ SPA with:
  - Governed header wrapper component
  - Optional SSO login wrapper with token management
  - Corporate design system integration
  - HTTP interceptors (error handling, API key, session, token)
  - Environment configuration with file replacement
- **Key assets:**
  - `ng-setup-spa.tpl.md` — SPA profile rules and structure
  - `ng-setup-spa.login.tpl.md` — SSO login generation template
  - `ng-setup-spa.checklist.md` — Validation checklist

---

### Python Layer Skills

These skills are routed by the `py-build` agent and execute in dependency order.

#### `add-layer-py-environment`
- **Path:** `.github/skills/add-layer-py-environment/`
- **Layer:** `environment`
- **Prerequisites:** None (base layer)
- **What it generates:** Python project foundation with:
  - Environment variable management
  - Secret key detection and masking
  - Configuration loading from `.env` files
  - Structured settings classes

#### `add-layer-py-api`
- **Path:** `.github/skills/add-layer-py-api/`
- **Layer:** `api`
- **Prerequisites:** `environment`
- **What it generates:** FastAPI application scaffold with:
  - Route definitions and request/response models
  - Middleware configuration
  - Health check endpoints
  - CORS configuration

#### `add-layer-py-logger`
- **Path:** `.github/skills/add-layer-py-logger/`
- **Layer:** `logger`
- **Prerequisites:** `environment`
- **What it generates:** Structured logging setup with configurable handlers and formatters

#### `add-layer-py-connectors`
- **Path:** `.github/skills/add-layer-py-connectors/`
- **Layer:** `connectors`
- **Prerequisites:** `environment`
- **What it generates:** Database and SFTP connector modules with:
  - SQL Server, PostgreSQL, and MySQL adapters
  - SFTP client with retry logic
  - Connection pooling and credential management

#### `add-layer-py-pytest`
- **Path:** `.github/skills/add-layer-py-pytest/`
- **Layer:** `pytest`
- **Prerequisites:** `environment`
- **What it generates:** Test suite with pytest configuration, fixtures, and coverage settings

#### `add-layer-py-pytest-fastapi`
- **Path:** `.github/skills/add-layer-py-pytest-fastapi/`
- **Layer:** `pytest-fastapi`
- **Prerequisites:** `environment`, `api`, `pytest`
- **What it generates:** FastAPI-specific test harness with TestClient, async fixtures, and API endpoint tests

#### `add-layer-py-cicd`
- **Path:** `.github/skills/add-layer-py-cicd/`
- **Layer:** `cicd`
- **Prerequisites:** `environment`, `api`
- **What it generates:** CI/CD pipeline configuration for Python applications

---

## Security Skills

### `security-review`
- **Path:** `.github/skills/security-review/`
- **Used by:** `security`
- **What it does:** Performs code-level vulnerability analysis on specified files or PR-scoped changes
- **Output:** `SECURITY_REVIEW.md` or PR review comments

### `security-triage`
- **Path:** `.github/skills/security-triage/`
- **Used by:** `security`
- **What it does:** Prioritizes and groups security evidence by severity
- **Output:** `SECURITY_TRIAGE.md`

### `security-patch`
- **Path:** `.github/skills/security-patch/`
- **Used by:** `security`
- **What it does:** Generates minimal, governed fix proposals with an explicit approval gate
- **Output:** `SECURITY_PATCH.md` with Apply / Reject / Modify options
- **Important:** Patches are never applied automatically — human approval is always required

### `pr-security-review`
- **Path:** `.github/skills/pr-security-review/`
- **Used by:** `security`
- **What it does:** Reviews security-relevant changes in pull requests
- **Output:** PR review comments with security findings

### `commit-secret-scan`
- **Path:** `.github/skills/commit-secret-scan/`
- **Used by:** `security`
- **What it does:** Detects secrets (API keys, tokens, passwords) in pushed commits
- **Detection patterns:** AWS, GCP, cloud provider keys, GitHub tokens, Stripe keys, and more

### `dependency-security-check`
- **Path:** `.github/skills/dependency-security-check/`
- **Used by:** `security`
- **What it does:** Reviews dependency manifest changes for known vulnerabilities
- **Output:** Dependency security findings in PR comment format

---

## Documentation & Governance Skills

### `create-or-update-readme`
- **Path:** `.github/skills/create-or-update-readme/`
- **Used by:** `documentator`
- **What it does:** Generates or refreshes README.md using bundled template assets
- **Templates:**
  - `README.generic.tpl.md` — General-purpose fallback
  - `README.agents.tpl.md` — Specialized for agent-based repositories

### `markdown-converter`
- **Path:** `.github/skills/markdown-converter/`
- **Used by:** `documentator` or direct invocation
- **What it does:** Converts Markdown to HTML, PDF, DOCX, TeX, or EPUB via Pandoc
- **Includes:** Governed HTML template with head injection and logo assets

### `git-workflow`
- **Path:** `.github/skills/git-workflow/`
- **Used by:** Any repository git action
- **What it does:** Generates compliant branch names, commit messages, and PR bodies
- **Enforces:** Conventional commit format, branch naming rules, PR template compliance

### `build-agent`
- **Path:** `.github/skills/build-agent/`
- **Used by:** `build`
- **What it does:** Scaffolds new agent bundles from `AGENT.base.tpl.md`
- **Validates through:** `supervise-agent`

### `build-skill`
- **Path:** `.github/skills/build-skill/`
- **Used by:** `build`
- **What it does:** Scaffolds new skill bundles from `SKILL.base.tpl.md` and `SKILL.block-catalog.md`
- **Validates through:** `supervise-skill`

### `supervise-agent`
- **Path:** `.github/skills/supervise-agent/`
- **Used by:** `build`, `supervisor`
- **What it does:** Reviews agent bundles for compliance against the canonical scaffold

### `supervise-skill`
- **Path:** `.github/skills/supervise-skill/`
- **Used by:** `build`, `supervisor`
- **What it does:** Reviews skill bundles for compliance against the canonical scaffold and block catalog

---

## Design System Skills

### `components-catalog`
- **Path:** `.github/skills/components-catalog/`
- **Used by:** `ng-build`
- **What it contains:** Corporate UI component reference library including:
  - Header, footer, navigation components
  - Card, button, table, form components
  - Modal, dialog, notification components
  - Logo, icon, and typography assets

### `mockup-layouts`
- **Path:** `.github/skills/mockup-layouts/`
- **Used by:** `ng-build`
- **What it contains:** Governed page layout patterns for common application views

### `global-styles`
- **Path:** `.github/skills/global-styles/`
- **Used by:** `ng-build`
- **What it contains:** Utility CSS classes, design tokens, spacing, and color palette references

---

## Infrastructure Skills

### `add-layer-py-frontend`
- **Path:** `.github/skills/add-layer-py-frontend/`
- **Status:** Standalone (no agent currently routes to this skill)
- **What it does:** Adds a Python interactive frontend layer

### `add-layer-net-cicd`
- **Path:** `.github/skills/add-layer-net-cicd/`
- **Status:** Standalone
- **What it does:** Adds CI/CD pipeline configuration for .NET projects

### `add-layer-local-postgre-db`
- **Path:** `.github/skills/add-layer-local-postgre-db/`
- **Status:** Standalone
- **What it does:** Sets up local PostgreSQL via Docker Compose with init scripts and seed data
