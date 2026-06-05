# Python Pytest Layer Skill Checklist

Quality and determinism checklist for `eleuthia-py-pytest` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/eleuthia-py-pytest.tpl.md`
  - `./assets/eleuthia-py-pytest.checklist.md`
  - `./scripts/eleuthia-py-pytest.requirements.tpl.md`
  - `./scripts/eleuthia-py-pytest.pytest.ini.tpl.md`
  - `./scripts/eleuthia-py-pytest.tests-readme.tpl.md`
  - `./scripts/eleuthia-py-pytest.conftest.py.tpl.md`
  - `./scripts/eleuthia-py-pytest.test-example-template.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-pytest.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-pytest.checklist.md`
- [ ] `SKILL.md` explicitly references `./scripts/eleuthia-py-pytest.requirements.tpl.md`
- [ ] `SKILL.md` explicitly references every owned support bundle under `./scripts/`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `eleuthia-py-pytest`
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
- [ ] `./assets/eleuthia-py-pytest.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] The allowed scope is limited to starter-specific dependency content, `pytest.ini`, `tests/`, and unresolved inputs
- [ ] `tests/conftest.py` owns only import-path bootstrap and generic shared fixtures that are safe across Python projects
- [ ] Starter example files remain clearly non-domain-specific and do not require live infrastructure
- [ ] The owned dependency block remains limited to the generic pytest starter package set
- [ ] The governed project-root layout is preserved
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Code Bundle Coverage
- [ ] `./scripts/eleuthia-py-pytest.requirements.tpl.md` contains the exact starter-specific dependency block required by the layer
- [ ] `./scripts/eleuthia-py-pytest.pytest.ini.tpl.md` contains the exact pytest configuration required by the layer
- [ ] `./scripts/eleuthia-py-pytest.tests-readme.tpl.md` contains the exact operator guidance required by the layer
- [ ] `./scripts/eleuthia-py-pytest.conftest.py.tpl.md` contains the exact test bootstrap fixture required by the layer
- [ ] `./scripts/eleuthia-py-pytest.test-example-template.py.tpl.md` contains the exact example-only starter test required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] Starter dependency guidance, pytest configuration, bootstrap behavior, and starter example coverage remain authoritative for the owned files

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct unrelated environment, connector, logger, CI/CD, business-code, or dependency-manifest modification beyond the starter-owned block during normal layer execution
- [ ] The skill does not ship concrete domain routes, controller names, response schemas, or infrastructure mocks in starter bundles
- [ ] Validation runs against `eleuthia-py-pytest.checklist.md` together with `SKILL.md`, `eleuthia-py-pytest.tpl.md`, and every owned support bundle under `./scripts/`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state