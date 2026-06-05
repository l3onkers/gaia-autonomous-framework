# Local PostgreSQL Docker Compose Bundle

Status: Active

Use this owned asset when a workflow must add the Docker Compose file required by the governed local PostgreSQL simulation layer.

## File: `docker/docker-compose.yml`
```yaml
services:
  db:
    image: postgres:17.0
    ports:
      - '5440:5432'
    container_name: sample_postgres_container
    environment:
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=pwd
      - POSTGRES_DB=sample_db
    volumes:
      - 'POSTGRES:/var/lib/postgresql/data'
      - './data:/docker-entrypoint-initdb.d/data'
      - './.init_db/0_create_schema.sql:/docker-entrypoint-initdb.d/00_create_schema.sql'
      - './.init_db/1_create_tables.sql:/docker-entrypoint-initdb.d/01_create_tables.sql'
      - './.init_db/2_load_seed_data.sql:/docker-entrypoint-initdb.d/02_load_seed_data.sql'

volumes:
  POSTGRES:
```