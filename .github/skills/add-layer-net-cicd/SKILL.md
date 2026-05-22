---
name: add-layer-net-cicd
description: 'Use when: a setup or orchestration workflow must add a governed .NET CI/CD layer.'
user-invocable: false
---

# Add Layer Net CI/CD Skill

## Purpose
- This skill owns governed `.NET` CI/CD layer generation and update behavior.
- This skill is used by setup or orchestration workflows that need CI/CD artifacts for `.NET` applications.
- This skill stays within the `.NET` CI/CD layer scope and does not route across languages.

## Output Contract
- One `.NET` CI/CD result.
- The owned shared template asset `./assets/add-layer-net-cicd.tpl.md`
- The owned checklist asset `./assets/add-layer-net-cicd.checklist.md`
- The owned language template asset `./assets/add-layer-net-cicd.net.tpl.md`

If the request is not a `.NET` CI/CD layer request, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets:
  - `./assets/add-layer-net-cicd.tpl.md`
  - `./assets/add-layer-net-cicd.net.tpl.md`
- Owned `*.checklist.md` assets: `./assets/add-layer-net-cicd.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- A caller or workflow must add or update CI/CD artifacts such as `Jenkinsfile`, `Dockerfile`, or closely related integration guidance for a `.NET` application.
- Explicit user input or repository evidence already establishes the active language as `net`.
- Supported inputs include new CI/CD scaffolding, updates to an existing `Jenkinsfile` or `Dockerfile`, and resolution of `.NET`-specific exclusion patterns, entrypoints, and container runtime settings.
- The run needs shared CI/CD governance plus `.NET`-specific CI/CD rules without inventing unsupported build, test, container, or deployment behavior.

## Procedure
1. Confirm the request is a `.NET` CI/CD layer request.
2. Load `./assets/add-layer-net-cicd.tpl.md`, `./assets/add-layer-net-cicd.checklist.md`, and `./assets/add-layer-net-cicd.net.tpl.md`.
3. Collect only the minimum inputs required by the shared template and the `.NET` template, such as project name, artifact type, runtime version, entrypoint, generated-code exclusions, and whether containerization is required.
4. Apply the shared rules from `./assets/add-layer-net-cicd.tpl.md` before the `.NET`-specific rules in `./assets/add-layer-net-cicd.net.tpl.md`.
5. Surface unresolved required inputs as concise questions or `Unknown` values instead of guessing.
6. Validate the result against `./assets/add-layer-net-cicd.checklist.md`, the shared template, the `.NET` template, and this skill before finalizing.

## Validation and Compliance Decision Rules
- Validate that the active language is `.NET`.
- Validate that shared CI/CD rules remain attributable to `./assets/add-layer-net-cicd.tpl.md`.
- Validate that `.NET`-specific rules remain attributable to `./assets/add-layer-net-cicd.net.tpl.md`.
- Validate that the result emits only the artifacts allowed by the shared template, the `.NET` template, and unresolved required inputs that still need user confirmation.
- If the shared template, checklist, or `.NET` template is missing, incomplete, or marked `To be defined.`, stop and request clarification instead of inventing rules.
- If the skill cannot satisfy the request without guessing, stop and request clarification.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user requirements in the current request.
  2. `./assets/add-layer-net-cicd.tpl.md`.
  3. `./assets/add-layer-net-cicd.checklist.md`.
  4. `./assets/add-layer-net-cicd.net.tpl.md`.
  5. Existing repository evidence for the target language, build files, and CI/CD constraints.
- Shared CI/CD governance in `./assets/add-layer-net-cicd.tpl.md` plus validation rules in `./assets/add-layer-net-cicd.checklist.md` are authoritative for shared behavior.
- `./assets/add-layer-net-cicd.net.tpl.md` is authoritative only for `.NET`-specific build, test, exclusion, containerization, and runtime-command rules.
- Structural inference is allowed only for discovery of repository build files, reuse of existing entrypoint names, repository-local exclusion patterns, and version defaults already defined by the shared template or the `.NET` template.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Missing entrypoints or missing required inputs MUST use `Unknown` or a targeted clarification question instead of fabricated rules.

## Determinism Rules
- Determinism strategy for this skill is Hybrid.
- Load `./assets/add-layer-net-cicd.tpl.md` and `./assets/add-layer-net-cicd.checklist.md` before generating artifacts.
- Load `./assets/add-layer-net-cicd.net.tpl.md` before artifact generation begins.
- Use canonical placeholders such as `Unknown` when required inputs remain missing.
- Apply shared rules from `./assets/add-layer-net-cicd.tpl.md` before the `.NET` template.
- For identical repository state and user inputs, the resulting CI/CD guidance and generated artifacts MUST be functionally identical.

## Validation
- Validate the result against `./assets/add-layer-net-cicd.checklist.md` together with this skill, `./assets/add-layer-net-cicd.tpl.md`, and `./assets/add-layer-net-cicd.net.tpl.md` before finalizing.
- Validate that the shared template, checklist, and `.NET` template are explicitly declared in `## Governance Inputs`.
- Validate that the shared template and checklist are loaded before the `.NET` template.
- Validate that no secrets, credentials, or unsupported deployment specifics are introduced.
- Validate that missing required inputs trigger `Unknown` or targeted clarification instead of guessing.

## Constraints
- Do not generate Python or multi-language CI/CD outputs in the same run.
- Do not invent `.NET` build, test, container, or deployment rules that are not present in `./assets/add-layer-net-cicd.net.tpl.md`.
- Do not weaken shared restrictions from `./assets/add-layer-net-cicd.tpl.md` or `./assets/add-layer-net-cicd.checklist.md`.
- Do not introduce secrets, credentials, or cloud-provider-specific deployment logic unless the user explicitly requests it.
- Do not modify business code or project scaffolding as part of normal CI/CD execution.
- Do not treat the owned template assets as standalone callable skills or agents.