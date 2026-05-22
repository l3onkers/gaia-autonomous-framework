---
name: add-layer-local-postgre-db
description: 'Use when: a setup or orchestration workflow must add a governed local PostgreSQL Docker Compose layer with ordered init scripts and starter seed data.'
user-invocable: false
---

# Add Layer Local Postgre Db Skill

## Purpose
- This skill owns governed local PostgreSQL simulation-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable Docker Compose-backed PostgreSQL instance for local development or testing.
- This skill stays within the PostgreSQL simulation-layer scope: `docker/README.md`, `docker/docker-compose.yml`, `docker/.init_db/`, and `docker/data/`.

## Output Contract
- One local PostgreSQL simulation-layer result.
- The owned shared template asset `./assets/add-layer-local-postgre-db.tpl.md`
- The owned checklist asset `./assets/add-layer-local-postgre-db.checklist.md`
- The owned docker README bundle `./scripts/add-layer-local-postgre-db.docker-readme.tpl.md`
- The owned Docker Compose bundle `./scripts/add-layer-local-postgre-db.compose.yml.tpl.md`
- The owned schema-init SQL bundle `./scripts/add-layer-local-postgre-db.create-schema.sql.tpl.md`
- The owned table-init SQL bundle `./scripts/add-layer-local-postgre-db.create-tables.sql.tpl.md`
- The owned seed-load SQL bundle `./scripts/add-layer-local-postgre-db.load-seed-data.sql.tpl.md`
- The owned sample CSV bundle `./scripts/add-layer-local-postgre-db.sample-data.csv.tpl.md`

If the request is not a local PostgreSQL Docker Compose layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/add-layer-local-postgre-db.tpl.md`
  - `./assets/add-layer-local-postgre-db.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/add-layer-local-postgre-db.docker-readme.tpl.md`
  - `./scripts/add-layer-local-postgre-db.compose.yml.tpl.md`
  - `./scripts/add-layer-local-postgre-db.create-schema.sql.tpl.md`
  - `./scripts/add-layer-local-postgre-db.create-tables.sql.tpl.md`
  - `./scripts/add-layer-local-postgre-db.load-seed-data.sql.tpl.md`
  - `./scripts/add-layer-local-postgre-db.sample-data.csv.tpl.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller or workflow must add or restore a local PostgreSQL simulation layer backed by Docker Compose.
- The run needs the current repository structure preserved under `docker/`, with ordered init scripts in `docker/.init_db/` and starter seed data in `docker/data/`.
- Supported inputs include vendoring the governed PostgreSQL simulation layer into an existing project, re-adding deleted local DB scaffolding, and explicit rename requests for schema names, table names, CSV file names, service names, container names, host ports, database names, or credentials after the exact bundles are applied.
- The run must let the user define the tables to create and the initial data to load while preserving the governed folder layout and ordered initialization flow.
- The run must preserve clear separation between the local PostgreSQL simulation layer and out-of-scope assets such as MinIO containers, API runtime compose files, Dockerfiles, or production deployment configuration.

## Procedure
1. Confirm the request is a local PostgreSQL Docker Compose layer request.
2. Load `./assets/add-layer-local-postgre-db.tpl.md`, `./assets/add-layer-local-postgre-db.checklist.md`, and every owned support bundle under `./scripts/`.
3. Collect only the minimum required inputs, such as target app root, `docker/` destination when the target path is ambiguous, whether existing PostgreSQL simulation files should be replaced, merged, or skipped, and any explicit rename or bounded adaptation requests for schema names, table definitions, CSV file names, service names, container names, host ports, database names, or bootstrap credentials.
4. Apply the shared rules from `./assets/add-layer-local-postgre-db.tpl.md` before the exact code bundles.
5. Materialize the exact file contents from `./scripts/add-layer-local-postgre-db.docker-readme.tpl.md`, `./scripts/add-layer-local-postgre-db.compose.yml.tpl.md`, `./scripts/add-layer-local-postgre-db.create-schema.sql.tpl.md`, `./scripts/add-layer-local-postgre-db.create-tables.sql.tpl.md`, `./scripts/add-layer-local-postgre-db.load-seed-data.sql.tpl.md`, and `./scripts/add-layer-local-postgre-db.sample-data.csv.tpl.md` into the target app while preserving the governed relative paths.
6. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned Docker, SQL, and CSV bundles verbatim.
7. When the user provides bounded table definitions or initial data requirements, adapt `docker/.init_db/1_create_tables.sql`, `docker/.init_db/2_load_seed_data.sql`, and the matching files under `docker/data/` without changing the governed directory structure or init-order convention.
8. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
9. Validate the result against `./assets/add-layer-local-postgre-db.checklist.md`, the shared template, every support bundle under `./scripts/`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the layer remains limited to local PostgreSQL simulation assets under `docker/`.
- Validate that shared layer rules remain attributable to `./assets/add-layer-local-postgre-db.tpl.md`.
- Validate that operator guidance remains attributable to `./scripts/add-layer-local-postgre-db.docker-readme.tpl.md`.
- Validate that Docker Compose behavior remains attributable to `./scripts/add-layer-local-postgre-db.compose.yml.tpl.md`.
- Validate that schema bootstrap behavior remains attributable to `./scripts/add-layer-local-postgre-db.create-schema.sql.tpl.md`.
- Validate that table-definition bootstrap behavior remains attributable to `./scripts/add-layer-local-postgre-db.create-tables.sql.tpl.md`.
- Validate that seed-load bootstrap behavior remains attributable to `./scripts/add-layer-local-postgre-db.load-seed-data.sql.tpl.md`.
- Validate that starter seed data remains attributable to `./scripts/add-layer-local-postgre-db.sample-data.csv.tpl.md`.
- Validate that the result emits only the files, PostgreSQL simulation guidance, and unresolved inputs allowed by the owned assets and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/add-layer-local-postgre-db.tpl.md`.
  3. `./assets/add-layer-local-postgre-db.checklist.md`.
  4. `./scripts/add-layer-local-postgre-db.docker-readme.tpl.md`.
  5. `./scripts/add-layer-local-postgre-db.compose.yml.tpl.md`.
  6. `./scripts/add-layer-local-postgre-db.create-schema.sql.tpl.md`.
  7. `./scripts/add-layer-local-postgre-db.create-tables.sql.tpl.md`.
  8. `./scripts/add-layer-local-postgre-db.load-seed-data.sql.tpl.md`.
  9. `./scripts/add-layer-local-postgre-db.sample-data.csv.tpl.md`.
  10. Existing repository evidence for the target project's `docker/` layout.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `docker/` destination detection, and application of explicit rename requests or bounded table-and-seed-data adaptations after the exact bundles are placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/add-layer-local-postgre-db.tpl.md` and `./assets/add-layer-local-postgre-db.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/` before artifact generation begins.
- Apply the shared template before the owned Docker, SQL, and CSV bundles.
- Keep the governed structure rooted at `docker/` with `.init_db/` for ordered initialization scripts and `data/` for starter seed files.
- Keep the exact file contents from the owned bundles before applying any explicit user-requested rename, merge, or bounded table-and-seed-data adaptation.
- Keep the default owned bundles generic and non-domain-specific by shipping only one neutral sample table scaffold and one matching seed file.
- Keep the Docker Compose bundle limited to one local PostgreSQL service and its persisted volume unless the user explicitly requests a bounded change.
- For identical repository state and user inputs, the resulting PostgreSQL simulation-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/add-layer-local-postgre-db.checklist.md` together with this skill, `./assets/add-layer-local-postgre-db.tpl.md`, and every owned support bundle under `./scripts/` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate MinIO services, API runtime compose files, Dockerfiles, application containers, environment files, connectors, or CI/CD artifacts as part of normal PostgreSQL simulation-layer execution.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not collapse the governed structure into another top-level folder or remove the ordered `.init_db/` convention.
- Do not widen the Compose bundle beyond the local PostgreSQL service, its persisted volume, and the SQL and CSV mounts required by the starter flow unless the user explicitly requests a bounded change.
- Do not invent production-grade migration strategy, ORMs, backup automation, or non-PostgreSQL services unless the user explicitly requests a bounded extension.
- Do not silently rewrite schema names, table names, CSV mappings, or credentials without an explicit request.
- Do not introduce secrets or credentials into tracked files beyond the clearly local starter placeholders owned by the bundle.
- Do not treat the owned template assets as standalone callable skills or agents.