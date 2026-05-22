# Local PostgreSQL Schema Init Bundle

Status: Active

Use this owned asset when a workflow must add the schema bootstrap SQL required by the governed local PostgreSQL simulation layer.

## File: `docker/.init_db/0_create_schema.sql`
```sql
CREATE SCHEMA IF NOT EXISTS "sample_schema";
```