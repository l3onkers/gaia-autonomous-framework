---
name: add-layer-py-cicd
description: 'Use when: a setup or orchestration workflow must add a governed Python CI/CD layer.'
user-invocable: false
---

# Add Layer Py CI/CD Skill

## Purpose
- This skill owns governed Python CI/CD layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need CI/CD artifacts for Python services.
- This skill stays within the Python CI/CD layer scope and does not route across languages.

## Output Contract
- One Python CI/CD result.
- The owned shared template asset `./assets/add-layer-py-cicd.tpl.md`
- The owned checklist asset `./assets/add-layer-py-cicd.checklist.md`
- The owned language template asset `./assets/add-layer-py-cicd.py.tpl.md`

If the request is not a Python CI/CD layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets:
  - `./assets/add-layer-py-cicd.tpl.md`
  - `./assets/add-layer-py-cicd.py.tpl.md`
- Owned `*.checklist.md` assets: `./assets/add-layer-py-cicd.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller or workflow must add or update CI/CD artifacts such as `Jenkinsfile`, `Dockerfile`, or closely related integration guidance for a Python service.
- Explicit user input or repository evidence already establishes the active language as `py`.
- Supported inputs include new CI/CD scaffolding, updates to an existing `Jenkinsfile` or `Dockerfile`, and resolution of Python-specific exclusion patterns, entrypoints, packaging toolchains, and container runtime settings.
- The run needs shared CI/CD governance plus Python-specific CI/CD rules without inventing unsupported build, test, container, or deployment behavior.

## Procedure
1. Confirm the request is a Python CI/CD layer request.
2. Load `./assets/add-layer-py-cicd.tpl.md`, `./assets/add-layer-py-cicd.checklist.md`, and `./assets/add-layer-py-cicd.py.tpl.md`.
3. Collect only the minimum inputs required by the shared template and the Python template, such as service or project name, runtime version, service type, packaging toolchain, entrypoint, test and coverage commands, generated-code exclusions, and whether containerization is required.
4. Apply the shared rules from `./assets/add-layer-py-cicd.tpl.md` before the Python-specific rules in `./assets/add-layer-py-cicd.py.tpl.md`.
5. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
6. Validate the result against `./assets/add-layer-py-cicd.checklist.md`, the shared template, the Python template, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is Python.
- Validate that shared CI/CD rules remain attributable to `./assets/add-layer-py-cicd.tpl.md`.
- Validate that Python-specific rules remain attributable to `./assets/add-layer-py-cicd.py.tpl.md`.
- Validate that the result emits only the artifacts allowed by the shared template, the Python template, and unresolved required inputs that still need user confirmation.
- If the shared template, checklist, or Python template is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/add-layer-py-cicd.tpl.md`.
  3. `./assets/add-layer-py-cicd.checklist.md`.
  4. `./assets/add-layer-py-cicd.py.tpl.md`.
  5. Existing repository evidence for the target language, build files, and CI/CD constraints.
- Shared CI/CD governance in `./assets/add-layer-py-cicd.tpl.md` plus validation rules in `./assets/add-layer-py-cicd.checklist.md` are authoritative for shared behavior.
- `./assets/add-layer-py-cicd.py.tpl.md` is authoritative only for Python-specific build, test, exclusion, containerization, packaging, and runtime-command rules.
- Structural inference is allowed only for discovery of repository build files, reuse of existing entrypoint names, repository-local exclusion patterns, packaging toolchain detection, and version defaults already defined by the shared template or the Python template.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing entrypoints or missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated rules.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/add-layer-py-cicd.tpl.md` and `./assets/add-layer-py-cicd.checklist.md` before generating artifacts.
- Load `./assets/add-layer-py-cicd.py.tpl.md` before artifact generation begins.
- Use canonical placeholders such as `Unknown` when required inputs remain missing.
- Apply shared rules from `./assets/add-layer-py-cicd.tpl.md` before the Python template.
- For identical repository state and user inputs, the resulting CI/CD guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/add-layer-py-cicd.checklist.md` together with this skill, `./assets/add-layer-py-cicd.tpl.md`, and `./assets/add-layer-py-cicd.py.tpl.md` before finalizing.
- Validate that the shared template, checklist, and Python template are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the Python template.
- Validate that no secrets, credentials, or unsupported deployment specifics are introduced.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate .NET or multi-language CI/CD outputs in the same run.
- Do not invent Python build, test, container, packaging, or deployment rules that are not present in `./assets/add-layer-py-cicd.py.tpl.md`.
- Do not weaken shared restrictions from `./assets/add-layer-py-cicd.tpl.md` or `./assets/add-layer-py-cicd.checklist.md`.
- Do not introduce secrets, credentials, or cloud-provider-specific deployment logic unless the user explicitly requests it.
- Do not modify business code or project scaffolding as part of normal CI/CD execution.
- Do not treat the owned template assets as standalone callable skills or agents.