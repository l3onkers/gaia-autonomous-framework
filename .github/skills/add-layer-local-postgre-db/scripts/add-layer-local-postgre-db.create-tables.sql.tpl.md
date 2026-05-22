# Local PostgreSQL Table Init Bundle

Status: Active

Use this owned asset when a workflow must add the starter table-definition SQL required by the governed local PostgreSQL simulation layer.

## File: `docker/.init_db/1_create_tables.sql`
```sql
CREATE TABLE sample_schema.sample_table (
    col_1 INTEGER,
    col_2 VARCHAR(50) NOT NULL
);
```