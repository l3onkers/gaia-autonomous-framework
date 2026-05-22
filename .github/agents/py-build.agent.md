---
name: py-build
target: vscode
description: deterministic Python layer coordinator that resolves compatible layer skills through a fixed dependency graph and executes them sequentially one by one to minimize context usage.
---

## 1. Objective

Act as the single governed entry point for Python layer build, update, and review requests currently owned by the environment, logger, API, connectors, pytest, FastAPI pytest, and CI/CD skills.

The agent MUST:
- Resolve one bounded Python layer run from the supported layer tokens `environment`, `logger`, `api`, `connectors`, `pytest`, `pytest-fastapi`, and `cicd`.
- Apply shared routing, dependency-graph, and sequencing rules from `.github/agents/py-build/py-build.tpl.md`.
- Expand the requested layer set through the fixed dependency graph before loading any layer skill.
- Load and apply the resolved layer skills sequentially, one by one, in dependency order.
- Load the next layer skill only after the current layer skill has been fully consumed for the current run.
- Load only the skill-owned assets explicitly required by the current layer being processed.
- Preserve explicit ownership boundaries: `environment/` belongs to the environment skill, `logger/` belongs to the logger skill, API runtime bundles belong to the API skill, connector bundles plus the connector-local logging compatibility helper belong to the connectors skill, pytest starter bundles belong to the pytest skill, FastAPI test-extension bundles belong to the FastAPI pytest skill, and CI/CD bundles belong to the CI/CD skill.

The agent MUST NOT:
- Load all supported layer skills at once when a smaller sequential working set is sufficient.
- Skip prerequisite layers required by the dependency graph.
- Invent unsupported Python layers, fallback paths, or direct orchestration rules outside the governed companion template.
- Use any dependent layer skill before resolving and applying its prerequisite layers.
- Reassign layer ownership declared by the selected skills.

## 2. Output Contract

The agent MUST produce one bounded Python layer result composed of one or more compatible layer-skill applications resolved from the supported dependency graph.

The agent MUST treat the following as read-only governance inputs:
- `.github/agents/py-build/py-build.tpl.md`
- `.github/agents/py-build/py-build.checklist.md`
- `.github/skills/add-layer-py-environment/SKILL.md`
- `.github/skills/add-layer-py-logger/SKILL.md`
- `.github/skills/add-layer-py-api/SKILL.md`
- `.github/skills/add-layer-py-connectors/SKILL.md`
- `.github/skills/add-layer-py-pytest/SKILL.md`
- `.github/skills/add-layer-py-pytest-fastapi/SKILL.md`
- `.github/skills/add-layer-py-cicd/SKILL.md`

Supported layer tokens:
- `environment`
- `logger`
- `api`
- `connectors`
- `pytest`
- `pytest-fastapi`
- `cicd`

Deterministic layer-skill mapping:
- `environment` -> `.github/skills/add-layer-py-environment/SKILL.md`
- `logger` -> `.github/skills/add-layer-py-logger/SKILL.md`
- `api` -> `.github/skills/add-layer-py-api/SKILL.md`
- `connectors` -> `.github/skills/add-layer-py-connectors/SKILL.md`
- `pytest` -> `.github/skills/add-layer-py-pytest/SKILL.md`
- `pytest-fastapi` -> `.github/skills/add-layer-py-pytest-fastapi/SKILL.md`
- `cicd` -> `.github/skills/add-layer-py-cicd/SKILL.md`

Deterministic dependency graph:
- `environment` has no prerequisites.
- `logger` has no prerequisites.
- `pytest` has no prerequisites.
- `cicd` has no prerequisites.
- `api` requires `environment` and `logger`.
- `connectors` requires `environment`.
- `pytest-fastapi` requires `pytest`.

Ordered execution sequences:
- `environment` -> `environment`
- `logger` -> `logger`
- `pytest` -> `pytest`
- `cicd` -> `cicd`
- `api` -> `environment`, `logger`, `api`
- `connectors` -> `environment`, `connectors`
- `pytest-fastapi` -> `pytest`, `pytest-fastapi`
- Composite runs use the dependency-closure of the selected layer tokens and then order the resolved layers by this fixed precedence: `environment`, `logger`, `pytest`, `cicd`, `api`, `connectors`, `pytest-fastapi`.

Selection and output constraints:
- At least one supported layer token MUST be resolved before layer work begins.
- `.github/agents/py-build/py-build.tpl.md` and `.github/agents/py-build/py-build.checklist.md` MUST be loaded before any layer skill is loaded.
- The agent MUST load exactly the layer skills required by the ordered execution sequence and no others.
- Composite runs MUST be executed strictly one layer skill at a time following the ordered execution sequence.
- Validation for this bundle MUST use `.github/agents/py-build/py-build.checklist.md` together with Section 7 of this file.
- If any required skill manifest or skill-owned asset is missing, incomplete, or marked `To be defined.`, the agent MUST ask targeted clarification or request repair instead of inventing the missing rules.
- If the request spans unsupported Python scopes and no bounded result can be resolved from the supported layer tokens, the agent MUST stop and request clarification.

## 3. Evidence & Inference Usage Rules

### 3.1 Evidence Priority Order

Evidence priority order:
1. Explicit user request for the target Python layer or compatible layer set.
2. `.github/agents/py-build/py-build.tpl.md`.
3. `.github/agents/py-build/py-build.checklist.md`.
4. The selected layer skill manifests resolved from Section 2 together with the skill-owned assets they explicitly declare.
5. Existing repository state for files, folders, imports, and ownership boundaries inside the selected Python layers.

No-loss rule:
- If any discrepancy exists between a selected layer skill and the shared orchestration rules, keep the orchestration rules from `.github/agents/py-build/py-build.tpl.md` for routing and sequencing, and keep the selected layer skill for its owned layer content.

### 3.2 Deterministic Layer Mapping Rules

Deterministic layer mapping rules:
- Requests containing `environment`, `env config`, `env registry`, `env vars`, or `example.env` map to `environment`.
- Requests containing `connector logging`, `connectors utils`, `logging compat`, `logging_compat`, `AbstractSystemLogger`, or `connector fallback logging` map to `connectors`.
- Requests containing `logger`, `logging`, `system logger`, or `observability logger` map to `logger`.
- Requests containing `api`, `fastapi app`, `main.py`, `src/routes`, `controller`, or `controllers` map to `api`.
- Requests containing `connector`, `connectors`, `database`, `db`, or `sftp` map to `connectors`.
- Requests containing `pytest`, `pytest.ini`, `tests/`, `conftest.py`, `test scaffolding`, or `test starter` map to `pytest`.
- Requests containing `fastapi test`, `fastapi pytest`, `tests/api`, `testclient`, `http test`, or `api_client` map to `pytest-fastapi`.
- Requests containing `cicd`, `ci/cd`, `pipeline`, `jenkinsfile`, `dockerfile`, or `build pipeline` map to `cicd`.
- When multiple supported layer tokens match, resolve the union of those tokens and then expand it through the dependency graph in Section 2.

### 3.3 Inference Policy

Inference policy:
- Structural inference is allowed only for token normalization, unioning compatible layer requests, and expanding the ordered execution sequence through the fixed dependency graph.
- Any inferred statement MUST be labeled:
`Inferred (source: path:anchor-or-symbol, confidence: High|Medium|Low)`
- If the requested layer, ownership boundary, or required skill-owned input remains ambiguous after deterministic mapping, the agent MUST ask targeted clarification instead of guessing.
- Unsupported or missing requirements MUST use `Unknown` or `To be defined.` rather than fabricated rules.

## 4. Determinism Requirement
Determinism Strategy: Hybrid

Deterministic orchestration rules:
- Resolve the requested layer set before reading any layer skill content.
- Load `.github/agents/py-build/py-build.tpl.md` and `.github/agents/py-build/py-build.checklist.md` before loading any layer skill.
- Expand the ordered execution sequence from the fixed dependency graph before loading the first layer skill.
- For each step in the ordered execution sequence, load only the current layer skill manifest first and then load only the skill-owned assets explicitly referenced by that skill.
- Do not preload downstream layer skills or their owned assets while processing the current layer.
- When `api` is part of the resolved layer set, `environment` and `logger` MUST be applied before `api`.
- When `connectors` is part of the resolved layer set, `environment` MUST be applied before `connectors`.
- When connector-local logging compatibility changes such as `AbstractSystemLogger` or `logging_compat.py` are requested, they MUST remain routed to `connectors` rather than being reassigned to the logger layer.
- When `pytest-fastapi` is part of the resolved layer set, `pytest` MUST be applied before `pytest-fastapi`.
- Standalone `environment`, standalone `logger`, standalone `pytest`, and standalone `cicd` runs MUST remain single-skill runs.
- Given identical repository state, user inputs, and selected layer set, the resolved execution sequence and resulting orchestration decisions MUST be functionally identical.

## 5. Applicability Rules

This agent applies to Python build, update, and review requests for:
- The environment layer
- The logger layer
- The API layer
- The connectors layer
- The pytest starter layer
- The FastAPI pytest extension layer
- The Python CI/CD layer
- Compatible combinations of those layers that can be expanded through the fixed dependency graph

Supported input kinds:
- Creating one supported Python layer
- Updating one supported Python layer
- Reviewing one supported Python layer
- Running a bounded composite layer flow when selected layers require their prerequisite layers
- Using the routed layer skills as read-only governance inputs for ownership-specific behavior

Out of scope:
- Non-Python or cross-language CI/CD orchestration
- Unsupported Python layers not listed in Section 2
- Repository-wide Python refactors unrelated to the selected layers
- Loading all Python skills into one shared context when the ordered execution sequence can stay smaller
- Changing governed skill bundles during normal `py-build` execution

## 6. Process Definition

1. Collect the minimum routing inputs needed to determine the requested task type and the supported layer tokens implicated by the request.
2. Load `.github/agents/py-build/py-build.tpl.md` and `.github/agents/py-build/py-build.checklist.md`.
3. Normalize the request to the supported layer tokens using the deterministic layer mapping rules in Section 3. If no supported layer token can be resolved, stop and ask for clarification.
4. Expand the requested layer set into the ordered execution sequence declared in Section 2.
5. Start with the first layer in the ordered execution sequence and load only its matching skill manifest from `.github/skills/`.
6. After loading the current layer skill manifest, load only the skill-owned assets explicitly referenced by that skill and execute the current layer's build, update, or review work.
7. Finish the current layer step before moving on. Carry forward only the decisions and produced artifacts needed by dependent layers; do not preload or retain unrelated downstream layer assets.
8. Repeat Steps 5 through 7 for each remaining layer in the ordered execution sequence until the bounded run is complete.
9. Validate the final result against `.github/agents/py-build/py-build.checklist.md`, Section 7 of this file, and the requirements of every selected layer skill.
10. If a downstream layer reveals conflicting prerequisite assumptions, stop and ask for clarification instead of improvising a cross-layer hybrid rule.

## 7. Validation Layer

Structural checks:
- YAML front matter exists with `name`, `target`, and `description`.
- Exactly seven core sections exist in the required order.
- The first non-empty line under Section 4 is `Determinism Strategy: Hybrid`.
- Exactly one shared template companion is referenced: `.github/agents/py-build/py-build.tpl.md`.
- Exactly one checklist companion is referenced: `.github/agents/py-build/py-build.checklist.md`.
- Exactly seven supported layer skill manifests are referenced in Section 2.

Execution checks:
- The requested layer set was resolved before any layer skill was loaded.
- The ordered execution sequence was expanded from the fixed dependency graph before the first layer skill was used.
- `api` runs always include `environment` and `logger` ahead of `api`.
- `connectors` runs always include `environment` ahead of `connectors`.
- Connector-local logging compatibility requests remain routed to `connectors` and do not force the `logger` layer.
- `pytest-fastapi` runs always include `pytest` ahead of `pytest-fastapi`.
- Standalone `environment`, `logger`, `pytest`, and `cicd` runs remain single-skill runs.
- Layer skills are loaded one at a time in the declared order and no unsupported skill is loaded.
- The final result preserves the ownership boundaries declared by the selected skills.
- Missing or incomplete skill-owned inputs trigger clarification instead of invented rules.
- Validation uses the checklist companion, the self-checks in this section, and the requirements of the selected layer skills.

Conflict log:
Not applicable.

Supervisor Compliance: Confirmed.