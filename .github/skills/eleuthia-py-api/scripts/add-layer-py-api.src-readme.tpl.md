# Python API Source README Bundle

Status: Active

Use this owned asset when a workflow must add the source-layout guidance required by the governed Python API layer.

## File: `src/README.md`
```md
# src/

Application code for the generated API layer.

## Key areas

- `EngineApp.py`: FastAPI application assembly and router registration.
- `EngineServer.py`: runtime server wrapper.
- `routes/`: route registration and HTTP entrypoints.
- `controllers/`: request orchestration and validation handling.
- `services/`: reusable application logic.
- `models/`: request models.
- `web/`: response-shaping helpers shared by controllers.

## Notes

- The base API layer ships a generic route-registration scaffold rather than default concrete endpoints.
- Add project-specific route modules under `routes/` and register them from `routes/__init__.py`.
- Keep controllers thin: parse input, delegate behavior to services, and shape responses through `web/` helpers when useful.
- Connector-backed configuration and integration code are outside this base API layer.
```