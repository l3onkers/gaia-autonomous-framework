---
name: eleuthia-ui-components
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

- **example-component** â€” `company-example, [company-example]` â€” Template showing the expected skill format. Replace with real components.
- **badge** â€” `corp-badge, [corp-badge]` â€” Displays a small badge with text or icon.
- **body-text** â€” `corp-body-text, [corp-body-text]` â€” Standard text component for body content.
- **button** â€” `corp-button, [corp-button]` â€” Clickable button element.
- **card** â€” `corp-card, [corp-card]` â€” Container for grouping related content.
- **error-message** â€” `company-error-message, [company-error-message]` â€” Displays an error message.
- **feedback-bar** â€” `company-feedback-bar, [company-feedback-bar]` â€” Displays a feedback bar.
- **feedback-box** â€” `company-feedback-box, [company-feedback-box]` â€” Displays a feedback box.
- **header** â€” `corp-header, [corp-header]` â€” Displays a header.
- **icon** â€” `corp-icon, [corp-icon]` â€” Displays an icon.
- **image-filter** â€” `company-image-filter, [company-image-filter]` â€” Applies a filter to an image.
- **image-ratio** â€” `corp-image-ratio, [corp-image-ratio]` â€” Maintains a specific aspect ratio for an image.
- **input-checkbox** â€” `corp-input-checkbox, [corp-input-checkbox]` â€” Checkbox input element.
- **input-radio** â€” `company-input-radio, [company-input-radio]` â€” Radio button input element.
- **input-select** â€” `corp-input-select, [corp-input-select]` â€” Select input element.
- **input-text** â€” `corp-input-text, [corp-input-text]` â€” Text input element.
- **loader-layer** â€” `company-loader-layer, [company-loader-layer]` â€” Displays a loading layer.
- **logo** â€” `corp-logo, [corp-logo]` â€” Displays the company logo.
- **menu** â€” `corp-menu, [corp-menu]` â€” Displays a navigation menu.
- **menu-item** â€” `corp-menu-item, [corp-menu-item]` â€” Represents an item in a menu.
- **overlay** â€” `company-overlay, [company-overlay]` â€” Displays an overlay.
- **paginator** â€” `corp-paginator, [corp-paginator]` â€” Displays pagination controls.
- **paginator-item** â€” `corp-paginator-item, [corp-paginator-item]` â€” Represents an item in a paginator.
- **popin** â€” `corp-popin, [corp-popin]` â€” Displays a popin.
- **popup** â€” `corp-popup, [corp-popup]` â€” Displays a popup.
- **progress-bar** â€” `corp-progress-bar, [corp-progress-bar]` â€” Displays a progress bar.
- **rounded-button** â€” `corp-rounded-button, [corp-rounded-button]` â€” Displays a rounded button.
- **sidebar** â€” `corp-sidebar, [corp-sidebar]` â€” Displays a sidebar.
- **spinner** â€” `corp-spinner, [corp-spinner]` â€” Displays a spinner.
- **strapline-title** â€” `app-subtitle, [app-subtitle]` â€” Displays a strapline title.
- **subtitle** â€” `corp-subtitle, [corp-subtitle]` â€” Displays a subtitle.
- **table** â€” `corp-table, [corp-table]` â€” Displays a table.
- **table-filter-list** â€” `corp-table-filter-list, [corp-table-filter-list]` â€” Displays a table filter list.
- **table-row** â€” `corp-table-row, [corp-table-row]` â€” Represents a row in a table.
- **tag** â€” `corp-tag, [corp-tag]` â€” Displays a tag.
- **text-button** â€” `corp-text-button, [corp-text-button]` â€” Displays a text button.
- **title** â€” `corp-title, [corp-title]` â€” Displays a title.
- **tooltip** â€” `corp-tooltip, [corp-tooltip]` â€” Displays a tooltip.

<!-- Add components here following the same format:
- **{name}** â€” `{selector}` â€” {one-line description}
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
