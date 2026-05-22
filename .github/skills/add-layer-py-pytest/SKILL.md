---
name: add-layer-py-pytest
description: 'Use when: a setup or orchestration workflow must add a governed Python pytest layer from isolated owned support and code bundles.'
user-invocable: false
---

# Add Layer Py Pytest Skill

## Purpose
- This skill owns governed Python pytest starter-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable pytest foundation for Python projects or services.
- This skill stays within the pytest starter-layer scope: `pytest.ini`, `tests/`, starter-specific dependency-manifest content, and example-only test scaffolding.

## Output Contract
- One Python pytest starter-layer result.
- The owned shared template asset `./assets/add-layer-py-pytest.tpl.md`
- The owned checklist asset `./assets/add-layer-py-pytest.checklist.md`
- The owned pytest requirements bundle `./scripts/add-layer-py-pytest.requirements.tpl.md`
- The owned pytest config bundle `./scripts/add-layer-py-pytest.pytest.ini.tpl.md`
- The owned tests README bundle `./scripts/add-layer-py-pytest.tests-readme.tpl.md`
- The owned pytest bootstrap bundle `./scripts/add-layer-py-pytest.conftest.py.tpl.md`
- The owned example test bundle `./scripts/add-layer-py-pytest.test-example-template.py.tpl.md`

If the request is not a Python pytest-layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/add-layer-py-pytest.tpl.md`
  - `./assets/add-layer-py-pytest.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/add-layer-py-pytest.requirements.tpl.md`
  - `./scripts/add-layer-py-pytest.pytest.ini.tpl.md`
  - `./scripts/add-layer-py-pytest.tests-readme.tpl.md`
  - `./scripts/add-layer-py-pytest.conftest.py.tpl.md`
  - `./scripts/add-layer-py-pytest.test-example-template.py.tpl.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller or workflow must add or restore a minimal pytest starter layer for a Python project or service.
- The run needs exact owned files for `pytest.ini` and `tests/`, plus a starter-specific dependency block, including a path-bootstrap `conftest.py`, basic operator guidance, and one clearly example-only starter test, without depending on `PY-Template/` at execution time.
- Supported inputs include new starter scaffolding, re-adding deleted pytest config, vendoring the governed pytest starter into an existing Python app, and explicit rename requests for package roots or example file names after the exact bundles are applied.
- The run needs a universal procedure that demonstrates pytest structure without shipping domain-specific routes, controllers, response builders, or connector mocks as part of the starter.

## Procedure
1. Confirm the request is a Python pytest-layer request.
2. Load `./assets/add-layer-py-pytest.tpl.md`, `./assets/add-layer-py-pytest.checklist.md`, and every owned support bundle under `./scripts/`.
3. Collect only the minimum required inputs, such as target app root, `requirements.txt` destination when the target path is ambiguous, pytest-config destination when the target path is ambiguous, tests-root destination when the target path is ambiguous, whether existing starter files should be replaced, merged, or skipped, and any explicit package-root or example-file rename requests.
4. Apply the shared rules from `./assets/add-layer-py-pytest.tpl.md` before the exact code bundles.
5. Materialize the exact file contents from `./scripts/add-layer-py-pytest.requirements.tpl.md`, `./scripts/add-layer-py-pytest.pytest.ini.tpl.md`, `./scripts/add-layer-py-pytest.tests-readme.tpl.md`, `./scripts/add-layer-py-pytest.conftest.py.tpl.md`, and `./scripts/add-layer-py-pytest.test-example-template.py.tpl.md` into the target app while preserving the governed relative paths.
6. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned config, documentation, and example starter files verbatim.
7. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
8. Validate the result against `./assets/add-layer-py-pytest.checklist.md`, the shared template, every support bundle under `./scripts/`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared layer rules remain attributable to `./assets/add-layer-py-pytest.tpl.md`.
- Validate that starter dependency guidance remains attributable to `./scripts/add-layer-py-pytest.requirements.tpl.md`.
- Validate that pytest configuration remains attributable to `./scripts/add-layer-py-pytest.pytest.ini.tpl.md`.
- Validate that test-layer documentation remains attributable to `./scripts/add-layer-py-pytest.tests-readme.tpl.md`.
- Validate that test bootstrap behavior remains attributable to `./scripts/add-layer-py-pytest.conftest.py.tpl.md`.
- Validate that example-only starter coverage remains attributable to `./scripts/add-layer-py-pytest.test-example-template.py.tpl.md`.
- Validate that the result emits only starter-specific dependency guidance, `pytest.ini`, `tests/`, and unresolved inputs allowed by the owned assets and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/add-layer-py-pytest.tpl.md`.
  3. `./assets/add-layer-py-pytest.checklist.md`.
  4. `./scripts/add-layer-py-pytest.requirements.tpl.md`.
  5. `./scripts/add-layer-py-pytest.pytest.ini.tpl.md`.
  6. `./scripts/add-layer-py-pytest.tests-readme.tpl.md`.
  7. `./scripts/add-layer-py-pytest.conftest.py.tpl.md`.
  8. `./scripts/add-layer-py-pytest.test-example-template.py.tpl.md`.
  9. Existing repository evidence for the target Python app and current test layout.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `requirements.txt` destination detection, pytest-config destination detection, tests-root detection, and application of explicit rename requests to the owned files after the exact bundles are placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/add-layer-py-pytest.tpl.md` and `./assets/add-layer-py-pytest.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/` before artifact generation begins.
- Apply the shared template before the owned code bundles.
- Apply dependency-manifest content from the dedicated asset without merging unrelated blocks unless the user explicitly requests it.
- Keep the exact file contents from the owned bundles before applying any explicit user-requested rename or merge behavior.
- Keep the example starter test generic and clearly non-domain-specific unless the user explicitly requests a bounded adaptation.
- For identical repository state and user inputs, the resulting pytest-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/add-layer-py-pytest.checklist.md` together with this skill, `./assets/add-layer-py-pytest.tpl.md`, and every owned support bundle under `./scripts/` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not modify unrelated dependency-manifest content, environment files, connectors, logger, CI/CD artifacts, or business code as part of normal pytest-layer execution.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not widen the pytest starter-owned dependency block beyond `pytest` unless the user explicitly requests a bounded change.
- Do not ship concrete domain routes, response builders, controllers, database mocks, or service-specific assertions as part of the starter layer.
- Do not invent additional integration, end-to-end, or performance tests unless the user explicitly requests a bounded extension.
- Do not silently rewrite import-path bootstrapping or package-root names when the target app differs from the governed starter layout; use explicit rename requests or surface `Unknown`.
- Do not introduce secrets or credentials into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.