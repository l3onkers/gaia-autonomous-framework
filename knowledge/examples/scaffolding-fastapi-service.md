# Few-Shot Example: Scaffolding a Governed FastAPI Service

**Agent:** ELEUTHIA  
**Skills Resolved:** `eleuthia-py-api`, `eleuthia-py-environment`, `eleuthia-py-logger`

## Scenario
The user requests a modular Python microservice with environment validation and structured logging.

## Execution Pattern
1. **Pre-flight Check:** Verify existing files to prevent overwriting business code.
2. **Environment Layer:** Generate `environment/env_config.py` with typed variables and validation.
3. **Logger Layer:** Generate `logger/observability_logger/system_logger.py` for structured JSON output.
4. **API Runtime:** Scaffold FastAPI `src/main.py` with health checks, routers, and CORS middleware.
5. **Dependency Manifest:** Emit minimal `requirements.txt` with locked major versions:
   ```text
   fastapi>=0.110.0,<1.0.0
   uvicorn[standard]>=0.28.0,<1.0.0
   pydantic-settings>=2.2.0,<3.0.0
   ```
6. **Validation:** Ensure zero placeholder comments (`TODO`, `WIP`).
