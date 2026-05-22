# Python Logger Layer Skill Checklist

Quality and determinism checklist for `add-layer-py-logger` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/add-layer-py-logger.tpl.md`
  - `./assets/add-layer-py-logger.checklist.md`
  - `./scripts/add-layer-py-logger.logger.py.tpl.md`
  - `./scripts/add-layer-py-logger.example-env.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-py-logger.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-py-logger.checklist.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-logger.logger.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-logger.example-env.tpl.md`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `add-layer-py-logger`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, and all support and code-bundle companions explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Layer Scope and Separation of Responsibilities
- [ ] `./assets/add-layer-py-logger.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] `logger/` owns logging behavior only and does not import `environment/env_config.py` or `environment/env_vars_mapper.py`
- [ ] Logger layer remains stdlib-only and does not require dependency-manifest updates during normal execution
- [ ] The owned example-env content remains limited to `SRV_LOG_STORAGE` and `SRV_BOUNDED_CTX`
- [ ] The allowed scope is limited to `logger/`, logger-specific example-env content, and unresolved inputs
- [ ] The governed project-root layout is preserved
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Code Bundle Coverage
- [ ] `./scripts/add-layer-py-logger.logger.py.tpl.md` contains the exact logger code required by the layer
- [ ] `./scripts/add-layer-py-logger.example-env.tpl.md` contains the exact logger-specific example-env content required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] Logger code remains authoritative for `logger/`
- [ ] Logger-specific example-env content remains authoritative for the logging env block

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct unrelated environment, connector, API, business-code, CI/CD, or dependency-manifest modification during normal layer execution
- [ ] Validation runs against `add-layer-py-logger.checklist.md` together with `SKILL.md`, `add-layer-py-logger.tpl.md`, and every owned support bundle under `./scripts/`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state