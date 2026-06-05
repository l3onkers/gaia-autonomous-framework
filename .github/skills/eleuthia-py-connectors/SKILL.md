---
name: eleuthia-py-connectors
description: 'Use when: a setup or orchestration workflow must add a governed Python connectors layer from isolated owned support and code bundles.'
user-invocable: false
---

# Add Layer Py Connectors Skill

## Purpose
- This skill owns governed Python connectors-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable connectors layer for Python services.
- This skill stays within the connectors-layer scope: `connectors/database/`, `connectors/sftp/`, `connectors/utils/`, `src/config/db/`, `src/config/sftp/`, connectors-specific dependency-manifest content, connectors-specific `example.env` content, and delegated environment-layer integration through `.github/skills/eleuthia-py-environment/SKILL.md`.

## Output Contract
- One Python connectors-layer result.
- The owned shared template asset `./assets/eleuthia-py-connectors.tpl.md`
- The owned checklist asset `./assets/eleuthia-py-connectors.checklist.md`
- The owned dependency bundle `./scripts/eleuthia-py-connectors.requirements.tpl.md`
- The owned example-env bundle `./scripts/eleuthia-py-connectors.example-env.tpl.md`
- The owned logging helper bundle `./scripts/eleuthia-py-connectors.logging.py.tpl.md`
- The owned database bundle `./scripts/eleuthia-py-connectors.database.py.tpl.md`
- The owned SFTP bundle `./scripts/eleuthia-py-connectors.sftp.py.tpl.md`
- The delegated environment layer `.github/skills/eleuthia-py-environment/SKILL.md`

If the request is not a Python connectors-layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/eleuthia-py-connectors.tpl.md`
  - `./assets/eleuthia-py-connectors.checklist.md`
- Owned support bundles under `./scripts/`:
  - `./scripts/eleuthia-py-connectors.requirements.tpl.md`
  - `./scripts/eleuthia-py-connectors.example-env.tpl.md`
  - `./scripts/eleuthia-py-connectors.logging.py.tpl.md`
  - `./scripts/eleuthia-py-connectors.database.py.tpl.md`
  - `./scripts/eleuthia-py-connectors.sftp.py.tpl.md`
- Additional governed inputs:
  - `.github/skills/eleuthia-py-environment/SKILL.md`

## When to Use
- A caller or workflow must add or restore the Python connectors layer for database and SFTP integrations.
- The run needs exact owned code for `connectors/database/`, `connectors/sftp/`, `src/config/db/`, and `src/config/sftp/`, plus isolated support bundles for connectors-specific dependency-manifest content and connectors-specific `example.env` content, without depending on `PY-Template/` at execution time.
- Supported inputs include new layer scaffolding, re-adding a deleted layer, vendoring the governed connectors layer into an existing Python app, and explicit renames of logical connection names or env keys after the exact code bundle is applied.
- The run needs clear separation between delegated environment management, optional runtime logger integration, connectors-specific dependency-manifest content, and connectors-specific example-env content.
- The run must preserve the environment dependency used by the database and SFTP bundles by resolving `.github/skills/eleuthia-py-environment/SKILL.md` before those bundles are applied.
- The run must preserve connectors-owned fallback logging so the database and SFTP bundles can log through an `AbstractSystemLogger` class that mirrors `debug`, `info`, `warning`, `error`, and `critical`, delegates to an injected logger object when available, and falls back to structured `print()` output when no logger is passed.

## Procedure
1. Confirm the request is a Python connectors-layer request.
2. Load `./assets/eleuthia-py-connectors.tpl.md`, `./assets/eleuthia-py-connectors.checklist.md`, every owned support bundle under `./scripts/`, and `.github/skills/eleuthia-py-environment/SKILL.md`.
3. Collect only the minimum required inputs, such as target app root, `requirements.txt` destination, example-env destination, and any explicit logical-name or env-key renames requested by the user.
4. Apply the shared rules from `./assets/eleuthia-py-connectors.tpl.md` before the exact code bundles.
5. Resolve and apply the environment layer from `.github/skills/eleuthia-py-environment/SKILL.md` before the connectors-owned code bundles so the imported `environment.env_config` and `environment.env_vars_mapper` implementations are present.
6. Materialize the exact file contents from `./scripts/eleuthia-py-connectors.logging.py.tpl.md`, `./scripts/eleuthia-py-connectors.database.py.tpl.md`, and `./scripts/eleuthia-py-connectors.sftp.py.tpl.md` into the target app while preserving the governed relative paths.
7. Apply the connectors-specific dependency-manifest content from `./scripts/eleuthia-py-connectors.requirements.tpl.md` and the connectors-specific example-env content from `./scripts/eleuthia-py-connectors.example-env.tpl.md` to the resolved destinations without duplicating blocks owned by the environment, pytest, or FastAPI-test layers.
8. Apply only the explicit renames or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned code and support content verbatim.
9. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
10. Validate the result against `./assets/eleuthia-py-connectors.checklist.md`, the shared template, every support bundle under `./scripts/`, `.github/skills/eleuthia-py-environment/SKILL.md`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared layer rules remain attributable to `./assets/eleuthia-py-connectors.tpl.md`.
- Validate that delegated environment-layer behavior remains attributable to `.github/skills/eleuthia-py-environment/SKILL.md` and is applied before the connectors-owned code bundles.
- Validate that connectors-specific dependency guidance remains attributable to `./scripts/eleuthia-py-connectors.requirements.tpl.md`.
- Validate that connectors-specific example-env content remains attributable to `./scripts/eleuthia-py-connectors.example-env.tpl.md` and excludes the environment-owned bootstrap block and the logger-owned env block.
- Validate that `AbstractSystemLogger` fallback behavior remains attributable to `./scripts/eleuthia-py-connectors.logging.py.tpl.md`.
- Validate that database connector and `src/config/db` code remains attributable to `./scripts/eleuthia-py-connectors.database.py.tpl.md`.
- Validate that SFTP connector and `src/config/sftp` code remains attributable to `./scripts/eleuthia-py-connectors.sftp.py.tpl.md`.
- Validate that the result emits only the files, connectors-specific dependency guidance, example-env content, and unresolved inputs allowed by the owned assets and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/eleuthia-py-connectors.tpl.md`.
  3. `./assets/eleuthia-py-connectors.checklist.md`.
  4. `.github/skills/eleuthia-py-environment/SKILL.md`.
  5. `./scripts/eleuthia-py-connectors.requirements.tpl.md`.
  6. `./scripts/eleuthia-py-connectors.example-env.tpl.md`.
  7. `./scripts/eleuthia-py-connectors.logging.py.tpl.md`.
  8. `./scripts/eleuthia-py-connectors.database.py.tpl.md`.
  9. `./scripts/eleuthia-py-connectors.sftp.py.tpl.md`.
  10. Existing repository evidence for the target Python app and packaging manifest.
- The owned code-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `requirements.txt` destination detection, example-env destination detection, and application of explicit rename requests to the owned code after the exact bundle is placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/eleuthia-py-connectors.tpl.md` and `./assets/eleuthia-py-connectors.checklist.md` before generating artifacts.
- Load every owned support bundle under `./scripts/` and `.github/skills/eleuthia-py-environment/SKILL.md` before artifact generation begins.
- Apply the shared template before the owned code bundles.
- Apply the delegated environment layer before the logging helper, database, and SFTP bundles.
- Apply dependency-manifest and connectors-specific example-env content from their dedicated assets without merging unrelated content unless the user explicitly requests it.
- Keep the connectors-owned dependency block limited to database and SFTP connector packages rather than environment, logger, pytest, FastAPI, or object-storage packages.
- Environment-specific example-env content MUST come from `.github/skills/eleuthia-py-environment/SKILL.md` rather than the connectors-owned example-env asset.
- Keep logger integration optional by routing connector logging through `AbstractSystemLogger`, which accepts an injected logger object, exposes `warning` as the warning-level method, and falls back to structured `print()` output when no logger object is passed.
- Use the exact file contents from the owned code bundles before applying any explicit user-requested rename or merge behavior.
- For identical repository state and user inputs, the resulting connectors-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/eleuthia-py-connectors.checklist.md` together with this skill, `./assets/eleuthia-py-connectors.tpl.md`, every owned support bundle under `./scripts/`, and `.github/skills/eleuthia-py-environment/SKILL.md` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the code bundles.
- Validate that the run remains self-contained and does not rely on `PY-Template/` during normal execution.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate API routes, controllers, services, CI/CD artifacts, or unrelated scaffolding in the same run.
- Do not reference `PY-Template/` as a required runtime dependency for this skill.
- Do not invent `src/config/s3` or object-storage-layer behavior in this first connectors-layer skill.
- Do not keep environment, pytest, FastAPI-extension, runtime-server, or object-storage packages inside the connectors-owned dependency block.
- Do not keep duplicate connectors-owned environment bundles under `./scripts/`; environment ownership belongs to `.github/skills/eleuthia-py-environment/SKILL.md`.
- Do not omit the delegated environment layer when the database or SFTP bundles are applied, because those bundles import `environment.env_config` and `environment.env_vars_mapper`.
- Do not reintroduce direct imports from `logger.SystemLogger` into the connectors-owned bundles.
- Do not weaken the exact owned file contents unless the user explicitly requests a bounded change.
- Do not introduce secrets or credentials into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.