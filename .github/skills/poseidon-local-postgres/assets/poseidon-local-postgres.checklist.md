# Local PostgreSQL Docker Compose Layer Skill Checklist

Quality and determinism checklist for `poseidon-local-postgres` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/poseidon-local-postgres.tpl.md`
  - `./assets/poseidon-local-postgres.checklist.md`
  - `./scripts/poseidon-local-postgres.docker-readme.tpl.md`
  - `./scripts/poseidon-local-postgres.compose.yml.tpl.md`
  - `./scripts/poseidon-local-postgres.create-schema.sql.tpl.md`
  - `./scripts/poseidon-local-postgres.create-tables.sql.tpl.md`
  - `./scripts/poseidon-local-postgres.load-seed-data.sql.tpl.md`
  - `./scripts/poseidon-local-postgres.sample-data.csv.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/poseidon-local-postgres.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/poseidon-local-postgres.checklist.md`
- [ ] `SKILL.md` explicitly references every owned support bundle under `./scripts/`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `poseidon-local-postgres`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, and all support bundles explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Layer Scope and Separation of Responsibilities
- [ ] `./assets/poseidon-local-postgres.tpl.md` is loaded before the owned support bundles in `./scripts/`
- [ ] The skill remains self-contained and does not depend on `PY-Template/` at execution time
- [ ] The allowed scope is limited to local PostgreSQL Docker Compose assets under `docker/` and unresolved inputs
- [ ] The skill preserves `docker/.init_db/` as the ordered initialization flow and `docker/data/` as the seed-data location
- [ ] The skill excludes MinIO, API runtime containers, Dockerfiles, environment files, and unrelated scaffolding from normal execution
- [ ] Script-like owned bundles live under `./scripts/`, not under `./assets/`

---

## D. Exact Bundle Coverage
- [ ] `./scripts/poseidon-local-postgres.docker-readme.tpl.md` contains the exact operator guidance required by the layer
- [ ] `./scripts/poseidon-local-postgres.compose.yml.tpl.md` contains the exact Docker Compose wiring required by the layer
- [ ] `./scripts/poseidon-local-postgres.create-schema.sql.tpl.md` contains the exact schema bootstrap required by the layer
- [ ] `./scripts/poseidon-local-postgres.create-tables.sql.tpl.md` contains the exact starter table-definition bundle required by the layer
- [ ] `./scripts/poseidon-local-postgres.load-seed-data.sql.tpl.md` contains the exact starter seed-load bundle required by the layer
- [ ] `./scripts/poseidon-local-postgres.sample-data.csv.tpl.md` contains the exact neutral starter CSV seed file required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or bounded table-and-seed-data adaptation behavior
- [ ] Docker Compose wiring, init SQL ordering, and neutral starter seed data remain authoritative for the owned files

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist beyond clearly local starter placeholders
- [ ] The skill does not instruct unrelated Docker services, production DB setup, ORMs, migrations, CI/CD, or business-code modification during normal layer execution
- [ ] Validation runs against `poseidon-local-postgres.checklist.md` together with `SKILL.md`, `poseidon-local-postgres.tpl.md`, and every owned support bundle under `./scripts/`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state