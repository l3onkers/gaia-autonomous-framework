# Python Frontend Usage Readme Bundle

Bundle: `add-layer-py-frontend`
Status: Active
Target path: `frontend/README.md`

Use the following exact file content unless the user explicitly requests a bounded adaptation:

~~~markdown
# frontend/

Generic Streamlit frontend for interacting with the backend API.

## Files

- `app.py`: generic Streamlit renderer that builds the active UI from metadata.
- `api_client.py`: backend HTTP wrapper and response parsing helpers.
- `frontend_metadata.json`: desired-shape metadata for tabs, sections, actions, and connection defaults.
- `metadata_profiles/*.json`: optional alternate metadata profiles for exercising other supported frontend shapes.

## Run

Use your configured Python environment:

~~~bash
streamlit run frontend/app.py
~~~

The app reads `BACKEND_API_BASE_URL` when it is present, but the operator can override the backend URL in the sidebar.
The app reads `FRONTEND_METADATA_PATH` when it is present so a different metadata profile can be activated without editing `app.py`.

## Metadata Contract

- Supported screen kinds: `overview`, `resource`, `request-console`.
- Supported resource section kinds: `summary`, `table`, `action`.
- Supported input types for metadata-driven forms: `text`, `textarea`, `number`, `json`, `date`, `select`.
- Resource actions can declare `refresh_sections` so related preview tables refresh automatically after successful writes or imports.
- Resource screens can declare `always_visible_section_ids`, `default_mode_id`, and `resource_modes` so general information stays visible while action groups are revealed through a screen-mode selector.
- Metadata validation is strict about required fields per screen kind, section kind, request definition, and input definition.
- The concrete screen set is defined in `frontend_metadata.json` rather than hard-coded in `app.py`.

## Current Starter Screens

- `Overview`: endpoint catalogue and a connectivity probe.
- `Incentives`: dataset summary stays visible, while source preview, persisted preview, and contract-management actions are selected through screen modes.
- `Navigation Prices`: dataset summary stays visible, while persisted previews, CRCO management, terminal-rate management, and bulk import are selected through screen modes.
- `Raw Console`: guided request builder that narrows from backend category to method to endpoint, then renders the expected params/body inputs from metadata; custom mode remains available for arbitrary calls.

## Alternate Metadata Profiles

- `metadata_profiles/minimal-console.json`: overview plus raw console for broad exploratory API access.
- `metadata_profiles/navigation-ops.json`: navigation-focused operator workspace with overview, import trigger, and persisted-rate tables.

Activate a profile by setting `FRONTEND_METADATA_PATH`, for example:

~~~bash
$env:FRONTEND_METADATA_PATH = "frontend/metadata_profiles/minimal-console.json"
streamlit run frontend/app.py
~~~

## Extension Rules

- Keep generic request/response behavior in `app.py` and transport details in `api_client.py`.
- Add or change screens by editing `frontend_metadata.json` or creating another file under `metadata_profiles/` before changing the generic renderer.
- Prefer metadata-defined guided forms for write operations before falling back to raw JSON entry.
- Prefer metadata-driven follow-up refresh behavior for preview tables instead of hard-coding screen-specific reload logic.
- Prefer metadata-defined screen modes when a resource screen needs clearer grouping than a long vertical list of sections.
- The raw console should derive guided categories, methods, endpoints, and expected request inputs from the active metadata before introducing any hand-maintained request catalogue.
- Do not copy backend business logic into the frontend layer.
~~~

Rules:
- Keep the frontend-local README focused on running and extending the current operator console.
- Do not document workflows that are not represented in the metadata contract.