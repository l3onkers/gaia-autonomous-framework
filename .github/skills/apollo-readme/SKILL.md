---
name: apollo-readme
description: 'Use when: documentator must generate or refresh one in-repository README.md artifact from one caller-provided Markdown template or the best-fitting bundled ./assets/README*.tpl.md asset.'
user-invocable: false
---

# Create Or Update README Skill

## Purpose
- This skill owns template-driven `README.md` generation for `apollo`.
- This skill owns the resolved `README.md` output contract, bundled template asset resolution, and README-specific validation.
- This skill is intentionally repository-documentation-specific; new documentation scopes should be introduced as new skills rather than folded into `apollo`.

## Output Contract
- One resolved in-repository `README.md` artifact
- Default output path: repository-root `README.md`

If template resolution cannot identify exactly one active template after explicit designation, best-fit evaluation, clarification, and final fallback handling, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Template assets: `./assets/README*.tpl.md`
- Validation checklist: [apollo-readme checklist](./assets/apollo-readme.checklist.md)

## When to Use
- The selected documentation skill for `apollo` is `apollo-readme`.
- The task is to generate or refresh technical repository or branch documentation as one in-repository `README.md` artifact.
- The requested document structure comes from one caller-provided Markdown template or one bundled README template asset.

## Asset Resolution
- Output path designation forms, in descending priority:
  1. One explicit readable or writable in-repository path provided by the caller whose basename is exactly `README.md`.
  2. Repository-root `README.md` when the caller does not designate a different output path.
- Output path constraints:
  - The resolved output path MUST stay inside the current repository.
  - The resolved output file basename MUST be exactly `README.md`.
  - Directory-only targets such as `.github/` are treated as shorthand for `<that-directory>/README.md` only when the caller explicitly names exactly one in-repository directory target.
  - If the caller provides multiple conflicting output path designations, stop and request clarification.
  - If the caller provides a target outside the repository or a target whose basename is not `README.md`, stop and request clarification.

## Template Asset Resolution
- Prefer a caller-provided template when one is explicitly supplied.
- Otherwise scan `./assets/` non-recursively for `README*.tpl.md` files and sort them by ascending asset filename.
- Treat every discovered `README*.tpl.md` asset as an equally valid initial candidate.
- `./assets/README.generic.tpl.md` remains part of the candidate set and also acts as the final fallback asset when no stronger bundled match or user selection is available.
- Template label rule:
  - `README.generic.tpl.md` -> stable bundled label `generic`
  - `README.<label>.tpl.md` -> stable bundled label `<label>`
- Catalogue disclosure fields:
  - exact asset filename
  - exact readable asset path
  - derived bundled label
- Best-fit evaluation cues:
  - Use explicit repository evidence together with each candidate template's own scope and structure to determine which discovered asset best matches the repository.
  - `README.agents.tpl.md` is a stronger candidate when explicit evidence shows thin entrypoints under `.github/agents/`, reusable or routed skills under `.github/skills/`, skill-owned `assets/` directories, or shared neutral governance under `.github/governance/`.
  - `README.generic.tpl.md` is a stronger candidate when no discovered specialized template has stronger explicit support.
  - A bundled asset may be auto-selected only when it has stronger explicit support than every other discovered candidate.

Selection rules:
1. If the caller explicitly supplies one template, use it as the active template.
2. Otherwise discover bundled template assets from `./assets/`.
3. If the request explicitly designates exactly one discovered asset by exact asset filename, exact readable asset path, or derived bundled label, use it.
4. If the request explicitly designates one or more assets and that designation set does not resolve to exactly one discovered asset, stop and request clarification.
5. If no explicit asset designation is present, evaluate all discovered bundled assets as equal candidates using the best-fit evaluation cues above.
6. If exactly one candidate has stronger explicit support than every other discovered candidate, use it as the active template.
7. If two or more candidates remain equally plausible, surface the current valid bundled template asset catalogue and ask the user to choose exactly one asset.
8. If no user selection is available for the current run and no single best-fit candidate can be proven, use `./assets/README.generic.tpl.md` as the final fallback.
9. If `README.generic.tpl.md` is missing from the discovered asset set when final fallback is needed, stop and request catalogue repair.

## Evidence Rules
Evidence priority order:
1. Explicit content in the active template selected for the run.
2. Explicit content in [apollo-readme checklist](./assets/apollo-readme.checklist.md).
3. Existing repository documentation (`README*`, `docs/`, ADRs, architecture notes).
4. Explicit build/run artifacts (`Makefile`, `package.json`, `pyproject.toml`, compose files, task files, CI files).
5. Explicit API schemas, specifications, and route declarations.

Inference policy:
- Inference is not allowed for generated README content.
- Best-fit template selection may compare only explicit structural repository evidence against the declared scope of each discovered asset.
- Required values with missing evidence MUST use `To be defined.` or `Unknown`.
- `Not applicable.` is allowed only for sections explicitly marked optional by the active template and only when explicit repository evidence shows the section truly does not apply.

## Procedure
1. Resolve exactly one output path using the rules above, defaulting to repository-root `README.md` only when the caller does not designate a different in-repository `README.md` target.
2. Resolve exactly one active template using the rules above, including explicit designation, deterministic best-fit evaluation, clarification on ambiguity, and final generic fallback when no stronger candidate or user selection is available.
3. Load the selected template and [apollo-readme checklist](./assets/apollo-readme.checklist.md).
4. Initialize the resolved `README.md` output path from the selected template while preserving section order, headings, tables, anchors, and repeated blocks.
5. Build a metadata-only repository index to locate candidate evidence files.
6. Parse the active template into ordered sections, placeholders, tables, links, and instructions.
7. Fill the template section by section using explicit repository evidence only.
8. Use `To be defined.` or `Unknown` for required values when evidence is missing.
9. Use `Not applicable.` only for optional sections when explicit evidence shows they do not apply.
10. Remove template instructions from the final output once fulfilled.
11. Validate the result against [apollo-readme checklist](./assets/apollo-readme.checklist.md) before finalizing.

## Determinism Rules
- Determinism strategy for this skill is Strict.
- If the caller designates exactly one valid in-repository `README.md` target, use that path.
- If the caller does not designate an output path, use repository-root `README.md`.
- If the caller designates exactly one in-repository directory target such as `.github/`, normalize it to `<that-directory>/README.md`.
- If multiple output-path candidates remain after applying the designation rules, stop and request clarification instead of guessing.

## Skill-Specific Constraints
- Modify only the resolved in-repository `README.md` output path for the current run.
- Do not inject sections or headings that do not exist in the selected template.
- When a bundled template asset other than `README.generic.tpl.md` is active, do not import generic-only sections from `README.generic.tpl.md` unless they already exist in that active template.
- Do not return full `README.md` content in chat output.