# Table Row documentation

The Table Row component is a structural wrapper that renders a `<tr>` element and accepts only `<th>` and `<td>` cells as projected content. It is designed to be used exclusively inside `corp-table`, where it is distributed into either the `<thead>` or `<tbody>` based on the `slot` attribute.

## Best practices

- Always use `slot="head"` for header rows (those containing `<th>` cells) and `slot="body"` for data rows (those containing `<td>` cells). This controls whether the row lands inside `<thead>` or `<tbody>`.
- Only project `<th>` or `<td>` elements as direct children. Any other element is silently discarded by the `ng-content` selector.
- Keep the number of cells consistent across all rows. A header row with five `<th>` elements requires every body row to also have five `<td>` elements — mismatched column counts break both visual alignment and screen reader position announcements.
- Do not project `corp-table-row` outside of `corp-table`. The component relies on the parent table's CSS Grid subgrid or native table layout to size and position its cells.
- Avoid nesting block-level elements inside `<td>` cells unless necessary. Prefer inline text or a single wrapping `<div>` with utility classes to control alignment.

### Table Row vs. plain `<tr>`

Use `corp-table-row` instead of a plain `<tr>` whenever the content is rendered inside `corp-table`. The component applies the shared BEM class `c-table-row` and participates in the component's variant system. A plain `<tr>` will not receive the correct styles and will break the CSS subgrid layout when grid mode is active.

## Content guidelines

Cell content should be concise and scannable. Avoid sentences or long descriptive text inside table cells — prefer short values, status labels, or interactive controls.

- Header cells (`<th>`) should contain one or two words that describe the data type of the column, not the specific values.
- Data cells (`<td>`) should display a single value or a tightly scoped control (a badge, a switch, a text button). Avoid placing multiple unrelated pieces of content inside the same cell.
- Icon-only controls inside cells must have an accessible label (see Accessibility section).
- Interactive controls inside cells that refer to a specific row should carry a label that identifies both the action and the row context.

## Related components

No related components.

## Accessibility

- Add `scope="col"` to every `<th>` cell in header rows. This associates each header with its column and allows screen readers to announce the column header when reading data cells. Without `scope`, the relationship between headers and data is undefined.
- Add `scope="row"` to `<th>` cells used as row headers (leftmost identifier cells in a data row).
- Icon-only buttons projected inside `<th>` or `<td>` cells (sort arrows, filter toggles, action buttons) must have an accessible label. Add `aria-label` directly on the `<button>` element (e.g. `aria-label="Sort by date ascending"`).
- Interactive controls projected inside data cells that act on a specific row (checkboxes, switches) must carry an `aria-label` that includes the row context (e.g. `aria-label="Enable David Snow"`).
- Do not use `corp-table-row` as a standalone element outside of a table context. The `<tr>` it renders is only valid inside a `<table>` structure, and screen readers rely on that containment to announce row and cell positions.
