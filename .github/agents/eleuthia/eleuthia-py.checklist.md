# py-build Checklist

Quality and determinism checklist for `eleuthia` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist with matching basename:
  - `py-hephaestus.agent.md`
  - `eleuthia-py.tpl.md`
  - `eleuthia-py.checklist.md`
- [ ] `py-hephaestus.agent.md` references `eleuthia-py.tpl.md` and `eleuthia-py.checklist.md` as authoritative governed inputs
- [ ] `py-hephaestus.agent.md` remains supervisory and keeps detailed routing rules in `eleuthia-py.tpl.md`
- [ ] Supported layer skills exist under `.github/skills/`:
  - `.github/skills/eleuthia-py-environment/SKILL.md`
  - `.github/skills/eleuthia-py-logger/SKILL.md`
  - `.github/skills/eleuthia-py-api/SKILL.md`
  - `.github/skills/eleuthia-py-connectors/SKILL.md`
  - `.github/skills/eleuthia-py-pytest/SKILL.md`
  - `.github/skills/eleuthia-py-pytest-fastapi/SKILL.md`
  - `.github/skills/hephaestus-py-cicd/SKILL.md`

---

## B. Agent Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `target`, `description`
- [ ] Exactly seven core sections exist in order:
  1. Objective
  2. Output Contract
  3. Evidence & Inference Usage Rules
  4. Determinism Requirement
  5. Applicability Rules
  6. Process Definition
  7. Validation Layer
- [ ] Section 4 starts with `Determinism Strategy: Hybrid`
- [ ] `py-hephaestus.agent.md` declares the shared template and checklist companions explicitly

---

## C. Dependency Graph Integrity
- [ ] The dependency graph is explicit in `py-hephaestus.agent.md` and `eleuthia-py.tpl.md`
- [ ] `environment` is treated as a foundational layer with no prerequisite inside `eleuthia`
- [ ] `logger` is treated as a foundational layer with no prerequisite inside `eleuthia`
- [ ] `pytest` is treated as a foundational layer with no prerequisite inside `eleuthia`
- [ ] `cicd` is treated as a standalone layer with no prerequisite inside `eleuthia`
- [ ] `api` requires both `environment` and `logger`
- [ ] `connectors` requires `environment`
- [ ] `pytest-fastapi` requires `pytest`
- [ ] Deterministic layer-token mapping rules are explicit and bounded to the supported scope
- [ ] Connector-local logging compatibility requests such as `AbstractSystemLogger` route to `connectors` rather than `logger`

---

## D. Sequential Loading Discipline
- [ ] The requested layer set is resolved before any layer skill is loaded
- [ ] The ordered execution sequence is expanded from the dependency graph before the first layer skill is used
- [ ] Only the current layer skill is loaded at each execution step
- [ ] Only the current layer's explicitly required skill-owned assets are loaded for that step
- [ ] Standalone `environment`, `logger`, `pytest`, and `cicd` requests remain single-skill runs
- [ ] Any request containing `api` expands to `environment`, `logger`, `api`
- [ ] Any request containing `connectors` expands to `environment`, `connectors`
- [ ] Connector-local logging compatibility requests remain bounded to `environment`, `connectors`
- [ ] Any request containing `pytest-fastapi` expands to `pytest`, `pytest-fastapi`
- [ ] The agent does not preload all supported layer skills into one working set
- [ ] Cross-layer conflicts trigger clarification instead of ad hoc hybrid rules

---

## E. Ownership and Safety
- [ ] The environment skill remains the sole owner of `environment/` and the environment bootstrap env block
- [ ] The logger skill remains the sole owner of `logger/` and the logger-specific env block
- [ ] The API skill owns only API runtime bundles and does not take ownership of environment or logger outputs
- [ ] The connectors skill owns connector-specific bundles plus connector-local logging compatibility and does not take ownership of lower layers
- [ ] The pytest skill owns only the generic pytest starter bundles
- [ ] The FastAPI pytest skill owns only FastAPI test-extension bundles and does not take ownership of the pytest starter bundles
- [ ] The CI/CD skill owns only Python CI/CD artifacts and does not take ownership of runtime, connectors, or tests
- [ ] Missing or incomplete skill-owned assets trigger clarification instead of guessed content
- [ ] No unsupported Python layers are introduced in normal `eleuthia` execution

---

## F. Final Validation
- [ ] Validation runs against `eleuthia-py.checklist.md` together with Section 7 of `py-hephaestus.agent.md`
- [ ] The final result uses only the minimum compatible layer sequence required by the dependency graph
- [ ] Routing, sequencing, and ownership decisions remain deterministic for identical inputs and repository state
- [ ] The final result remains attributable to the selected layer skills plus the shared `eleuthia` orchestration rules