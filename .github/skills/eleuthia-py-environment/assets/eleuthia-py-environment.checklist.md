# Python Environment Layer Skill Checklist

Quality and determinism checklist for `eleuthia-py-environment` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/eleuthia-py-environment.tpl.md`
  - `./assets/eleuthia-py-environment.checklist.md`
  - `./scripts/eleuthia-py-environment.requirements.tpl.md`
  - `./scripts/eleuthia-py-environment.env-config.py.tpl.md`
  - `./scripts/eleuthia-py-environment.env-registry.py.tpl.md`
  - `./scripts/eleuthia-py-environment.example-env.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-environment.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-environment.checklist.md`
- [ ] `SKILL.md` explicitly references `./scripts/eleuthia-py-environment.requirements.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/eleuthia-py-environment.env-config.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/eleuthia-py-environment.env-registry.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/eleuthia-py-environment.example-env.tpl.md`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `eleuthia-py-environment`
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
- [ ] `./assets/eleuthia-py-environment.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] `environment/` owns env loading, env-key registration, and env-related error handling only
- [ ] The owned dependency block remains limited to `python-dotenv`
- [ ] The owned example-env content remains limited to `ENV`
- [ ] The allowed scope is limited to `environment/`, environment-specific dependency content, environment-specific example-env content, and unresolved inputs
- [ ] The governed project-root layout is preserved
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Code Bundle Coverage
- [ ] `./scripts/eleuthia-py-environment.requirements.tpl.md` contains the exact environment-specific dependency block required by the layer
- [ ] `./scripts/eleuthia-py-environment.env-config.py.tpl.md` contains the exact environment config code required by the layer
- [ ] `./scripts/eleuthia-py-environment.env-registry.py.tpl.md` contains the exact env-key registry code required by the layer
- [ ] `./scripts/eleuthia-py-environment.example-env.tpl.md` contains the exact environment-specific example-env content required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] Environment dependency guidance remains authoritative for the environment-owned manifest block
- [ ] Environment config code remains authoritative for `environment/env_config.py` and `environment/env_var_errors.py`
- [ ] Env-key registry code remains authoritative for `environment/env_vars_mapper.py`
- [ ] Environment-specific example-env content remains authoritative for the environment bootstrap block

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct unrelated logger, connector, API, business-code, or CI/CD modification during normal layer execution
- [ ] Validation runs against `eleuthia-py-environment.checklist.md` together with `SKILL.md`, `eleuthia-py-environment.tpl.md`, and every owned support bundle under `./scripts/`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state