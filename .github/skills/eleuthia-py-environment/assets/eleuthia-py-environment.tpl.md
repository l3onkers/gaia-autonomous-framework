# Python Environment Layer Template

Bundle: `eleuthia-py-environment`
Status: Active

## 1. Objective

Provide the shared environment-layer governance applied before the isolated support bundles in `./scripts/` and the governed validation assets in `./assets/`.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the environment layer must be created or updated.
2. `requirements.txt` destination when the target path does not make it obvious where the owned environment block should be placed.
3. Example-env destination when the target path does not make it obvious where the owned environment bootstrap block should be placed.
4. Whether existing `environment/` files should be replaced, merged, or skipped when exact owned code conflicts with existing local files.
5. Any explicit env-key rename requests that must be applied after the exact code bundle is placed.

## 3. Deliverables

When governed Python environment-layer generation is requested, the shared template MUST allow only:
- `environment/`
- Environment-specific dependency-manifest content aligned with the dedicated dependency asset
- Environment-specific example-env content aligned with the dedicated example-env asset
- Short list of unresolved variables or inputs still needed from the user

Do not generate logger, connectors, `src/config/`, CI/CD, or unrelated scaffolding unless the user explicitly requests it.

## 4. Shared Layer Contract

The generated environment layer MUST preserve exactly the project-root layout defined by the owned code bundles.

Mandatory characteristics:
- `environment/` owns env loading, env-key registration, and env-related error handling for the target Python app.
- `environment/env_vars_mapper.py` remains the central registry of env keys consumed by dependent layers such as connectors.
- Dependent layers MAY import `environment.env_config` and `environment.env_vars_mapper`, but they MUST NOT re-own or duplicate those files.
- Environment-specific dependency content owns only the `python-dotenv` package required by the layer.
- Environment-specific `example.env` content owns only the environment bootstrap key `ENV`.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply explicit user-requested renames only after the exact file bundle is in place.
- Keep sample env keys and default values unchanged unless the user explicitly requests a rename.

## 5. Example-Env Expectations

The owned dependency asset defines the authoritative environment-specific dependency block for this layer.
The owned example-env asset defines the authoritative environment-specific example-env content for this layer.
The owned environment code bundles define the authoritative implementation files for `environment/`.

Mandatory characteristics:
- Keep the dependency block limited to the package required for environment loading rather than duplicating connector or test-layer packages.
- Keep example-env values safe for local or placeholder use only; never introduce real secrets.
- Keep the environment-owned example-env block limited to `ENV` rather than duplicating logger or connector-specific keys.
- If the target already has a broader example env, append or merge only the environment bootstrap block unless the user explicitly requests a different bounded edit.

## 6. Guardrails

- Do not reference `PY-Template/` during normal skill execution.
- Do not invent logger, connectors, `src/config/`, object-storage, or CI/CD behavior in this skill.
- Do not duplicate connector, logger, or test-layer packages in the environment-owned dependency block.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not collapse the governed project-root layout into alternative top-level folder structures.

## 7. Output Format

## 1) Summary
- Selected target path
- Layer scope applied
- Dependency-manifest destination
- Example-env destination

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