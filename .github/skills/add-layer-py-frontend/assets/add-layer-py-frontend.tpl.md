# Python Frontend Layer Template

Bundle: `add-layer-py-frontend`
Status: Active

## 1. Objective

Provide the shared frontend-layer governance applied before the isolated support bundles in `./assets/` and the governed validation assets in `./assets/`.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Target app or repository path where the frontend layer must be created or updated.
2. `requirements.txt` destination when the target path does not make it obvious where the owned frontend dependency block should be placed.
3. `frontend/` destination when the target path does not make it obvious where the owned frontend files should be placed.
4. Whether existing `frontend/` files should be replaced, merged, or skipped when exact owned code conflicts with local files.
5. Any explicit rename requests for frontend file names or folder names that must be applied after the exact file bundle is placed.

## 3. Deliverables

When governed Python frontend-layer generation is requested, the shared template MUST allow only:
- `frontend/README.md`
- `frontend/app.py`
- `frontend/api_client.py`
- `frontend/frontend_metadata.json`
- `frontend/metadata_profiles/*.json`
- Dependency-manifest additions aligned with the dedicated dependency asset
- Short list of unresolved variables or inputs still needed from the user

Do not generate backend code, JS build tooling, tests, CI/CD, Docker assets, or unrelated scaffolding unless the user explicitly requests them.

## 4. Shared Layer Contract

The generated frontend layer MUST preserve exactly the project-root layout defined by the owned support bundles.

Mandatory characteristics:
- `frontend/app.py` owns the reusable Streamlit application shell for backend interaction.
- `frontend/api_client.py` owns the reusable backend-request wrapper, JSON parsing helpers, and request normalization behavior.
- `frontend/frontend_metadata.json` owns the deterministic desired-shape metadata for tabs, sections, and request actions.
- `frontend/metadata_profiles/*.json` owns optional alternate metadata profiles for other supported frontend shapes.
- `frontend/README.md` owns frontend-local usage guidance and extension rules for future frontend work.
- `requirements.txt` content is owned by a dedicated frontend dependency asset and remains limited to the runtime packages required by the governed frontend shell.
- The layer keeps workflow-specific needs out of `frontend/app.py` and expresses them through `frontend/frontend_metadata.json`.
- The layer supports only the bounded metadata contract declared by the owned assets.
- The layer uses the corporate visual system aligned with `.github/skills/markdown-converter/assets/head.html` and `.github/skills/markdown-converter/assets/corp-logo.png`.
- The raw console is one supported screen kind and is present only when the metadata requests it.

Field-handling rules:
- Use the exact owned support bundles from `./assets/` first.
- Apply explicit user-requested renames only after the exact file bundle is in place.
- Keep the frontend shell generic and metadata-driven unless the user explicitly requests a bounded adaptation.

## 5. Frontend Interaction Expectations

The owned dependency asset defines the authoritative dependency block for this layer.
The owned runtime bundles define the authoritative interactive shell, request helper, and usage guidance for this layer.

Mandatory characteristics:
- Use `streamlit` for the operator-facing UI.
- Use `requests` for backend HTTP calls.
- Keep the frontend code focused on a reusable rendering engine rather than a hard-coded workflow UI.
- Allow operators to set the backend base URL and timeout from the sidebar.
- Express the screen set, screen labels, request definitions, and supported section behavior through `frontend/frontend_metadata.json`.
- Allow alternate governed profiles to be selected through an explicit metadata-path override instead of changing `frontend/app.py`.
- Support metadata screen kinds `overview`, `resource`, and `request-console`.
- Support metadata resource section kinds `summary`, `table`, and `action`.
- Support metadata-defined request inputs that can render text, textarea, numeric, JSON, date, and select widgets when the screen metadata asks for them.
- Support metadata-defined section refresh hooks so successful write or import actions can repopulate dependent preview sections without hard-coded workflow branches.
- Support metadata-defined resource screen modes so always-visible general information can stay on screen while a selected mode reveals only the pertinent grouped sections.
- Validate metadata root fields, request definitions, screen definitions, section definitions, and input definitions before rendering.
- Expose response status, headers, and body without assuming a response schema.
- Keep parsing and transport logic in `frontend/api_client.py`, not inline in the Streamlit view.
- Let the raw console guide the user through category, method, endpoint, and expected request inputs when metadata provides enough request detail.
- Preserve the current branded header, button typography, palette, and card treatments derived from the corporate styling assets.
- If the user wants additional workflow coverage, express it by explicit metadata updates before changing the generic rendering engine.

## 6. Guardrails

- Do not introduce unsupported metadata screen kinds or unsupported resource section kinds unless explicitly requested as a bounded change.
- Do not generate JavaScript, TypeScript, or compiled frontend assets in this layer.
- Do not duplicate backend logic inside the frontend helper layer.
- Do not store script-like frontend support bundles outside `./assets/`.
- Do not introduce secrets, credentials, or environment-specific sensitive values.
- Do not widen the dependency block beyond the two required runtime packages unless the user explicitly requests a bounded change.

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

## 4) Frontend Surface Summary
```text
frontend/README.md
frontend/app.py
frontend/api_client.py
frontend/frontend_metadata.json
```

## 5) Required Inputs / Variables (if any)
- ...