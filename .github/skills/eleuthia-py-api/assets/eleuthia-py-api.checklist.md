# Python API Layer Skill Checklist

Quality and determinism checklist for `eleuthia-py-api` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/eleuthia-py-api.tpl.md`
  - `./assets/eleuthia-py-api.checklist.md`
  - `./scripts/eleuthia-py-api.requirements.tpl.md`
  - `./scripts/eleuthia-py-api.bootstrap.py.tpl.md`
  - `./scripts/eleuthia-py-api.src-readme.tpl.md`
  - `./scripts/eleuthia-py-api.routes.py.tpl.md`
  - `./scripts/eleuthia-py-api.controllers-readme.tpl.md`
  - `./scripts/eleuthia-py-api.example.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-api.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-api.checklist.md`
- [ ] `SKILL.md` explicitly references every owned support bundle under `./scripts/`
- [ ] `SKILL.md` explicitly references `.github/skills/eleuthia-py-environment/SKILL.md`
- [ ] `SKILL.md` explicitly references `.github/skills/eleuthia-py-logger/SKILL.md`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `eleuthia-py-api`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, all support companions, and the delegated layer skills explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Layer Scope and Separation of Responsibilities
- [ ] `./assets/eleuthia-py-api.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] The allowed scope is limited to delegated environment/logger application, `main.py`, the generic API shell under `src/`, API-specific dependency content, and unresolved inputs
- [ ] The delegated environment layer is applied before the runtime bundle that imports `environment.env_config`
- [ ] The delegated logger layer is applied before the bootstrap bundle and any owned code that imports `logger.SystemLogger`
- [ ] No default concrete route modules or controller implementations are forced into the base API layer
- [ ] The route-registration and controller-integration scaffolding remains generic and clearly replaceable
- [ ] `src/controllers/README.md` provides a reusable sample controller structure that downstream automation can adapt without guessing the orchestration pattern
- [ ] DB-backed sample endpoints and command-processing behavior remain out of scope for this base API layer
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Code Bundle Coverage
- [ ] `./scripts/eleuthia-py-api.requirements.tpl.md` contains the exact API runtime dependency block required by the layer
- [ ] `./scripts/eleuthia-py-api.bootstrap.py.tpl.md` contains the exact entrypoint and server-shell files required by the layer
- [ ] `./scripts/eleuthia-py-api.src-readme.tpl.md` contains the exact `src/README.md` guidance required by the layer
- [ ] `./scripts/eleuthia-py-api.routes.py.tpl.md` contains the exact route-registration scaffold required by the layer
- [ ] `./scripts/eleuthia-py-api.controllers-readme.tpl.md` contains the exact `src/controllers/README.md` guidance plus sample controller structure required by the layer
- [ ] `./scripts/eleuthia-py-api.example.py.tpl.md` contains the exact reusable response-builder support required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] API dependency guidance, runtime shell, route-registration scaffolding, controllers-readme guidance, and response-support guidance remain authoritative for the owned files

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct unrelated connectors, tests, command-processing layers, CI/CD, Docker, or business-code modification during normal API-layer execution
- [ ] The skill does not force default public, health, sample, or version endpoints/controllers during normal API-layer execution
- [ ] The skill does not duplicate environment or logger responsibilities already owned by delegated layer skills
- [ ] Validation runs against `eleuthia-py-api.checklist.md` together with `SKILL.md`, `eleuthia-py-api.tpl.md`, every owned support bundle under `./scripts/`, `.github/skills/eleuthia-py-environment/SKILL.md`, and `.github/skills/eleuthia-py-logger/SKILL.md`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state