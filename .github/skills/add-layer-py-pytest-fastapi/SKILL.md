---
name: add-layer-py-pytest-fastapi
description: 'Use when: a setup or orchestration workflow must add a governed FastAPI-specific pytest extension layer on top of the Python pytest starter.'
user-invocable: false
---

# Add Layer Py Pytest FastAPI Skill

## Purpose
- This skill owns governed FastAPI-specific pytest extension-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need reusable FastAPI HTTP-test scaffolding on top of the Python pytest starter.
- This skill stays within the FastAPI pytest extension scope: FastAPI-specific dependency-manifest content, `tests/api/`, and delegated starter integration through `.github/skills/add-layer-py-pytest/SKILL.md`.

## Output Contract
- One FastAPI pytest extension result.
- The owned shared template asset `./assets/add-layer-py-pytest-fastapi.tpl.md`
- The owned checklist asset `./assets/add-layer-py-pytest-fastapi.checklist.md`
- The owned FastAPI requirements bundle `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md`
- The owned FastAPI fixture bundle `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md`
- The owned FastAPI HTTP example bundle `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md`

If the request is not a FastAPI-specific pytest extension request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/add-layer-py-pytest-fastapi.tpl.md`
  - `./assets/add-layer-py-pytest-fastapi.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md`
  - `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md`
  - `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md`
- Additional governed inputs:
  - `.github/skills/add-layer-py-pytest/SKILL.md`

## When to Use
- A caller or workflow must add or restore FastAPI-specific pytest scaffolding on top of the generic Python pytest starter.
- The run needs exact owned files under `tests/api/`, plus a FastAPI-specific dependency block, including a `TestClient` fixture and one self-contained HTTP example test, without depending on `PY-Template/` at execution time.
- Supported inputs include vendoring the governed FastAPI pytest extension into an existing FastAPI app, re-adding deleted FastAPI test scaffolding, and explicit rename requests for example route paths, fixture names, or file names after the exact bundles are applied.
- The run must preserve clear separation between the generic pytest starter and the FastAPI-specific HTTP client and test behavior.
- The run must resolve and apply `.github/skills/add-layer-py-pytest/SKILL.md` before the FastAPI-specific bundles are applied.

## Procedure
1. Confirm the request is a FastAPI-specific pytest extension request.
2. Load `./assets/add-layer-py-pytest-fastapi.tpl.md`, `./assets/add-layer-py-pytest-fastapi.checklist.md`, every owned support bundle under `./scripts/`, and `.github/skills/add-layer-py-pytest/SKILL.md`.
3. Collect only the minimum required inputs, such as target app root, `requirements.txt` destination when the target path is ambiguous, `tests/api/` destination when the target path is ambiguous, whether existing FastAPI test files should be replaced, merged, or skipped, and any explicit rename requests for example route paths, fixture names, or file names.
4. Apply the shared rules from `./assets/add-layer-py-pytest-fastapi.tpl.md` before the exact code bundles.
5. Resolve and apply the pytest starter from `.github/skills/add-layer-py-pytest/SKILL.md` before the FastAPI-specific bundles so `pytest.ini` and the generic `tests/` foundation are present.
6. Materialize the exact file contents from `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md`, `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md`, and `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md` into the target app while preserving the governed relative paths.
7. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned FastAPI fixture and HTTP example files verbatim.
8. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
9. Validate the result against `./assets/add-layer-py-pytest-fastapi.checklist.md`, the shared template, every support bundle under `./scripts/`, `.github/skills/add-layer-py-pytest/SKILL.md`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that FastAPI-specific layer rules remain attributable to `./assets/add-layer-py-pytest-fastapi.tpl.md`.
- Validate that delegated starter behavior remains attributable to `.github/skills/add-layer-py-pytest/SKILL.md` and is applied before the FastAPI-specific bundles.
- Validate that FastAPI dependency guidance remains attributable to `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md`.
- Validate that FastAPI fixture behavior remains attributable to `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md`.
- Validate that FastAPI HTTP example behavior remains attributable to `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md`.
- Validate that the result emits only FastAPI-specific dependency guidance, `tests/api/`, and unresolved inputs allowed by the owned assets, the delegated starter, and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/add-layer-py-pytest-fastapi.tpl.md`.
  3. `./assets/add-layer-py-pytest-fastapi.checklist.md`.
  4. `.github/skills/add-layer-py-pytest/SKILL.md`.
  5. `./scripts/add-layer-py-pytest-fastapi.requirements.tpl.md`.
  6. `./scripts/add-layer-py-pytest-fastapi.api-conftest.py.tpl.md`.
  7. `./scripts/add-layer-py-pytest-fastapi.test-http-example.py.tpl.md`.
  8. Existing repository evidence for the target FastAPI app and current test layout.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `requirements.txt` destination detection, `tests/api/` destination detection, and application of explicit rename requests to the owned files after the exact bundles are placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/add-layer-py-pytest-fastapi.tpl.md` and `./assets/add-layer-py-pytest-fastapi.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/` and `.github/skills/add-layer-py-pytest/SKILL.md` before artifact generation begins.
- Apply the delegated pytest starter before the FastAPI-specific bundles.
- Apply dependency-manifest content from the dedicated FastAPI asset without merging unrelated blocks unless the user explicitly requests it.
- Keep the exact file contents from the owned bundles before applying any explicit user-requested rename or merge behavior.
- Keep the example app and example route generic and clearly replaceable unless the user explicitly requests a bounded adaptation.
- For identical repository state and user inputs, the resulting FastAPI pytest extension guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/add-layer-py-pytest-fastapi.checklist.md` together with this skill, `./assets/add-layer-py-pytest-fastapi.tpl.md`, every owned support bundle under `./scripts/`, and `.github/skills/add-layer-py-pytest/SKILL.md` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the delegated starter is explicitly declared and applied before the FastAPI-specific bundles.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not modify `pytest.ini`, `tests/README.md`, `tests/conftest.py`, environment files, connectors, logger, CI/CD artifacts, or business code as part of normal FastAPI pytest extension execution.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not omit the delegated pytest starter when the FastAPI-specific bundles are applied.
- Do not widen the FastAPI extension-owned dependency block beyond the packages required for the example fixture and HTTP test unless the user explicitly requests a bounded change.
- Do not import the target project's real FastAPI app by default; keep the shipped example self-contained unless the user explicitly requests a bounded adaptation.
- Do not ship business-specific routes, response schemas, controller imports, database mocks, or service-specific assertions as part of the extension layer.
- Do not invent integration, end-to-end, or performance tests unless the user explicitly requests a bounded extension.
- Do not introduce secrets or credentials into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.