---
name: eleuthia-py-frontend
description: 'Use when: a setup or orchestration workflow must add a governed Python frontend layer for interactive use against an existing backend API.'
user-invocable: false
---

# Add Layer Py Frontend Skill

## Purpose
- This skill owns governed Python frontend-layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need a reusable Streamlit-based interactive frontend layer for an existing backend API.
- This skill stays within the frontend-layer scope: frontend-specific dependency-manifest content, a metadata-driven and corporate-styled interactive frontend shell under `frontend/`, backend-request helper support, desired-shape metadata under `frontend/`, and frontend-local usage guidance.

## Output Contract
- One Python frontend-layer result.
- The owned shared template asset `./assets/eleuthia-py-frontend.tpl.md`
- The owned checklist asset `./assets/eleuthia-py-frontend.checklist.md`
- The owned frontend dependency bundle `./assets/eleuthia-py-frontend.requirements.tpl.md`
- The owned frontend application bundle `./assets/eleuthia-py-frontend.app.py.tpl.md`
- The owned frontend backend-client bundle `./assets/eleuthia-py-frontend.api-client.py.tpl.md`
- The owned frontend metadata bundle `./assets/eleuthia-py-frontend.metadata.json.tpl.md`
- The owned sample metadata profile bundle `./assets/eleuthia-py-frontend.metadata-profile.minimal-console.json.tpl.md`
- The owned sample metadata profile bundle `./assets/eleuthia-py-frontend.metadata-profile.navigation-ops.json.tpl.md`
- The owned frontend usage-readme bundle `./assets/eleuthia-py-frontend.readme.tpl.md`

If the request is not a Python frontend-layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned governance assets:
  - `./assets/eleuthia-py-frontend.tpl.md`
  - `./assets/eleuthia-py-frontend.checklist.md`
- Owned support bundles under `./assets/`:
  - `./assets/eleuthia-py-frontend.requirements.tpl.md`
  - `./assets/eleuthia-py-frontend.app.py.tpl.md`
  - `./assets/eleuthia-py-frontend.api-client.py.tpl.md`
  - `./assets/eleuthia-py-frontend.metadata.json.tpl.md`
  - `./assets/eleuthia-py-frontend.metadata-profile.minimal-console.json.tpl.md`
  - `./assets/eleuthia-py-frontend.metadata-profile.navigation-ops.json.tpl.md`
  - `./assets/eleuthia-py-frontend.readme.tpl.md`
- Additional governed inputs:
  - `.github/skills/apollo-markdown/assets/head.html`
  - `.github/skills/apollo-markdown/assets/corp-logo.png`

## When to Use
- A caller or workflow must add or restore a Python frontend layer that lets a human operator interact with an existing backend API.
- The run needs exact owned files under `frontend/`, plus a frontend-specific dependency block and a deterministic desired-shape metadata file that defines the active screen set.
- Supported inputs include new frontend-layer scaffolding, re-adding deleted frontend runtime files, vendoring the governed frontend layer into an existing Python app, and explicit rename requests for frontend file names or folder names after the exact bundles are applied.
- The run needs the frontend to remain agnostic to business-specific workflows in code and derive the active UI shape from explicit metadata.
- The run needs the frontend to preserve the current corporate styling derived from the apollo-markdown branding assets.

## Procedure
1. Confirm the request is a Python frontend-layer request.
2. Load `./assets/eleuthia-py-frontend.tpl.md`, `./assets/eleuthia-py-frontend.checklist.md`, every owned support bundle under `./assets/`, and the declared branding inputs.
3. Collect only the minimum required inputs, such as target app root, `requirements.txt` destination when the target path is ambiguous, `frontend/` destination when the target path is ambiguous, whether existing frontend files should be replaced, merged, or skipped, the explicit frontend metadata that defines the desired screen shape when the starter metadata is not sufficient, and any explicit rename requests for frontend file names or folder names.
4. Apply the shared rules from `./assets/eleuthia-py-frontend.tpl.md` before the exact code bundles.
5. Materialize the exact file contents from `./assets/eleuthia-py-frontend.app.py.tpl.md`, `./assets/eleuthia-py-frontend.api-client.py.tpl.md`, `./assets/eleuthia-py-frontend.metadata.json.tpl.md`, `./assets/eleuthia-py-frontend.metadata-profile.minimal-console.json.tpl.md`, `./assets/eleuthia-py-frontend.metadata-profile.navigation-ops.json.tpl.md`, and `./assets/eleuthia-py-frontend.readme.tpl.md` into the target app while preserving the governed relative paths.
6. Apply the frontend-specific dependency-manifest content from `./assets/eleuthia-py-frontend.requirements.tpl.md` to the resolved destination without duplicating unrelated blocks owned by API, connectors, pytest, Docker, or CI/CD layers.
7. Apply only the explicit metadata updates, renames, or small integration edits requested by the user after the owned bundles are placed; otherwise keep the owned code and support content verbatim.
8. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
9. Validate the result against `./assets/eleuthia-py-frontend.checklist.md`, the shared template, every owned support bundle under `./assets/`, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared frontend-layer rules remain attributable to `./assets/eleuthia-py-frontend.tpl.md`.
- Validate that frontend dependency guidance remains attributable to `./assets/eleuthia-py-frontend.requirements.tpl.md`.
- Validate that the interactive frontend shell remains attributable to `./assets/eleuthia-py-frontend.app.py.tpl.md`.
- Validate that backend-request helper behavior remains attributable to `./assets/eleuthia-py-frontend.api-client.py.tpl.md`.
- Validate that the desired-shape metadata remains attributable to `./assets/eleuthia-py-frontend.metadata.json.tpl.md`.
- Validate that each shipped sample metadata profile remains attributable to its owned metadata-profile asset.
- Validate that frontend usage guidance remains attributable to `./assets/eleuthia-py-frontend.readme.tpl.md`.
- Validate that the corporate styling profile remains attributable to `.github/skills/apollo-markdown/assets/head.html`.
- Validate that the branded header remains attributable to `.github/skills/apollo-markdown/assets/corp-logo.png`.
- Validate that the result emits only the files, dependency guidance, and unresolved inputs allowed by the owned assets and this skill.
- If any owned template or checklist asset is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/eleuthia-py-frontend.tpl.md`.
  3. `./assets/eleuthia-py-frontend.checklist.md`.
  4. `./assets/eleuthia-py-frontend.requirements.tpl.md`.
  5. `./assets/eleuthia-py-frontend.app.py.tpl.md`.
  6. `./assets/eleuthia-py-frontend.api-client.py.tpl.md`.
  7. `./assets/eleuthia-py-frontend.metadata.json.tpl.md`.
  8. `./assets/eleuthia-py-frontend.metadata-profile.minimal-console.json.tpl.md`.
  9. `./assets/eleuthia-py-frontend.metadata-profile.navigation-ops.json.tpl.md`.
  10. `./assets/eleuthia-py-frontend.readme.tpl.md`.
  11. `.github/skills/apollo-markdown/assets/head.html`.
  12. `.github/skills/apollo-markdown/assets/corp-logo.png`.
  13. Existing repository evidence for the target Python app and packaging manifest.
- The owned support-bundle assets are authoritative for file contents and relative paths.
- Structural inference is allowed only for target-root normalization, `requirements.txt` destination detection, `frontend/` destination detection, and application of explicit rename requests to the owned code after the exact bundle is placed.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated defaults.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/eleuthia-py-frontend.tpl.md` and `./assets/eleuthia-py-frontend.checklist.md` before generating artifacts.
- Load every owned support bundle under `./assets/` before artifact generation begins.
- Load `.github/skills/apollo-markdown/assets/head.html` and `.github/skills/apollo-markdown/assets/corp-logo.png` before generating the branded frontend shell.
- Apply the shared template before the owned code bundles.
- Apply dependency-manifest content from the dedicated frontend asset without merging unrelated blocks unless the user explicitly requests it.
- Use the exact file contents from the owned support bundles before applying any explicit user-requested rename or merge behavior.
- Keep the interactive frontend generic in code and derive the active tabs, sections, and endpoint actions from `frontend/frontend_metadata.json`.
- Allow profile switching only through an explicit metadata-path override or by replacing the active metadata file, not by changing renderer behavior.
- Keep supported screen kinds limited to the metadata contract declared by the owned assets.
- Keep the corporate styling aligned with the shared apollo-markdown branding assets unless the user explicitly requests a bounded adaptation.
- For identical repository state and user inputs, the resulting frontend-layer guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/eleuthia-py-frontend.checklist.md` together with this skill, `./assets/eleuthia-py-frontend.tpl.md`, and every owned support bundle under `./assets/` before finalizing.
- Validate that the owned governance assets and support bundles are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the exact code bundles.
- Validate that the frontend shell remains self-contained and renders only the supported screen and section kinds declared by the metadata bundle.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate backend routes, controllers, services, connectors, pytest layers, Docker assets, CI/CD artifacts, or unrelated scaffolding in the same run.
- Do not generate a JavaScript, TypeScript, or browser-build pipeline as part of this Python frontend layer.
- Do not widen the frontend-owned dependency block beyond `streamlit` and `requests` unless the user explicitly requests a bounded change.
- Do not invent screen definitions, endpoint families, or screen-specific endpoint actions beyond the explicit metadata supplied for the run.
- Do not hard-code business-specific screens into `frontend/app.py` when they can be expressed in `frontend/frontend_metadata.json`.
- Do not weaken or remove the current corporate styling profile unless the user explicitly requests a bounded change.
- Do not introduce secrets, credentials, or environment-specific sensitive values into tracked files.
- Do not treat the owned template assets as standalone callable skills or agents.