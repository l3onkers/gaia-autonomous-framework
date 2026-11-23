# Python Frontend Layer Skill Checklist

Quality and determinism checklist for `eleuthia-py-frontend` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/eleuthia-py-frontend.tpl.md`
  - `./assets/eleuthia-py-frontend.checklist.md`
  - `./assets/eleuthia-py-frontend.requirements.tpl.md`
  - `./assets/eleuthia-py-frontend.app.py.tpl.md`
  - `./assets/eleuthia-py-frontend.api-client.py.tpl.md`
  - `./assets/eleuthia-py-frontend.metadata.json.tpl.md`
  - `./assets/eleuthia-py-frontend.metadata-profile.minimal-console.json.tpl.md`
  - `./assets/eleuthia-py-frontend.metadata-profile.navigation-ops.json.tpl.md`
  - `./assets/eleuthia-py-frontend.readme.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-frontend.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/eleuthia-py-frontend.checklist.md`
- [ ] `SKILL.md` explicitly references every owned support bundle under `./assets/`
- [ ] `SKILL.md` remains concise and does not embed the owned code bundles verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `eleuthia-py-frontend`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, and all support companions explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Layer Scope and Separation of Responsibilities
- [ ] `./assets/eleuthia-py-frontend.tpl.md` is loaded before the owned support bundles in `./assets/`
- [ ] The allowed scope is limited to `frontend/`, frontend-specific dependency content, and unresolved inputs
- [ ] The base frontend remains generic in code and uses metadata to define the active screen set
- [ ] No backend route, controller, connector, test, Docker, CI/CD, or JS-build behavior is forced into the base frontend layer
- [ ] `frontend/app.py` remains focused on the generic rendering engine rather than hard-coded business workflows
- [ ] `frontend/api_client.py` keeps transport and parsing behavior out of the Streamlit view layer
- [ ] `frontend/frontend_metadata.json` owns the desired-shape screen and section configuration
- [ ] `frontend/metadata_profiles/*.json` provides governed alternate screen sets without changing the renderer
- [ ] `frontend/README.md` provides reusable extension guidance that downstream automation can adapt without guessing the layer boundary
- [ ] Script-like owned bundles live under `./assets/`, not outside the governed skill root
- [ ] Corporate styling remains aligned with `.github/skills/apollo-markdown/assets/head.html` and `.github/skills/apollo-markdown/assets/corp-logo.png`

---

## D. Exact Code Bundle Coverage
- [ ] `./assets/eleuthia-py-frontend.requirements.tpl.md` contains the exact frontend runtime dependency block required by the layer
- [ ] `./assets/eleuthia-py-frontend.app.py.tpl.md` contains the exact Streamlit application shell required by the layer
- [ ] `./assets/eleuthia-py-frontend.api-client.py.tpl.md` contains the exact backend-request helper required by the layer
- [ ] `./assets/eleuthia-py-frontend.metadata.json.tpl.md` contains the deterministic desired-shape metadata starter required by the layer
- [ ] The owned metadata-profile assets contain deterministic alternate frontend shapes for the same renderer
- [ ] `./assets/eleuthia-py-frontend.readme.tpl.md` contains the exact frontend usage guidance required by the layer
- [ ] The skill applies the exact owned file contents before any explicit rename or merge behavior
- [ ] Frontend dependency guidance, app shell, backend-request helper, and usage guidance remain authoritative for the owned files
- [ ] The application bundle includes the current branded header, metadata-driven tab rendering, metadata-path override handling, stricter metadata validation, resource-screen mode selection for grouped sections, richer metadata-defined form widgets for write actions, metadata-driven follow-up refresh behavior for dependent sections, metadata-derived raw-console category/method/endpoint guidance with rendered request inputs, and button typography treatment

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, templates, or checklist
- [ ] The skill does not instruct backend route creation, connectors, tests, Docker, CI/CD, or business-code modification during normal frontend-layer execution
- [ ] The skill does not force auth flows or hard-coded business dashboards during normal frontend-layer execution
- [ ] Validation runs against `eleuthia-py-frontend.checklist.md` together with `SKILL.md`, `eleuthia-py-frontend.tpl.md`, every owned support bundle under `./assets/`, `.github/skills/apollo-markdown/assets/head.html`, and `.github/skills/apollo-markdown/assets/corp-logo.png`
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state