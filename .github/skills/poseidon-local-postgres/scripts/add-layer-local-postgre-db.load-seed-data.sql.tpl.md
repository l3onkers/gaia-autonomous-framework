# Local PostgreSQL Seed Load Bundle

Status: Active

Use this owned asset when a workflow must add the starter seed-load SQL required by the governed local PostgreSQL simulation layer.

## File: `docker/.init_db/2_load_seed_data.sql`
```sql
COPY sample_schema.sample_table
FROM '/docker-entrypoint-initdb.d/data/sample_table.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER TRUE,
    ENCODING 'UTF8'
);
```