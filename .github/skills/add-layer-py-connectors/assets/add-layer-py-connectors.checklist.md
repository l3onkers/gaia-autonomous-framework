# Python Connectors Layer Skill Checklist

Quality and determinism checklist for `add-layer-py-connectors` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/add-layer-py-connectors.tpl.md`
  - `./assets/add-layer-py-connectors.checklist.md`
  - `./scripts/add-layer-py-connectors.requirements.tpl.md`
  - `./scripts/add-layer-py-connectors.example-env.tpl.md`
  - `./scripts/add-layer-py-connectors.logging.py.tpl.md`
  - `./scripts/add-layer-py-connectors.database.py.tpl.md`
  - `./scripts/add-layer-py-connectors.sftp.py.tpl.md`
- [ ] Required delegated environment skill exists:
  - `.github/skills/add-layer-py-environment/SKILL.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-py-connectors.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-py-connectors.checklist.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-connectors.requirements.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-connectors.example-env.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-connectors.logging.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-connectors.database.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./scripts/add-layer-py-connectors.sftp.py.tpl.md`
- [ ] `SKILL.md` explicitly references `.github/skills/add-layer-py-environment/SKILL.md`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `add-layer-py-connectors`
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
- [ ] `./assets/add-layer-py-connectors.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] `.github/skills/add-layer-py-environment/SKILL.md` is loaded before the connectors-owned code bundles
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] Environment behavior is delegated to `.github/skills/add-layer-py-environment/SKILL.md`
- [ ] Logger compatibility behavior is owned by `./scripts/add-layer-py-connectors.logging.py.tpl.md`
- [ ] Dependency-manifest content and connectors-specific example-env content are sourced from dedicated owned support bundles
- [ ] The connectors-owned example-env asset excludes `ENV`
- [ ] The connectors-owned example-env asset excludes `SRV_LOG_STORAGE` and `SRV_BOUNDED_CTX`
- [ ] The connectors-owned dependency block excludes environment, pytest, FastAPI-extension, runtime-server, and object-storage packages
- [ ] The allowed scope is limited to delegated environment-layer application, connectors-owned logging compatibility, `connectors/database/`, `connectors/sftp/`, `connectors/utils/`, `src/config/db/`, `src/config/sftp/`, dependency-manifest updates, and connectors-specific example-env content
- [ ] The skill does not invent `src/config/s3` or object-storage behavior in this first layer
- [ ] The governed project-root layout is preserved
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Code Bundle Coverage
- [ ] `./scripts/add-layer-py-connectors.requirements.tpl.md` contains the exact dependency block required by the layer
- [ ] `./scripts/add-layer-py-connectors.example-env.tpl.md` contains the exact connectors-specific example-env content required by the layer
- [ ] `./scripts/add-layer-py-connectors.logging.py.tpl.md` contains the exact `AbstractSystemLogger` helper required by the layer
- [ ] `./scripts/add-layer-py-connectors.database.py.tpl.md` contains the exact database and `src/config/db` code required by the layer
- [ ] `./scripts/add-layer-py-connectors.sftp.py.tpl.md` contains the exact SFTP and `src/config/sftp` code required by the layer
- [ ] `.github/skills/add-layer-py-environment/SKILL.md` remains authoritative for `environment/` and the environment bootstrap example-env block
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] Connectors-specific dependency guidance remains authoritative for the connectors-owned `requirements.txt` block
- [ ] Connectors-owned example-env content remains authoritative for the connectors-specific env block
- [ ] Database code remains authoritative for runtime DB connector behavior and DB env-key-backed connection registries
- [ ] SFTP code remains authoritative for runtime SFTP connector behavior and SFTP env-key-backed connection registries

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct unrelated API, business-code, or CI/CD modification during normal layer execution
- [ ] Validation runs against `add-layer-py-connectors.checklist.md` together with `SKILL.md`, `add-layer-py-connectors.tpl.md`, every owned support bundle under `./scripts/`, and `.github/skills/add-layer-py-environment/SKILL.md`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state