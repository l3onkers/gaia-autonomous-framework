---
name: eleuthia-py-logger
description: 'Use when: a setup or orchestration workflow must add a governed Python logger layer from isolated owned support and code bundles.'
user-invocable: false
---

# Add Layer Py Logger Skill

## Purpose
- This skill owns governed Python logger-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable logger layer for Python services.
- This skill stays within the logger-layer scope: `logger/` and logger-specific `example.env` content.

## Output Contract
- One Python logger-layer result.
- The owned shared template asset `./assets/eleuthia-py-logger.tpl.md`
- The owned checklist asset `./assets/eleuthia-py-logger.checklist.md`
- The owned logger code bundle `./scripts/eleuthia-py-logger.logger.py.tpl.md`
- The owned logger example-env bundle `./scripts/eleuthia-py-logger.example-env.tpl.md`

If the request is not a Python logger-layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/eleuthia-py-logger.tpl.md`
  - `./assets/eleuthia-py-logger.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/eleuthia-py-logger.logger.py.tpl.md`
  - `./scripts/eleuthia-py-logger.example-env.tpl.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller or workflow must add or restore the Python logger layer used by a Python service or a broader Python application layer.
- The run needs exact owned code for `logger/` and isolated logger-specific example-env content without depending on `PY-Template/` or another Python layer at execution time.
- Supported inputs include new layer scaffolding, re-adding a deleted logger layer, vendoring the governed logger layer into an existing Python app, and explicit renames of logger-specific env keys or default bounded-context names after the exact code bundle is applied.
- The run needs clear separation between logger behavior and any external environment wrapper such as `environment/env_config.py` or `environment/env_vars_mapper.py`.
- The run must keep dependency-manifest changes out of scope during normal logger-layer execution because the owned logger code is stdlib-only.

## Procedure
1. Confirm the request is a Python logger-layer request.
2. Load `./assets/eleuthia-py-logger.tpl.md`, `./assets/eleuthia-py-logger.checklist.md`, and every owned support bundle under `./scripts/`.
3. Collect only the minimum required inputs, such as target app root, example-env destination, whether existing `logger/` files should be replaced, merged, or skipped, and any explicit logger env-key or bounded-context rename requests.
4. Apply the shared rules from `./assets/eleuthia-py-logger.tpl.md` before the exact code bundles.
5. Materialize the exact file contents from `./scripts/eleuthia-py-logger.logger.py.tpl.md` into the target app while preserving the governed relative paths.
6. Apply the logger-specific example-env content from `./scripts/eleuthia-py-logger.example-env.tpl.md` to the resolved destination.
7. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned code and example-env content verbatim.
8. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
9. Validate the result against `./assets/eleuthia-py-logger.checklist.md`, the shared template, every support bundle under `./scripts/`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared layer rules remain attributable to `./assets/eleuthia-py-logger.tpl.md`.
- Validate that logger code remains attributable to `./scripts/eleuthia-py-logger.logger.py.tpl.md` and stays isolated from `environment/`.
- Validate that logger-specific example-env content remains attributable to `./scripts/eleuthia-py-logger.example-env.tpl.md`.
- Validate that the result emits only the files, example-env content, and unresolved inputs allowed by the owned assets and this skill.
- Validate that no dependency-manifest changes are emitted during normal logger-layer execution because the owned logger code is stdlib-only.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/eleuthia-py-logger.tpl.md`.
  3. `./assets/eleuthia-py-logger.checklist.md`.
  4. `./scripts/eleuthia-py-logger.logger.py.tpl.md`.
  5. `./scripts/eleuthia-py-logger.example-env.tpl.md`.
  6. Existing repository evidence for the target Python app and current env-file layout.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, example-env destination detection, and application of explicit rename requests to the owned code after the exact bundle is placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/eleuthia-py-logger.tpl.md` and `./assets/eleuthia-py-logger.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/` before artifact generation begins.
- Apply the shared template before the owned code bundles.
- Apply example-env content from the dedicated asset without merging unrelated content unless the user explicitly requests it.
- Use the exact file contents from the owned code bundle before applying any explicit user-requested rename or merge behavior.
- For identical repository state and user inputs, the resulting logger-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/eleuthia-py-logger.checklist.md` together with this skill, `./assets/eleuthia-py-logger.tpl.md`, and every owned support bundle under `./scripts/` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate `environment/`, connectors, `src/config/`, CI/CD artifacts, or unrelated scaffolding in the same run.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not modify dependency manifests during normal logger-layer execution unless the user explicitly requests a bounded change outside this skill's current stdlib-only scope.
- Do not reintroduce imports from `environment/env_config.py` or `environment/env_vars_mapper.py` into `logger/`.
- Do not widen the logger example-env block into connector-specific or secret-bearing content.
- Do not weaken the exact owned file contents unless the user explicitly requests a bounded change.
- Do not introduce secrets or credentials into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.