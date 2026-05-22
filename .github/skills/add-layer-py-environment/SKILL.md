---
name: add-layer-py-environment
description: 'Use when: a setup or orchestration workflow must add a governed Python environment layer from isolated owned support and code bundles.'
user-invocable: false
---

# Add Layer Py Environment Skill

## Purpose
- This skill owns governed Python environment-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable environment layer for Python services.
- This skill stays within the environment-layer scope: `environment/`, environment-specific dependency-manifest content, and environment-specific `example.env` content.

## Output Contract
- One Python environment-layer result.
- The owned shared template asset `./assets/add-layer-py-environment.tpl.md`
- The owned checklist asset `./assets/add-layer-py-environment.checklist.md`
- The owned environment requirements bundle `./scripts/add-layer-py-environment.requirements.tpl.md`
- The owned environment config bundle `./scripts/add-layer-py-environment.env-config.py.tpl.md`
- The owned environment registry bundle `./scripts/add-layer-py-environment.env-registry.py.tpl.md`
- The owned environment example-env bundle `./scripts/add-layer-py-environment.example-env.tpl.md`

If the request is not a Python environment-layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/add-layer-py-environment.tpl.md`
  - `./assets/add-layer-py-environment.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/add-layer-py-environment.requirements.tpl.md`
  - `./scripts/add-layer-py-environment.env-config.py.tpl.md`
  - `./scripts/add-layer-py-environment.env-registry.py.tpl.md`
  - `./scripts/add-layer-py-environment.example-env.tpl.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller or workflow must add or restore the Python environment layer used by a Python service or a broader Python application layer.
- The run needs exact owned code for `environment/`, an environment-specific dependency block, and isolated environment-specific example-env content without depending on `PY-Template/` or another Python layer at execution time.
- Supported inputs include new layer scaffolding, re-adding a deleted environment layer, vendoring the governed environment layer into an existing Python app, and explicit env-key renames requested after the exact bundle is applied.
- The run needs clear separation between environment loading, env-key registration, env-related errors, and dependent layers such as connectors or logger.

## Procedure
1. Confirm the request is a Python environment-layer request.
2. Load `./assets/add-layer-py-environment.tpl.md`, `./assets/add-layer-py-environment.checklist.md`, and every owned support bundle under `./scripts/`.
3. Collect only the minimum required inputs, such as target app root, `requirements.txt` destination, example-env destination, whether existing `environment/` files should be replaced, merged, or skipped, and any explicit env-key rename requests.
4. Apply the shared rules from `./assets/add-layer-py-environment.tpl.md` before the exact code bundles.
5. Materialize the exact file contents from `./scripts/add-layer-py-environment.env-config.py.tpl.md` and `./scripts/add-layer-py-environment.env-registry.py.tpl.md` into the target app while preserving the governed relative paths.
6. Apply the environment-specific dependency-manifest content from `./scripts/add-layer-py-environment.requirements.tpl.md` and the environment-specific example-env content from `./scripts/add-layer-py-environment.example-env.tpl.md` to the resolved destinations without duplicating blocks owned by other layers.
7. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned code and example-env content verbatim.
8. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
9. Validate the result against `./assets/add-layer-py-environment.checklist.md`, the shared template, every support bundle under `./scripts/`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared layer rules remain attributable to `./assets/add-layer-py-environment.tpl.md`.
- Validate that environment dependency guidance remains attributable to `./scripts/add-layer-py-environment.requirements.tpl.md`.
- Validate that environment config code remains attributable to `./scripts/add-layer-py-environment.env-config.py.tpl.md`.
- Validate that env-key registry code remains attributable to `./scripts/add-layer-py-environment.env-registry.py.tpl.md`.
- Validate that environment-specific example-env content remains attributable to `./scripts/add-layer-py-environment.example-env.tpl.md`.
- Validate that the result emits only the files, dependency guidance, example-env content, and unresolved inputs allowed by the owned assets and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/add-layer-py-environment.tpl.md`.
  3. `./assets/add-layer-py-environment.checklist.md`.
  4. `./scripts/add-layer-py-environment.requirements.tpl.md`.
  5. `./scripts/add-layer-py-environment.env-config.py.tpl.md`.
  6. `./scripts/add-layer-py-environment.env-registry.py.tpl.md`.
  7. `./scripts/add-layer-py-environment.example-env.tpl.md`.
  8. Existing repository evidence for the target Python app and current env-file layout.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `requirements.txt` destination detection, example-env destination detection, and application of explicit rename requests to the owned code after the exact bundle is placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/add-layer-py-environment.tpl.md` and `./assets/add-layer-py-environment.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/` before artifact generation begins.
- Apply the shared template before the owned code bundles.
- Apply dependency-manifest content from the dedicated asset without merging unrelated blocks unless the user explicitly requests it.
- Apply example-env content from the dedicated asset without merging unrelated content unless the user explicitly requests it.
- Use the exact file contents from the owned code bundles before applying any explicit user-requested rename or merge behavior.
- For identical repository state and user inputs, the resulting environment-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/add-layer-py-environment.checklist.md` together with this skill, `./assets/add-layer-py-environment.tpl.md`, and every owned support bundle under `./scripts/` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate logger, connectors, `src/config/`, CI/CD artifacts, or unrelated scaffolding in the same run.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not widen the environment-owned dependency block beyond `python-dotenv` unless the user explicitly requests a bounded change.
- Do not widen the environment-owned example-env block beyond `ENV` unless the user explicitly requests a bounded change.
- Do not weaken the exact owned file contents unless the user explicitly requests a bounded change.
- Do not introduce secrets or credentials into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.