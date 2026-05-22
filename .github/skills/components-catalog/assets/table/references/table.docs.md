# Table documentation

The Table component is a structured data display component that organises rows into a styled card with an optional header, body, footer, and shadow. It supports a zebra-stripe variant and an optional CSS Grid column layout for advanced column-width control.

## Best practices

- Always project at least one `corp-table-row` with `slot="head"` to give the table a visible column header row. Headerless tables are hard to scan and inaccessible.
- Use `slot="body"` on every data row. Rows projected without a slot fall into the default `ng-content` slot (the footer area) and will not appear inside `<tbody>`.
- Use the footer slot (default `ng-content`) for pagination controls and results counts. The footer hides itself automatically when empty.
- Use `variant="zebra"` when the table has many rows with similar content — the alternating row background helps users track across columns.
- Set `[hasShadow]="false"` when embedding the table inside a card or panel that already provides elevation, to avoid double shadow stacking.
- Use `cssGridTemplateColumns` only when you need precise column widths that differ across columns. For uniform columns, the native table layout (default) is simpler and has better accessibility support.
- Keep column count consistent between head and body rows. Mismatched column counts break the visual alignment and the screen reader row/column position announcements.

### Table vs. list components

Use `corp-table` when data is inherently tabular — it has defined columns that apply to all rows. Use a list or card-based layout when rows represent heterogeneous items where the column concept does not apply.

## Content guidelines

Column headers should be concise — one or two words — and should describe the data type, not the specific values. Avoid restating the row content in the header (e.g. prefer "Date" over "Booking date field").

- Write column headers in uppercase to match the `StraplineTitleComponent` visual style used in the stories.
- Avoid wrapping column header text — keep headers to a single line.
- Cell content that can overflow should use the `is-line-clamp-1`, `is-line-clamp-2`, or `is-line-clamp-3` modifier classes on `<td>` when CSS Grid mode is active.
- Pagination and row-count labels in the footer should clearly state the visible range and total (e.g. "Showing 2 of 120").
- Filter labels and action button labels inside column headers must be meaningful to keyboard and screen reader users — do not rely on icon-only buttons without an accessible label.

## Related components

- **TableRow** (`corp-table-row`) — required companion component; wraps a `<tr>` and its cells. Project with `slot="head"` for the header row and `slot="body"` for each data row.

## Accessibility

> Warning: Pending accessibility issues. This component has known accessibility problems. See the accessibility issues document before using in production.

- The internal `<table>` element has no accessible name. Until the component exposes a dedicated input for this, set `aria-label` directly on the `corp-table` host element to describe the table's content (e.g. `aria-label="Booking list"`).
- When CSS Grid mode is active (`cssGridTemplateColumns` is set), the `display: grid` override on `<table>` and its structural children breaks native table role mapping in some screen readers. Until this is resolved in the component, avoid using `cssGridTemplateColumns` in contexts where screen reader accuracy is critical.
- Icon-only buttons used inside column headers (sort arrows, filter toggles) must have an accessible label. Add `aria-label` directly on the `<button>` element (e.g. `aria-label="Sort by date ascending"`).
- Filter toggle buttons that show or hide a `corp-table-filter-list` must have `aria-expanded` set to reflect the open/closed state, and `aria-controls` pointing to the filter panel's `id`.
- Interactive controls inside cells (checkboxes, switches, text buttons) must each carry an accessible label that identifies both the action and the row context (e.g. `aria-label="Enable David Snow"`).
