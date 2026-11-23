---
name: eleuthia-ui-styles
description: Utility classnames, grid layout systems, and design tokens for the corporate Angular component library. Use when composing views with company-* components.
---


# Global Styles Skill

## Purpose
- This skill owns guidance for utility classnames, grid layout systems, and design-token usage in the corporate Angular component library.
- This skill is used by Angular UI composition workflows that need deterministic guidance for `company-*` component layouts.
- This skill stays within documentation and usage guidance for the owned eleuthia-ui-styles reference set.

## Output Contract
- One bounded eleuthia-ui-styles guidance result for utility classes, grid systems, and design-token usage
- The owned reference set under `./references/`

If the request is outside Company eleuthia-ui-styles usage guidance, stop and do not modify files.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `Not applicable.`
- Owned `*.checklist.md` assets: `Not applicable.`
- Additional governed inputs:
	- `./references/utility-classnames.md`
	- `./references/grid-systems.md`
	- `./references/design-tokens.md`
	- `./references/quick-reference.md`

## When to Use
- The run needs utility-class usage guidance for `u-*` classes in Angular templates.
- The run needs grid-system guidance for `l-grid-*`, `g-col-*`, or related layout composition.
- The run needs design-token guidance for `var(--*)` usage in SCSS.
- The run needs a compact, deterministic summary of the most commonly used global-style conventions from `./references/quick-reference.md` without replacing the deeper owned references.

## Procedure
1. Determine whether the request is about utility classes, grid systems, design tokens, or a bounded combination of those topics.
2. Use the owned reference set in `./references/` as the authoritative source for detailed guidance.
3. Route quick-summary requests first to `./references/quick-reference.md`, utility-helper requests to `./references/utility-classnames.md`, grid-layout requests to `./references/grid-systems.md`, and token-usage requests to `./references/design-tokens.md`.
4. Provide only the subset of guidance required by the request, while preserving the global-style rules in the owned references.
5. Keep quick-summary guidance attributable to `./references/quick-reference.md`, utility-class guidance attributable to `./references/utility-classnames.md`, grid guidance attributable to `./references/grid-systems.md`, and token guidance attributable to `./references/design-tokens.md`.
6. If the request mixes topics, keep the answer bounded to the minimum compatible combination instead of restating the full reference set.
7. If required detail is missing from the owned references or the request falls outside this guidance scope, stop and request clarification instead of inventing rules.

## Validation and Compliance Decision Rules
- Validate that guidance remains attributable to the owned reference set in `./references/`.
- Validate that utility classes are described for template usage, tokens for SCSS usage, and grid systems for layout composition.
- Validate that semantic-token usage, rem sizing, breakpoint rules, and grid-separation rules remain preserved.
- Validate that quick-summary guidance resolves from `./references/quick-reference.md`.
- Validate that utility helpers resolve from `./references/utility-classnames.md`, grid guidance from `./references/grid-systems.md`, and token guidance from `./references/design-tokens.md`.
- Validate that the usage boundary remains deterministic: `u-*` in templates, `var(--token)` in SCSS, and grid systems separated by layout block.
- Preserve the breakpoint keys and widths exactly as documented in `./references/quick-reference.md` unless the owned reference set changes.
- Preserve the most-used-class semantics exactly as documented in `./references/quick-reference.md` unless the owned reference set changes.
- Given identical requests and reference state, the resolved topic set and resulting guidance MUST be functionally identical.
- Do not use primitive design tokens directly when semantic tokens exist.
- Do not place `var(--token)` usage directly in templates.
- Do not place `u-*` utility helpers inside component SCSS as a replacement for template usage.
- Do not mix `l-grid-*` and `g-col-*` within the same layout block.
- Do not restate or replace the deeper owned references when only one topic is requested; use the minimum relevant guidance instead.
- Validate that the skill does not invent framework behavior outside the owned global-style scope.
- If the skill cannot satisfy the request without guessing, stop and request clarification.
