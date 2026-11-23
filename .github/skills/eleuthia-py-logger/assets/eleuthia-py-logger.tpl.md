# Python Logger Layer Template

Bundle: `eleuthia-py-logger`
Status: Active

## 1. Objective

Provide the shared logger-layer governance applied before the isolated support bundles in `./scripts/` and the governed validation assets in `./assets/`.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the logger layer must be created or updated.
2. Example-env destination when the target path does not make it obvious where the owned logging block should be placed.
3. Whether existing `logger/` files should be replaced, merged, or skipped when exact owned code conflicts with existing local files.
4. Any explicit logger env-key rename or bounded-context rename requests that must be applied after the exact code bundle is placed.

## 3. Deliverables

When governed Python logger-layer generation is requested, the shared template MUST allow only:
- `logger/`
- Logger-specific example-env content aligned with the dedicated example-env asset
- Short list of unresolved variables or inputs still needed from the user

Do not generate dependency-manifest edits, environment management, connectors, CI/CD, or unrelated scaffolding unless the user explicitly requests them.

## 4. Shared Layer Contract

The generated logger layer MUST preserve exactly the project-root layout defined by the owned code bundle.

Mandatory characteristics:
- `logger/` owns the logging facade, log formatting, and runtime logger selection for the target Python app.
- `logger/` MUST read only the raw process env values it needs and MUST NOT import `environment/env_config.py` or `environment/env_vars_mapper.py`.
- Logger-specific `example.env` content owns only `SRV_LOG_STORAGE` and `SRV_BOUNDED_CTX`.
- `logger/` MAY read `ENV` when the host app or another layer already provides it, but this skill does not own broader env management.
- The layer currently requires no dedicated third-party dependency block; keep dependency-manifest edits out of normal logger-layer execution.
- The layer remains self-contained and executable without depending on `PY-Template/` at runtime.

Field-handling rules:
- Use the exact owned support bundles from `./scripts/` first.
- Apply explicit user-requested renames only after the exact file bundle is in place.
- Keep sample env keys and default values unchanged unless the user explicitly requests a rename.

## 5. Example-Env Expectations

The owned example-env asset defines the authoritative logger-specific example-env content for this layer.
The owned logger code bundle defines the authoritative implementation files for `logger/`.

Mandatory characteristics:
- Keep example-env values safe for local or placeholder use only; never introduce real secrets.
- Keep the example-env block limited to logger-specific keys rather than duplicating connector or database env keys.
- If the target already has a broader example env, append or merge only the logging block unless the user explicitly requests a different bounded edit.

## 6. Guardrails

- Do not reference `PY-Template/` during normal skill execution.
- Do not couple `logger/` to `environment/` through imports or wrapper calls.
- Do not modify dependency manifests during normal logger-layer execution.
- Do not invent connectors, `src/config/`, object-storage, or CI/CD behavior in this skill.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not collapse the governed project-root layout into alternative top-level folder structures.

## 7. Output Format

## 1) Summary
- Selected target path
- Layer scope applied
- Example-env destination

## 2) Files Created or Updated
- ...

## 3) Example Env Content
```dotenv
<final example env content or block>
```

## 4) Required Inputs / Variables (if any)
- ...