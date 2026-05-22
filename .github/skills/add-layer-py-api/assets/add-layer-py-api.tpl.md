# Python API Layer Template

Bundle: `add-layer-py-api`
Status: Active

## 1. Objective

Provide the shared API-layer governance applied before the isolated support bundles in `./scripts/`, the delegated environment layer from `.github/skills/add-layer-py-environment/SKILL.md`, the delegated logger layer from `.github/skills/add-layer-py-logger/SKILL.md`, and the governed validation assets in `./assets/`.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the API layer must be created or updated.
2. `requirements.txt` destination when the target path does not make it obvious where the owned API runtime block should be placed.
3. `src/` destination when the target path does not make it obvious where the API shell files should be placed.
4. Whether existing `main.py` or `src/` files should be replaced, merged, or skipped when exact owned code conflicts with local files.
5. Any explicit rename requests for route module names, controller module names, or support-file names that must be applied after the exact code bundle is placed.

## 3. Deliverables

When governed Python API-layer generation is requested, the shared template MUST allow only:
- Delegated environment-layer application aligned with `.github/skills/add-layer-py-environment/SKILL.md`
- Delegated logger-layer application aligned with `.github/skills/add-layer-py-logger/SKILL.md`
- `main.py`
- `src/README.md`
- `src/boot.py`
- `src/EngineApp.py`
- `src/EngineServer.py`
- `src/routes/`
- Controller-integration guidance plus sample controller structure aligned with the dedicated controllers-readme bundle
- Reusable response-helper support aligned with the dedicated response-support bundle
- Dependency-manifest additions aligned with the dedicated dependency asset
- Short list of unresolved variables or inputs still needed from the user

Do not generate connectors, tests, command-processing extensions, CI/CD, or unrelated scaffolding unless the user explicitly requests them.

## 4. Shared Layer Contract

The generated API layer MUST preserve exactly the project-root layout defined by the owned code bundles.

Mandatory characteristics:
- `environment/` is owned by `.github/skills/add-layer-py-environment/SKILL.md` and MUST be applied before the API runtime bundle because `src/EngineServer.py` imports `environment.env_config`.
- `logger/` is owned by `.github/skills/add-layer-py-logger/SKILL.md` and MUST be applied before the bootstrap bundle and any future generated code that imports `logger.SystemLogger`.
- `main.py`, `src/boot.py`, `src/EngineApp.py`, and `src/EngineServer.py` own the reusable application entrypoint, FastAPI app factory, and runtime server shell for this layer.
- `src/routes/` owns the central route-registration scaffold used to attach project-specific routers.
- The controllers-readme bundle owns controller-integration guidance together with a sample controller structure that downstream automation can adapt into new controllers.
- The response-support bundle owns reusable response-builder support for future concrete controllers.
- No default concrete route modules or controller implementations are required in this base API layer.
- `requirements.txt` content is owned by a dedicated API dependency asset and remains limited to the runtime packages required by the governed API shell.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply `.github/skills/add-layer-py-environment/SKILL.md` before the delegated logger and API bundles.
- Apply `.github/skills/add-layer-py-logger/SKILL.md` before the bootstrap bundle and any owned code that imports `logger.SystemLogger`.
- Apply explicit user-requested renames only after the exact file bundle is in place.
- Keep the route-registration scaffold and controller guidance generic unless the user explicitly requests a bounded adaptation.

## 5. Controller and Routing Expectations

The owned dependency asset defines the authoritative dependency block for this layer.
The owned runtime bundle defines the authoritative entrypoint and server files for this layer.
The owned route, controllers-readme, and response-support bundles define the authoritative scaffolding for project-specific route and controller integration.

Mandatory characteristics:
- Use `FastAPI` plus `APIRouter` for the application shell and route registration.
- Keep the runtime bundle focused on serving the application rather than bundling tests, command consumers, or connector setup.
- Keep `src/routes/__init__.py` limited to a generic registration scaffold with clearly commented extension points rather than shipping default concrete routers.
- Keep `src/controllers/README.md` explicit enough that downstream automation can derive new controllers from the sample structure without guessing the orchestration pattern.
- Keep controllers project-specific and add them only when the user or a downstream layer explicitly owns those implementations.
- Keep reusable response helpers small, readable, and optional for project-specific controllers.
- If the user wants concrete routers, richer lifecycle hooks, or business-specific controllers, treat those as explicit bounded adaptations after the exact bundles are placed.

## 6. Guardrails

- Do not reference `PY-Template/` during normal skill execution.
- Do not keep environment code or logger code inside the API-owned `./scripts/`; delegate those responsibilities to their governed layer skills.
- Do not keep connectors, DB-backed sample endpoints, tests, or command-processing behavior in this base API layer.
- Do not keep default public, health, sample, or version routes/controllers in this base API layer.
- Do not duplicate environment, logger, connectors, pytest, or command-processing packages in the API-owned dependency block.
- Do not store script-like owned bundles under `./assets/`; keep them under `./scripts/`.
- Do not change business-specific code as part of normal layer generation.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not collapse the governed project-root layout into alternative top-level folder structures.

## 7. Output Format

## 1) Summary
- Selected target path
- Layer scope applied
- Dependency-manifest destination

## 2) Files Created or Updated
- ...

## 3) Dependency Additions
```text
<final requirements.txt block>
```

## 4) API Surface Summary
```text
main.py
src/boot.py
src/EngineApp.py
src/EngineServer.py
src/routes/__init__.py
src/controllers/README.md
src/web/response_builder.py
```

## 5) Required Inputs / Variables (if any)
- ...