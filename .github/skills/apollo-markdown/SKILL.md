---
name: apollo-markdown
description: 'Use when: a user or agent must convert one Markdown file into HTML, PDF, DOCX, TEX, or EPUB with Pandoc using the skill-bundled Pandoc reference and the owned HTML head, template, and logo assets for HTML output.'
user-invocable: true
---

# Markdown Converter

## Purpose
- This skill owns one bounded Markdown conversion path using Pandoc.
- This skill is used by users or agents that need deterministic conversion from one Markdown file into one supported output format.
- This skill stays within Markdown source resolution, target format resolution, Pandoc command construction, and output validation; it does not own site generators, frontend application code, or non-Markdown source conversions.

## Output Contract
- One resolved Pandoc command for exactly one Markdown input and one supported output target.
- One output artifact in exactly one of these target formats: `html`, `pdf`, `docx`, `tex`, or `epub`.
- For HTML output, one standalone HTML result that uses the owned HTML asset set from `./assets/template.html`, `./assets/head.html`, and `./assets/corp-logo.png`, with the template embedding the owned logo asset by default.
- One concise prerequisite note when Pandoc is unavailable locally or when the requested target has an explicit prerequisite declared by `./references/pandoc.md`.

If the request is not a Markdown conversion request, or if the skill cannot resolve exactly one Markdown input file and one supported output target, stop and request clarification.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `Not applicable.`
- Owned `*.checklist.md` assets: `Not applicable.`
- Additional governed inputs:
  - `./references/pandoc.md`
  - `./assets/template.html`
  - `./assets/head.html`
  - `./assets/corp-logo.png`

## When to Use
- A user or agent must turn one Markdown document into exactly one supported Pandoc output format.
- The preferred or repository-standard conversion tool is Pandoc.
- HTML output must use the shared HTML asset set declared in `./assets/template.html`, `./assets/head.html`, and `./assets/corp-logo.png`, with the default logo delivered by the template itself so the HTML remains standalone.
- The task needs deterministic Pandoc installation guidance, command construction, or execution based on the bundled backup reference at `./references/pandoc.md`.

## Procedure
1. Confirm the request is to convert Markdown into one supported output target rather than to a non-Markdown-source or unsupported conversion path.
2. Resolve exactly one input Markdown file and one target output format using the rules in `## Asset Resolution`.
3. Resolve the output path:
   - If the caller provides one explicit output path, use it.
  - Otherwise derive `<input-basename>.<resolved-extension>` alongside the selected Markdown input.
4. Load `./references/pandoc.md` for installation and option guidance, and load `./assets/template.html`, `./assets/head.html`, and `./assets/corp-logo.png` as the fixed HTML asset set for the HTML branch of the conversion path owned by this skill.
5. If Pandoc is unavailable, surface the smallest relevant installation instructions from `./references/pandoc.md` for the current operating system and stop rather than inventing an alternative converter.
6. If the resolved target is `pdf`, note from `./references/pandoc.md` that PDF output requires LaTeX.
7. Construct the target-specific command, preserving quotes around paths that contain spaces:
  - `html`: `pandoc <input> -s -o <output> --template=.github/skills/apollo-markdown/assets/template.html --include-in-header=.github/skills/apollo-markdown/assets/head.html`
  - `pdf`, `docx`, `tex`, `epub`: `pandoc <input> -s -o <output>`
8. Add extra Pandoc flags only when they are explicitly requested by the caller or explicitly required by the selected Markdown source or target format.
9. If the caller explicitly wants to override the embedded standalone logo, allow `-V logo=<path-or-url>` as an intentional override of the template default.
10. Execute the command when the caller wants the conversion performed; otherwise return the exact command and expected output path.
11. Validate the executed result or the generated command using `## Validation and Compliance Decision Rules` and `## Validation` before finalizing.

## Validation and Compliance Decision Rules
- Validate that exactly one Markdown input file, one supported target output format, and one output path are resolved.
- Validate that the owned command uses `pandoc`, `-s`, and `-o <output>`.
- Validate that HTML output uses `--template=.github/skills/apollo-markdown/assets/template.html` and `--include-in-header=.github/skills/apollo-markdown/assets/head.html`.
- Validate that HTML output is standalone by default because the template embeds the owned logo asset, and treat `-V logo=<path-or-url>` as an explicit optional override only when requested.
- Validate that `pdf`, `docx`, `tex`, and `epub` outputs do not claim HTML-only asset injection as part of their baseline command.
- Validate that `./references/pandoc.md`, `./assets/template.html`, `./assets/head.html`, and `./assets/corp-logo.png` remain the explicit bundled inputs for this conversion path, with the HTML asset set applying only to HTML output.
- If Pandoc is unavailable, validate that the response gives installation guidance from `./references/pandoc.md` instead of inventing another toolchain.
- If the resolved target is `pdf`, validate that any prerequisite note cites LaTeX from `./references/pandoc.md`.
- If the skill cannot satisfy the request without guessing the input file, target format, output path, or Pandoc options, stop and request clarification.
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.

## Asset Resolution
- Input Markdown designation forms, in descending priority:
  1. One exact readable `.md` path explicitly provided by the caller.
  2. The active editor file when it is a readable `.md` file and the caller does not designate a different input.
  3. One Markdown file unambiguously named in the caller's request.
- Ignore `./references/pandoc.md` as a conversion target unless the caller explicitly names it as the source document.
- If more than one candidate Markdown input remains after applying the priority rules, stop and request clarification.
- Target format designation forms, in descending priority:
  1. One explicit supported output extension on a caller-provided output path: `.html`, `.pdf`, `.docx`, `.tex`, or `.epub`.
  2. One explicit supported target keyword in the caller's request: `html`, `pdf`, `docx`, `word`, `tex`, `latex`, or `epub`.
  3. Default to `html` when the caller does not specify a target format.
- Normalize `word` to `docx` and `latex` to `tex`.
- If the caller provides conflicting target designations, such as a `.pdf` output path with an `html` target request, stop and request clarification.
- The HTML asset set is fixed to `./assets/template.html`, `./assets/head.html`, and `./assets/corp-logo.png` for HTML output in the conversion path owned by this skill and is not user-selectable unless the caller explicitly asks to bypass this skill contract.
- For HTML output, the template embeds the owned logo asset by default; `logo` is optional and only used when the caller explicitly requests an override.

## Evidence Rules
- Prioritize evidence in this order:
  1. Explicit user input naming the Markdown source, target format, output path, or required Pandoc options.
  2. `./references/pandoc.md`.
  3. `./assets/template.html`.
  4. `./assets/head.html`.
  5. `./assets/corp-logo.png`.
  6. Current workspace evidence for the selected Markdown file and its existing metadata.
- `./references/pandoc.md` is authoritative for installation guidance, supported output targets, prerequisite notes, and supported Pandoc option examples used by this skill.
- `./assets/template.html` is authoritative for the standalone HTML shell used by this skill.
- `./assets/head.html` is authoritative only for the shared document-head styling injected into standalone HTML output.
- `./assets/corp-logo.png` is authoritative for the owned logo content embedded by the template and for any caller-requested `logo` override source.
- Structural inference is allowed only for deriving the default output path from the resolved input Markdown file and for quoting file paths that contain spaces.
- Any inferred statement MUST be labeled exactly as `Inferred (source: <path>:<anchor-or-symbol>, confidence: <High|Medium|Low>)`.
- Do not infer unsupported target formats, non-Markdown source conversions, alternate converters, or extra Pandoc flags.

## Determinism Rules
- Determinism strategy for this skill is Strict.
- For identical user input, repository state, and tool availability, input resolution, output path derivation, and command construction MUST be functionally identical.
- If the caller does not provide a target format, default to `html`.
- If the caller does not provide an output path, derive `<input-basename>.<resolved-extension>` in the same directory as the input Markdown file.
- Normalize `word` to `docx` and `latex` to `tex` before command construction.
- HTML output uses the bundled HTML asset set; `pdf`, `docx`, `tex`, and `epub` use the target-specific baseline command without HTML asset injection.
- HTML output uses the bundled HTML asset set and embeds the owned logo by default.
- If the caller does not provide extra flags, use only the target-specific baseline command for this skill.
- When ambiguity remains after applying `## Asset Resolution`, stop and request clarification instead of scanning for additional candidates or guessing.

## Validation
- If the command is executed, validate that the output artifact exists at the resolved path and that the conversion completed without a Pandoc error.
- If the command is not executed, validate that the returned command is runnable as written and references the resolved input and output paths, plus `.github/skills/apollo-markdown/assets/template.html` and `.github/skills/apollo-markdown/assets/head.html` when the target is HTML.
- If the command includes `-V logo=...`, validate that it was explicitly requested as an override of the embedded default.
- Validate that the baseline command remains attributable to `./references/pandoc.md`, `./assets/template.html`, `./assets/head.html`, and `./assets/corp-logo.png`, with the HTML asset set applying only to HTML output.
- Validate that the skill does not widen scope to unsupported conversion formats, non-Markdown source conversions, site generators, or repository-wide Markdown batch processing unless the caller explicitly requests a different skill.

## Constraints
- Do not switch to another Markdown converter when Pandoc is unavailable.
- Do not invent CSS, HTML head content, output targets, or Pandoc options beyond what the caller or bundled inputs explicitly support.
- Do not claim that `./assets/template.html`, `./assets/head.html`, or `./assets/corp-logo.png` affect non-HTML outputs.
- Do not require a path-based logo dependency for baseline standalone HTML output.
- Do not convert more than one Markdown file per run unless the caller explicitly requests batch behavior and the skill is revised to own it.
- Do not modify `./references/pandoc.md`, `./assets/template.html`, `./assets/head.html`, or `./assets/corp-logo.png` as part of normal skill execution.