# Local PostgreSQL Docker Compose Layer Template

Bundle: `poseidon-local-postgres`
Status: Active

## 1. Objective

Provide the shared governance applied before the isolated support bundles in `./scripts/` and the governed validation assets in `./assets/` for a reusable local PostgreSQL simulation layer.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the PostgreSQL simulation layer must be created or updated.
2. `docker/` destination when the target path does not make it obvious where the owned Docker assets should be placed.
3. Whether existing Docker, SQL, or data files should be replaced, merged, or skipped when exact owned files conflict with local files.
4. Any explicit rename requests for service name, container name, host port, schema name, table names, CSV file names, database name, username, or password that must be applied after the exact bundles are placed.
5. Any explicit bounded table-definition or initial-data requirements that must be applied inside the governed `docker/.init_db/` and `docker/data/` structure.

## 3. Deliverables

When governed local PostgreSQL simulation-layer generation is requested, the shared template MUST allow only:
- `docker/README.md`
- `docker/docker-compose.yml`
- `docker/.init_db/`
- `docker/data/`
- Short list of unresolved variables or inputs still needed from the user

Do not generate MinIO, API compose files, Dockerfiles, runtime application containers, or unrelated scaffolding unless the user explicitly requests them.

## 4. Shared Layer Contract

The generated PostgreSQL simulation layer MUST preserve exactly the Docker folder layout defined by the owned code bundles.

Mandatory characteristics:
- `docker/docker-compose.yml` owns exactly one local PostgreSQL service, one persisted volume, and the init-script plus seed-data mounts required by the starter flow.
- `docker/.init_db/0_create_schema.sql` owns the schema bootstrap step.
- `docker/.init_db/1_create_tables.sql` owns the starter table-definition scaffold and is the primary bounded-edit location for explicit user-requested table creation.
- `docker/.init_db/2_load_seed_data.sql` owns the starter seed-load scaffold and is the primary bounded-edit location for explicit user-requested initial data loads.
- `docker/data/` owns the starter CSV seed files referenced by the seed-load script.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply explicit user-requested renames or bounded table-and-seed-data edits only after the exact file bundle is in place.
- Keep the governed folder layout unchanged unless the user explicitly requests a bounded rename or merge.
- Keep init execution deterministic by preserving numeric file ordering under `docker/.init_db/`.

## 5. Data Initialization Expectations

The owned Docker Compose bundle defines the authoritative local container wiring for this layer.
The owned SQL bundles define the authoritative schema, table bootstrap, and seed-load flow for this layer.
The owned CSV bundle defines the authoritative starter seed-data shape for the scaffold table.

Mandatory characteristics:
- Keep schema creation separated from table creation and data loading.
- Keep user-provided table definitions and initial data bounded to `docker/.init_db/` and `docker/data/` rather than scattering SQL across unrelated files.
- Keep CSV-driven seed loading readable and replaceable so downstream users can swap starter data without changing the folder layout.
- Keep the default starter output generic and non-domain-specific, with one neutral scaffold table and one matching CSV file.
- If the user wants more tables or additional CSVs, add them by extending the numbered init flow and matching files under `docker/data/` without introducing unrelated service containers.

## 6. Guardrails

- Do not reference `PY-Template/` during normal skill execution.
- Do not store script-like owned bundles under `./assets/`; keep them under `./scripts/`.
- Do not generate MinIO services, API runtime containers, application Dockerfiles, or production deployment configuration in this skill.
- Do not replace the ordered `.init_db/` layout with ad hoc inline SQL in the Compose file.
- Do not invent production migration tooling, ORM models, or business-specific database logic.
- Do not introduce secrets, credentials, or environment-specific sensitive values beyond the clearly local starter placeholders.

## 7. Output Format

## 1) Summary
- Selected target path
- PostgreSQL simulation-layer scope applied
- Docker destination

## 2) Files Created or Updated
- ...

## 3) PostgreSQL Surface Summary
```text
docker/README.md
docker/docker-compose.yml
docker/.init_db/0_create_schema.sql
docker/.init_db/1_create_tables.sql
docker/.init_db/2_load_seed_data.sql
docker/data/sample_table.csv
```

## 4) Startup Command
```text
docker compose -f docker/docker-compose.yml up -d
```

## 5) Required Inputs / Variables (if any)
- ...