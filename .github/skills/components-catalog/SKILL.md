---
name: components-catalog
description: Curated list of corporate components available for mockup generation. Route to owned component reference bundles under ./assets/{name}/references/.
---


# Components Catalog Skill

## Purpose
- This skill owns the curated catalog of Company UI components available for mockup generation and component-guidance routing.
- This skill is used by UI composition workflows that need to discover which components exist before loading the smallest owned reference set for a specific component.
- This skill stays within catalog discovery, component listing, and deterministic routing to owned component reference bundles under `./assets/`.

## Output Contract
- One bounded catalog result listing available corporate components and their selectors
- Deterministic routing guidance to one or more owned component reference bundles under `./assets/`

If the request is outside component-catalog discovery or component-bundle routing, stop and do not modify files.

### Available Components

- **example-component** — `company-example, [company-example]` — Template showing the expected skill format. Replace with real components.
- **badge** — `corp-badge, [corp-badge]` — Displays a small badge with text or icon.
- **body-text** — `corp-body-text, [corp-body-text]` — Standard text component for body content.
- **button** — `corp-button, [corp-button]` — Clickable button element.
- **card** — `corp-card, [corp-card]` — Container for grouping related content.
- **error-message** — `company-error-message, [company-error-message]` — Displays an error message.
- **feedback-bar** — `company-feedback-bar, [company-feedback-bar]` — Displays a feedback bar.
- **feedback-box** — `company-feedback-box, [company-feedback-box]` — Displays a feedback box.
- **header** — `corp-header, [corp-header]` — Displays a header.
- **icon** — `corp-icon, [corp-icon]` — Displays an icon.
- **image-filter** — `company-image-filter, [company-image-filter]` — Applies a filter to an image.
- **image-ratio** — `corp-image-ratio, [corp-image-ratio]` — Maintains a specific aspect ratio for an image.
- **input-checkbox** — `corp-input-checkbox, [corp-input-checkbox]` — Checkbox input element.
- **input-radio** — `company-input-radio, [company-input-radio]` — Radio button input element.
- **input-select** — `corp-input-select, [corp-input-select]` — Select input element.
- **input-text** — `corp-input-text, [corp-input-text]` — Text input element.
- **loader-layer** — `company-loader-layer, [company-loader-layer]` — Displays a loading layer.
- **logo** — `corp-logo, [corp-logo]` — Displays the company logo.
- **menu** — `corp-menu, [corp-menu]` — Displays a navigation menu.
- **menu-item** — `corp-menu-item, [corp-menu-item]` — Represents an item in a menu.
- **overlay** — `company-overlay, [company-overlay]` — Displays an overlay.
- **paginator** — `corp-paginator, [corp-paginator]` — Displays pagination controls.
- **paginator-item** — `corp-paginator-item, [corp-paginator-item]` — Represents an item in a paginator.
- **popin** — `corp-popin, [corp-popin]` — Displays a popin.
- **popup** — `corp-popup, [corp-popup]` — Displays a popup.
- **progress-bar** — `corp-progress-bar, [corp-progress-bar]` — Displays a progress bar.
- **rounded-button** — `corp-rounded-button, [corp-rounded-button]` — Displays a rounded button.
- **sidebar** — `corp-sidebar, [corp-sidebar]` — Displays a sidebar.
- **spinner** — `corp-spinner, [corp-spinner]` — Displays a spinner.
- **strapline-title** — `app-subtitle, [app-subtitle]` — Displays a strapline title.
- **subtitle** — `corp-subtitle, [corp-subtitle]` — Displays a subtitle.
- **table** — `corp-table, [corp-table]` — Displays a table.
- **table-filter-list** — `corp-table-filter-list, [corp-table-filter-list]` — Displays a table filter list.
- **table-row** — `corp-table-row, [corp-table-row]` — Represents a row in a table.
- **tag** — `corp-tag, [corp-tag]` — Displays a tag.
- **text-button** — `corp-text-button, [corp-text-button]` — Displays a text button.
- **title** — `corp-title, [corp-title]` — Displays a title.
- **tooltip** — `corp-tooltip, [corp-tooltip]` — Displays a tooltip.

<!-- Add components here following the same format:
- **{name}** — `{selector}` — {one-line description}
-->

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `Not applicable.`
- Owned `*.checklist.md` assets: `Not applicable.`
- Additional governed inputs:
	- `./assets/*/references/*.contract.md`
	- `./assets/*/references/*.docs.md`
	- `./assets/*/references/*.accessibility-issues.md`
	- `./assets/*/assets/*`

## When to Use
- The run needs to discover which corporate components are available before selecting one.
- The run needs the selector or one-line description for a supported corporate component.
- The run needs routing guidance to the smallest owned reference set for a specific component.
- The run needs a bounded component list for mockup generation without loading every component bundle.

## Procedure
1. Determine whether the request asks for catalog discovery, one specific component, or a bounded set of components.
2. Use this catalog as the authoritative source for the available component names, selectors, and one-line descriptions.
3. If the request uses selectors such as `corp-badge`, `corp-button`, or `[corp-title]`, map them to the matching catalog entry by exact selector text when possible.
4. When the request is ambiguous, surface the current valid component catalog and ask the caller to choose one or more exact component names.
5. Keep the working set bounded to the minimum number of component bundles required by the request instead of loading the full component inventory.
6. For a migrated component, route by intent to the owned reference bundle under `./assets/<name>/references/`:
	- contract questions -> `./assets/<name>/references/<name>.contract.md`
	- usage, examples, best practices, and semantic guidance -> `./assets/<name>/references/<name>.docs.md`
	- accessibility risk or known issues -> `./assets/<name>/references/<name>.accessibility-issues.md` when it exists
	- implementation-level style evidence -> relevant files under `./assets/<name>/assets/` only when explicitly needed
7. If a requested component is not listed in this catalog or the needed owned reference material is missing, stop and request clarification or repair instead of inventing component details.

## Validation and Compliance Decision Rules
- Validate that the catalog remains attributable to this skill and the owned component bundles under `./assets/`.
- Validate that component routing uses exact catalog names and exact component paths under `./assets/<name>/`.
- Validate that the available-component inventory in this skill remains preserved unless explicit repository evidence changes it.
- Validate that this catalog does not invent component APIs, tokens, or examples beyond what is declared in the selected component bundle.
- Validate that direct reference-bundle routing under `./assets/*/references/` is the preferred owned discovery pattern.
- Keep the available-component list in this skill as the authoritative discovery inventory for catalog requests.
- Use exact catalog component names as the routing token for `./assets/<name>/`.
- Do not infer undocumented component behavior from selectors or names alone; component details come from the routed owned references.
- Given identical requests and repository state, the resolved component list and routed component bundle set MUST be functionally identical.
- Do not treat this catalog as the source of truth for component APIs, tokens, or usage examples beyond the catalog entries themselves.
- Do not load every component bundle when a bounded request can be satisfied by the catalog or a smaller subset.
- Do not invent new component names, selectors, or descriptions that are not explicitly present in the owned catalog.
- Do not route to component bundles outside `./assets/`.
- Do not route through legacy per-component `SKILL.md` files; the owned reference bundles are the authoritative component detail source.
- If the skill cannot satisfy the request without guessing, stop and request clarification.
