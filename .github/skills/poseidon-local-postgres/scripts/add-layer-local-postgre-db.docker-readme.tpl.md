# Local PostgreSQL Docker README Bundle

Status: Active

Use this owned asset when a workflow must add the operator guidance required by the governed local PostgreSQL simulation layer.

## File: `docker/README.md`
```md
# docker/

Local development PostgreSQL containers and seed-data bootstrap files.

## PostgreSQL

- Compose file: `docker-compose.yml`
- Host port mapping: `5440:5432`
- Init scripts: mounted from `docker/.init_db/` and executed in lexicographic order.
- Seed data directory: mounted from `docker/data/` and made available inside the container at `/docker-entrypoint-initdb.d/data`.

Start:

- `docker compose -f docker/docker-compose.yml up -d`

Customization guidance:

1. Adjust `docker/.init_db/1_create_tables.sql` with the tables required by the project.
2. Add or replace CSV files under `docker/data/` with the initial rows required by the project.
3. Update `docker/.init_db/2_load_seed_data.sql` so each seeded table loads the matching CSV file from `/docker-entrypoint-initdb.d/data/`.
4. Keep file numbering under `docker/.init_db/` ordered so schema creation runs before table creation and data loading.
```