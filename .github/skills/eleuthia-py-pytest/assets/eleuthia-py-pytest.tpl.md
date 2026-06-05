# Python Pytest Layer Template

Bundle: `eleuthia-py-pytest`
Status: Active

## 1. Objective

Provide the shared pytest starter-layer governance applied before the isolated support bundles in `./scripts/` and the governed validation assets in `./assets/`.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the pytest layer must be created or updated.
2. `requirements.txt` destination when the target path does not make it obvious where the owned pytest block should be placed.
3. Pytest-config destination when the target path does not make it obvious where `pytest.ini` should be placed.
4. Tests-root destination when the target path does not make it obvious where the owned `tests/` tree should be placed.
5. Whether existing starter files should be replaced, merged, or skipped when exact owned files conflict with local files.
6. Any explicit package-root, fixture-name, or example-file rename requests that must be applied after the exact bundles are placed.

## 3. Deliverables

When governed Python pytest starter-layer generation is requested, the shared template MUST allow only:
- Starter-specific dependency-manifest content aligned with the dedicated dependency asset
- `pytest.ini`
- `tests/`
- Short list of unresolved variables or inputs still needed from the user

Do not generate unrelated dependency-manifest edits, CI/CD, or unrelated scaffolding unless the user explicitly requests them.

## 4. Shared Layer Contract

The generated pytest starter layer MUST preserve exactly the project-root layout defined by the owned code bundles.

Mandatory characteristics:
- Starter-specific dependency content owns only the generic pytest package required by the layer.
- `pytest.ini` owns the test-root discovery and in-project Python path bootstrap required by the layer.
- `tests/conftest.py` owns the import-path bootstrap and only generic shared fixtures that are safe across Python projects.
- The example test file MUST remain starter-only and MUST NOT encode project-specific routes, controller names, response builders, or connector mocks.
- Framework-specific fixture examples MAY appear only as comments or placeholders that require explicit user adaptation.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply explicit user-requested renames only after the exact file bundle is in place.
- Keep the governed starter layout unchanged unless the user explicitly requests a bounded rename or merge.

## 5. Test Layout Expectations

The owned README asset defines the authoritative operator guidance for the generated `tests/` tree.
The owned dependency asset defines the authoritative dependency block for the generated starter layer.
The owned code bundles define the authoritative implementation files for `pytest.ini`, `tests/conftest.py`, and the example starter test.

Mandatory characteristics:
- Keep the test entrypoint command limited to `python -m pytest -q` unless the user explicitly requests another bounded invocation.
- Keep the example starter test minimal, readable, and clearly marked for replacement with project-specific assertions.
- Keep external boundary guidance in documentation rather than embedding concrete infrastructure mocks in the starter.

## 6. Guardrails

- Do not reference `PY-Template/` during normal skill execution.
- Do not duplicate environment, connector, or FastAPI-extension packages inside the starter-owned dependency block.
- Do not invent unrelated integration, end-to-end, performance, connector, environment, or CI/CD behavior in this skill.
- Do not ship concrete domain endpoints, response payloads, service names, or data-access mocks in the starter bundles.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not collapse the governed project-root layout into alternative top-level folder structures.

## 7. Output Format

## 1) Summary
- Selected target path
- Pytest starter-layer scope applied
- Dependency-manifest destination
- Tests-root destination

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