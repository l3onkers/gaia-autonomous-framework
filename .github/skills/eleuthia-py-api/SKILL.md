---
name: eleuthia-py-api
description: 'Use when: a setup or orchestration workflow must add a governed Python API layer from isolated owned support and code bundles.'
user-invocable: false
---

# Add Layer Py Api Skill

## Purpose
- This skill owns governed Python API-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable FastAPI-based application layer for Python services.
- This skill stays within the API-layer scope: main.py, the generic API shell under src/, API-specific dependency-manifest content, delegated environment-layer integration through `.github/skills/eleuthia-py-environment/SKILL.md`, and delegated logger-layer integration through `.github/skills/eleuthia-py-logger/SKILL.md`.

## Output Contract
- One Python API-layer result.
- The owned shared template asset `./assets/eleuthia-py-api.tpl.md`
- The owned checklist asset `./assets/eleuthia-py-api.checklist.md`
- The owned API requirements bundle `./scripts/eleuthia-py-api.requirements.tpl.md`
- The owned API bootstrap bundle `./scripts/eleuthia-py-api.bootstrap.py.tpl.md`
- The owned API source-readme bundle `./scripts/eleuthia-py-api.src-readme.tpl.md`
- The owned API routes bundle `./scripts/eleuthia-py-api.routes.py.tpl.md`
- The owned API controllers-readme bundle `./scripts/eleuthia-py-api.controllers-readme.tpl.md`
- The owned API response-support bundle `./scripts/eleuthia-py-api.example.py.tpl.md`

If the request is not a Python API-layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/eleuthia-py-api.tpl.md`
  - `./assets/eleuthia-py-api.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/eleuthia-py-api.requirements.tpl.md`
  - `./scripts/eleuthia-py-api.bootstrap.py.tpl.md`
  - `./scripts/eleuthia-py-api.src-readme.tpl.md`
  - `./scripts/eleuthia-py-api.routes.py.tpl.md`
  - `./scripts/eleuthia-py-api.controllers-readme.tpl.md`
  - `./scripts/eleuthia-py-api.example.py.tpl.md`
- Additional governed inputs:
  - `.github/skills/eleuthia-py-environment/SKILL.md`
  - `.github/skills/eleuthia-py-logger/SKILL.md`

## When to Use
- A caller or workflow must add or restore the base Python API layer for a FastAPI service.
- The run needs exact owned files for main.py and the reusable API shell under src/, plus an API-specific dependency block, a generic route-registration scaffold, and controller-integration guidance, without depending on `PY-Template/` at execution time.
- Supported inputs include new API-layer scaffolding, re-adding deleted API runtime files, vendoring the governed API layer into an existing Python app, and explicit rename requests for route module names, controller module names, or support-file names after the exact bundles are applied.
- The run needs clear separation between delegated environment loading, delegated logging, API runtime concerns, and out-of-scope layers such as connectors, tests, or command-processing extensions.
- The run must preserve the environment dependency used by the runtime server by resolving `.github/skills/eleuthia-py-environment/SKILL.md` before the API shell bundles are applied.
- The run must preserve the logger dependency used by the bootstrap bundle by resolving `.github/skills/eleuthia-py-logger/SKILL.md` before owned code that imports `logger.SystemLogger` is applied.

## Procedure
1. Confirm the request is a Python API-layer request.
2. Load `./assets/eleuthia-py-api.tpl.md`, `./assets/eleuthia-py-api.checklist.md`, every owned support bundle under `./scripts/`, `.github/skills/eleuthia-py-environment/SKILL.md`, and `.github/skills/eleuthia-py-logger/SKILL.md`.
3. Collect only the minimum required inputs, such as target app root, `requirements.txt` destination when the target path is ambiguous, `src/` destination when the target path is ambiguous, whether existing API files should be replaced, merged, or skipped, and any explicit rename requests for route module names, controller module names, or support-file names.
4. Apply the shared rules from `./assets/eleuthia-py-api.tpl.md` before the exact code bundles.
5. Resolve and apply the environment layer from `.github/skills/eleuthia-py-environment/SKILL.md` before the logger and API bundles so the imported `environment.env_config` implementation is present.
6. Resolve and apply the logger layer from `.github/skills/eleuthia-py-logger/SKILL.md` before the bootstrap bundle and any owned code that imports `logger.SystemLogger` so the implementation is present.
7. Materialize the exact file contents from `./scripts/eleuthia-py-api.bootstrap.py.tpl.md`, `./scripts/eleuthia-py-api.src-readme.tpl.md`, `./scripts/eleuthia-py-api.routes.py.tpl.md`, `./scripts/eleuthia-py-api.controllers-readme.tpl.md`, and `./scripts/eleuthia-py-api.example.py.tpl.md` into the target app while preserving the governed relative paths.
8. Apply the API-specific dependency-manifest content from `./scripts/eleuthia-py-api.requirements.tpl.md` to the resolved destination without duplicating blocks owned by the environment, logger, connectors, or pytest layers.
9. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned code and support content verbatim.
10. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
11. Validate the result against `./assets/eleuthia-py-api.checklist.md`, the shared template, every support bundle under `./scripts/`, `.github/skills/eleuthia-py-environment/SKILL.md`, `.github/skills/eleuthia-py-logger/SKILL.md`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared layer rules remain attributable to `./assets/eleuthia-py-api.tpl.md`.
- Validate that delegated environment-layer behavior remains attributable to `.github/skills/eleuthia-py-environment/SKILL.md` and is applied before the logger and API bundles.
- Validate that delegated logger-layer behavior remains attributable to `.github/skills/eleuthia-py-logger/SKILL.md` and is applied before the bootstrap bundle and any owned code that imports `logger.SystemLogger`.
- Validate that API runtime dependency guidance remains attributable to `./scripts/eleuthia-py-api.requirements.tpl.md`.
- Validate that the application entrypoint and runtime shell remain attributable to `./scripts/eleuthia-py-api.bootstrap.py.tpl.md`.
- Validate that source-structure guidance remains attributable to `./scripts/eleuthia-py-api.src-readme.tpl.md`.
- Validate that route-registration scaffolding remains attributable to `./scripts/eleuthia-py-api.routes.py.tpl.md`.
- Validate that controller-integration guidance and sample controller structure remain attributable to `./scripts/eleuthia-py-api.controllers-readme.tpl.md`.
- Validate that reusable response-builder support remains attributable to `./scripts/eleuthia-py-api.example.py.tpl.md`.
- Validate that the result emits only the files, API-specific dependency guidance, and unresolved inputs allowed by the owned assets and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/eleuthia-py-api.tpl.md`.
  3. `./assets/eleuthia-py-api.checklist.md`.
  4. `.github/skills/eleuthia-py-environment/SKILL.md`.
  5. `.github/skills/eleuthia-py-logger/SKILL.md`.
  6. `./scripts/eleuthia-py-api.requirements.tpl.md`.
  7. `./scripts/eleuthia-py-api.bootstrap.py.tpl.md`.
  8. `./scripts/eleuthia-py-api.src-readme.tpl.md`.
  9. `./scripts/eleuthia-py-api.routes.py.tpl.md`.
  10. `./scripts/eleuthia-py-api.controllers-readme.tpl.md`.
  11. `./scripts/eleuthia-py-api.example.py.tpl.md`.
  12. Existing repository evidence for the target Python app and packaging manifest.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `requirements.txt` destination detection, `src/` destination detection, and application of explicit rename requests to the owned code after the exact bundle is placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/eleuthia-py-api.tpl.md` and `./assets/eleuthia-py-api.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/`, `.github/skills/eleuthia-py-environment/SKILL.md`, and `.github/skills/eleuthia-py-logger/SKILL.md` before artifact generation begins.
- Apply the shared template before the owned code bundles.
- Apply the delegated environment layer before the delegated logger and API bundles.
- Apply the delegated logger layer before the bootstrap bundle and any owned code that imports `logger.SystemLogger`.
- Apply dependency-manifest content from the dedicated API asset without merging unrelated blocks unless the user explicitly requests it.
- Keep the API-owned dependency block limited to the core runtime packages required by the governed API shell rather than environment, logger, connectors, pytest, or command-processing packages.
- Use the exact file contents from the owned code bundles before applying any explicit user-requested rename or merge behavior.
- Keep the route-registration and controller-integration scaffolding generic, with no default concrete endpoints or controller implementations unless the user explicitly requests a bounded adaptation.
- For identical repository state and user inputs, the resulting API-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/eleuthia-py-api.checklist.md` together with this skill, `./assets/eleuthia-py-api.tpl.md`, every owned support bundle under `./scripts/`, `.github/skills/eleuthia-py-environment/SKILL.md`, and `.github/skills/eleuthia-py-logger/SKILL.md` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the delegated environment and logger layers are explicitly declared and applied before any owned API code that imports them.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate connectors, pytest layers, CI/CD artifacts, Docker assets, or unrelated scaffolding in the same run.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not keep duplicate environment or logger bundles under `./scripts/`; those responsibilities belong to `.github/skills/eleuthia-py-environment/SKILL.md` and `.github/skills/eleuthia-py-logger/SKILL.md`.
- Do not omit the delegated environment layer when the runtime server bundle is applied, because `src/EngineServer.py` imports `environment.env_config`.
- Do not omit the delegated logger layer when the bootstrap bundle is applied, because `src/boot.py` imports `logger.SystemLogger`.
- Do not widen the API-owned dependency block beyond `fastapi` and `uvicorn` unless the user explicitly requests a bounded change.
- Do not ship DB-backed sample endpoints, connector-specific configuration, async command consumers, or command-bus integrations as part of this base API layer.
- Do not ship default public, health, sample, or version routes/controllers as part of this base API layer unless the user explicitly requests a bounded change.
- Do not invent business-specific routes, schemas, controllers, or service behavior in the controllers-readme or response-support bundles.
- Do not weaken the exact owned file contents unless the user explicitly requests a bounded change.
- Do not introduce secrets or credentials into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.