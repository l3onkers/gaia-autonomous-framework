# Python FastAPI Pytest Extension Template

Bundle: `eleuthia-py-pytest-fastapi`
Status: Active

## 1. Objective

Provide the FastAPI-specific pytest extension guidance applied after the generic pytest starter and before the isolated support bundles in `./scripts/` are materialized.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the FastAPI pytest extension must be created or updated.
2. `requirements.txt` destination when the target path does not make it obvious where the owned FastAPI extension block should be placed.
3. `tests/api/` destination when the target path does not make it obvious where the FastAPI-specific test files should be placed.
4. Whether existing FastAPI test files should be replaced, merged, or skipped when exact owned files conflict with local files.
5. Any explicit rename requests for example route paths, fixture names, or file names that must be applied after the exact bundles are placed.

## 3. Deliverables

When governed FastAPI pytest extension generation is requested, the shared template MUST allow only:
- FastAPI-specific dependency-manifest content aligned with the dedicated dependency asset
- `tests/api/`
- Short list of unresolved variables or inputs still needed from the user

Do not generate generic pytest starter files, unrelated dependency-manifest edits, CI/CD, or unrelated scaffolding unless the user explicitly requests them.

## 4. Shared Layer Contract

The generated FastAPI pytest extension MUST preserve exactly the project-root layout defined by the owned code bundles.

Mandatory characteristics:
- The generic pytest starter owns `pytest.ini`, `tests/README.md`, and any top-level generic bootstrap behavior.
- FastAPI-specific dependency content owns only the packages required by the example app fixture and HTTP test in this extension layer.
- `tests/api/conftest.py` owns the FastAPI-specific example app fixture and `TestClient` fixture for this extension layer.
- `tests/api/test_http_example.py` owns one self-contained HTTP example that demonstrates FastAPI request and response testing without importing project-specific business code by default.
- The example route and payload MUST remain generic, safe, and clearly replaceable with project-specific behavior.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply the delegated pytest starter before the FastAPI-specific file bundle is in place.
- Apply explicit user-requested renames only after the exact file bundle is in place.

## 5. FastAPI Example Expectations

The owned dependency asset defines the authoritative dependency block for this extension layer.
The owned code bundles define the authoritative implementation files for `tests/api/conftest.py` and `tests/api/test_http_example.py`.

Mandatory characteristics:
- Use `FastAPI` and `fastapi.testclient.TestClient` for the example fixture and HTTP test.
- Keep the example app inline and self-contained rather than importing the target project's real application by default.
- Keep the example test small, readable, and clearly marked as a replaceable example.
- If the user wants the extension to target the real application factory or router layout, treat that as an explicit bounded adaptation after the exact bundles are placed.

## 6. Guardrails

- Do not modify files owned by the generic pytest starter during normal FastAPI extension execution.
- Do not duplicate generic pytest starter packages or unrelated connector/logger packages in the FastAPI extension-owned dependency block.
- Do not invent business-specific routes, response bodies, connector mocks, or service imports in this skill.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not collapse the governed project-root layout into alternative top-level folder structures.

## 7. Output Format

## 1) Summary
- Selected target path
- FastAPI pytest extension scope applied
- Dependency-manifest destination
- `tests/api/` destination

## 2) Files Created or Updated
- ...

## 3) Dependency Additions
```text
<final requirements.txt block>
```

## 4) Test Execution Guidance
```text
python -m pytest -q
```

## 5) Required Inputs / Variables (if any)
- ...