# Python Connectors Layer Template

Bundle: `eleuthia-py-connectors`
Status: Active

## 1. Objective

Provide the shared connectors-layer governance applied before the isolated support bundles in `./scripts/`, the delegated environment layer from `.github/skills/eleuthia-py-environment/SKILL.md`, and the governed validation assets in `./assets/`.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the connectors layer must be created or updated.
2. `requirements.txt` destination when the target does not make it obvious where the owned connectors block should be placed.
3. Example-env destination when the target path does not make it obvious where the owned env block should be placed.
4. Whether existing `environment/`, `logger/`, `connectors/`, or `src/config/` files should be replaced, merged, or skipped when exact owned code conflicts with existing local files.
5. Any explicit logical connection-name or env-key rename requests that must be applied after the exact code bundle is placed.

## 3. Deliverables

When governed Python connectors-layer generation is requested, the shared template MUST allow only:
- Delegated environment-layer application aligned with `.github/skills/eleuthia-py-environment/SKILL.md`
- Connectors-owned optional logging helper aligned with the dedicated logging asset
- `connectors/database/`
- `connectors/sftp/`
- `connectors/utils/`
- `src/config/db/`
- `src/config/sftp/`
- Dependency-manifest additions aligned with the dedicated dependency asset
- Connectors-specific example-env content aligned with the dedicated example-env asset
- Short list of unresolved variables or inputs still needed from the user

Do not generate API, CI/CD, object-storage, or unrelated scaffolding unless the user explicitly requests it.

## 4. Shared Layer Contract

The generated connectors layer MUST preserve exactly the project-root layout defined by the owned code bundles.

Mandatory characteristics:
- `environment/` is owned by `.github/skills/eleuthia-py-environment/SKILL.md` and MUST be applied before the connectors-owned bundles because the connectors-owned `src/config/*` bundles import `environment.env_config` and `environment.env_vars_mapper`.
- `connectors/utils/` owns `AbstractSystemLogger`, the logging compatibility helper that mirrors `debug`, `info`, `warning`, `error`, and `critical`, accepts an injected logger object, and falls back to structured `print()` output when no logger object is passed.
- `connectors/database/` and `src/config/db/` own runtime DB connector behavior and env-key-backed DB connection resolution.
- `connectors/sftp/` and `src/config/sftp/` own runtime SFTP connector behavior and env-key-backed SFTP connection resolution.
- `requirements.txt` content is owned by a dedicated connectors-specific dependency asset and remains limited to database and SFTP connector packages.
- Connectors-owned `example.env` content is owned by a dedicated example-env asset and remains limited to connector-specific keys.
- Environment-specific `example.env` content MUST come from `.github/skills/eleuthia-py-environment/SKILL.md`.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply `.github/skills/eleuthia-py-environment/SKILL.md` before the connector bundles.
- Apply explicit user-requested renames only after the exact file bundle is in place.
- Keep sample logical names and env keys unchanged unless the user explicitly requests a rename.

## 5. Dependency and Example-Env Expectations

The owned dependency asset defines the authoritative dependency block for this layer.
The owned example-env asset defines the authoritative example-env content for this layer.
The owned environment, logging helper, database, and SFTP code bundles define the authoritative implementation files for their respective subtrees.

Mandatory characteristics:
- Add only the dependency lines present in the owned bundle unless the target packaging manifest requires an explicit equivalent representation.
- Keep the connectors-owned dependency block limited to database and SFTP connector packages rather than environment, logger, pytest, FastAPI, or object-storage packages.
- Keep example-env values safe for local or placeholder use only; never introduce real secrets.
- Keep the connectors-specific env-key block aligned with `.github/skills/eleuthia-py-environment/SKILL.md` and the `src/config/*` registries.
- Do not duplicate the environment-owned bootstrap block in the connectors-owned example-env asset.
- Keep optional logger integration inside connectors-owned Python code by routing logs through `AbstractSystemLogger` instead of making the layer depend on a generated `logger/` subtree.

## 6. Guardrails

- Do not reference `PY-Template/` during normal skill execution.
- Do not invent `src/config/s3` or object-storage behavior in this first connectors-layer skill.
- Do not keep environment code or environment-specific example-env lines inside the connectors-owned `./scripts/`; delegate them to `.github/skills/eleuthia-py-environment/SKILL.md`.
- Do not keep direct imports from `logger.SystemLogger` inside the connectors-owned `./scripts/`.
- Do not keep environment, pytest, FastAPI-extension, runtime-server, or object-storage packages inside the connectors-owned dependency block.
- Do not store script-like owned bundles under `./assets/`; keep them under `./scripts/`.
- Do not change business code or transport code as part of normal layer generation.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not collapse the governed project-root layout into alternative top-level folder structures.

## 7. Output Format

## 1) Summary
- Selected target path
- Layer scope applied
- Dependency-manifest destination

## 2) Files Created or Updated
- ...

## 3) Dependency Additions
```text
<final requirements.txt block>
```

## 4) Example Env Content
```dotenv
<final example env content or block>
```

## 5) Required Inputs / Variables (if any)
- ...