# py-build Template

Shared routing, dependency-graph, and sequential execution rules for the `eleuthia` Python layer coordinator.

## Purpose

- Keep orchestration rules in one place while leaving layer-specific behavior inside the routed skills.
- Make the dependency graph explicit so the agent can expand compatible layer requests deterministically.
- Keep context usage bounded by loading one layer skill at a time.

## Supported Layer Skills

- `environment` -> `.github/skills/eleuthia-py-environment/SKILL.md`
- `logger` -> `.github/skills/eleuthia-py-logger/SKILL.md`
- `api` -> `.github/skills/eleuthia-py-api/SKILL.md`
- `connectors` -> `.github/skills/eleuthia-py-connectors/SKILL.md`
- `pytest` -> `.github/skills/eleuthia-py-pytest/SKILL.md`
- `pytest-fastapi` -> `.github/skills/eleuthia-py-pytest-fastapi/SKILL.md`
- `cicd` -> `.github/skills/hephaestus-py-cicd/SKILL.md`

## Dependency Graph

```text
environment ----\
                 +--> api
logger ---------/

environment ----\
                 +--> connectors

pytest ---------> pytest-fastapi

cicd (standalone)
```

Interpretation:
- `environment` is a foundational layer with no prerequisite inside `eleuthia`.
- `logger` is a foundational layer with no prerequisite inside `eleuthia`.
- `pytest` is a foundational layer with no prerequisite inside `eleuthia`.
- `cicd` is a standalone layer with no prerequisite inside `eleuthia`.
- `api` is a dependent layer and requires both `environment` and `logger`.
- `connectors` is a dependent layer and requires `environment`.
- `pytest-fastapi` is a dependent layer and requires `pytest`.

## Deterministic Routing Rules

Normalize supported request tokens as follows:
- `environment`, `env config`, `env registry`, `env vars`, `example.env` -> `environment`
- `connector logging`, `connectors utils`, `logging compat`, `logging_compat`, `AbstractSystemLogger`, `connector fallback logging` -> `connectors`
- `logger`, `logging`, `system logger`, `observability logger` -> `logger`
- `api`, `fastapi app`, `main.py`, `src/routes`, `controller`, `controllers` -> `api`
- `connector`, `connectors`, `database`, `db`, `sftp` -> `connectors`
- `pytest`, `pytest.ini`, `tests/`, `conftest.py`, `test scaffolding`, `test starter` -> `pytest`
- `fastapi test`, `fastapi pytest`, `tests/api`, `testclient`, `http test`, `api_client` -> `pytest-fastapi`
- `cicd`, `ci/cd`, `pipeline`, `jenkinsfile`, `dockerfile`, `build pipeline` -> `cicd`

Expand the ordered execution sequence as follows:
- `environment` -> `environment`
- `logger` -> `logger`
- `pytest` -> `pytest`
- `cicd` -> `cicd`
- `api` -> `environment`, `logger`, `api`
- `connectors` -> `environment`, `connectors`
- `pytest-fastapi` -> `pytest`, `pytest-fastapi`
- For any composite run, first compute the dependency-closure of the selected layers, then order the resolved set by this fixed precedence: `environment`, `logger`, `pytest`, `cicd`, `api`, `connectors`, `pytest-fastapi`.

## Sequential Execution Rules

- Load this template and the checklist before loading any layer skill.
- Resolve the complete ordered execution sequence before loading the first layer skill.
- Load only the current layer skill manifest first.
- After reading the current layer skill manifest, load only the skill-owned assets that the current layer explicitly requires.
- Finish the current layer step before loading the next layer skill.
- Carry forward only the decisions, produced files, and ownership constraints that a dependent layer needs.
- Do not preload all layer skill bundles into one working set.
- Do not ping-pong between layer skills. If a later layer conflicts with an earlier prerequisite decision, stop and ask for clarification.
- Do not execute a dependent layer before its prerequisites in the dependency graph.

## Ownership Guardrails

- The environment skill owns `environment/` and the environment bootstrap env block.
- The logger skill owns `logger/` and the logger-specific env block.
- The API skill owns the FastAPI runtime shell and depends on environment and logger outputs without taking ownership of them.
- The connectors skill owns connector-specific bundles plus connector-local logging compatibility such as `connectors/utils/logging_compat.py`, may depend on environment outputs, and does not take ownership of lower layers.
- The pytest skill owns the generic test starter bundles.
- The FastAPI pytest skill owns only FastAPI test-extension bundles and depends on the pytest starter without taking ownership of it.
- The CI/CD skill owns Python CI/CD artifacts and does not take ownership of runtime, connectors, or tests.
- `eleuthia` coordinates the order of execution; it does not redefine the owned content of the routed skills.

## Expected Outcome

- A standalone environment run uses only the environment skill.
- A standalone logger run uses only the logger skill.
- A standalone pytest run uses only the pytest skill.
- A standalone CI/CD run uses only the CI/CD skill.
- An API run becomes a three-step flow: environment, then logger, then API.
- A connectors run becomes a two-step flow: environment, then connectors.
- Connector-local logging compatibility requests are treated as connectors work, so they resolve to the same two-step flow: environment, then connectors.
- A FastAPI pytest run becomes a two-step flow: pytest, then pytest-fastapi.
- Composite requests stay bounded to the minimum compatible layer sequence derived from the dependency graph.