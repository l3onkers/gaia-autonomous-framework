# Python FastAPI Pytest Extension Checklist

Quality and determinism checklist for `add-layer-py-pytest-fastapi` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/add-layer-py-pytest-fastapi.tpl.md`
  - `./assets/add-layer-py-pytest-fastapi.checklist.md`
  - `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md`
  - `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md`
  - `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-py-pytest-fastapi.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-py-pytest-fastapi.checklist.md`
- [ ] `SKILL.md` explicitly references every owned support bundle under `./scripts/`
- [ ] `SKILL.md` explicitly references `.github/skills/add-layer-py-pytest/SKILL.md`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `add-layer-py-pytest-fastapi`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, all support companions, and the delegated starter explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Layer Scope and Separation of Responsibilities
- [ ] `./assets/add-layer-py-pytest-fastapi.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] The allowed scope is limited to FastAPI-specific dependency content, `tests/api/`, and unresolved inputs
- [ ] The delegated pytest starter is applied before the FastAPI-specific bundles
- [ ] `tests/api/conftest.py` owns only the FastAPI-specific example app fixture and client fixture for this extension layer
- [ ] Example files remain generic and do not import project-specific business code by default
- [ ] Starter-owned files remain outside this skill's direct ownership
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Code Bundle Coverage
- [ ] `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md` contains the exact FastAPI-specific dependency block required by the layer
- [ ] `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md` contains the exact FastAPI fixture implementation required by the layer
- [ ] `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md` contains the exact self-contained HTTP example required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] FastAPI dependency guidance, fixture behavior, and HTTP example coverage remain authoritative for the owned files

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct unrelated environment, connector, logger, CI/CD, business-code, dependency-manifest modification beyond the FastAPI extension-owned block, or starter-owned file modification during normal extension execution
- [ ] The skill does not ship business-specific routes, response schemas, controller imports, or infrastructure mocks in the FastAPI extension bundles
- [ ] Validation runs against `add-layer-py-pytest-fastapi.checklist.md` together with `SKILL.md`, `add-layer-py-pytest-fastapi.tpl.md`, every owned support bundle under `./scripts/`, and `.github/skills/add-layer-py-pytest/SKILL.md`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state