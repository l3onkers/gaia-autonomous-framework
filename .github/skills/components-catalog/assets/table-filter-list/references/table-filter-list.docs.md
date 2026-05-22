# Table Filter List documentation

The Table Filter List component is a dropdown filter panel designed to be placed inside a table column header. It renders a card-based panel that can contain a search input, a list of checkbox options, and action buttons. The panel opens and closes via the `isOpen` two-way binding and automatically closes when the user clicks outside of it.

## Best practices

- Always place `corp-table-filter-list` as a sibling of the column header trigger button, inside the same `<th>` cell. The component is absolutely positioned and resolves its offset relative to the nearest positioned ancestor.
- Set `position` to match the column's location in the table: use `'left'` (default) for columns near the left edge, `'right'` for columns near the right edge, and `'center'` for columns in the middle. This prevents the panel from overflowing the viewport.
- Bind `[(isOpen)]` using the same signal reference on both the trigger button and the component so the button's `aria-expanded` attribute stays in sync with the panel state.
- Use the projected `corp-input-text` slot for a search/filter input when the option list is long. Omit it when all available options are already visible.
- Use `corp-input-checkbox` slots for the selectable filter options. Each checkbox should represent a single, discrete filter value.
- Use the `corp-text-button` slot for action buttons such as "Clear filters". Keep to one or two actions to avoid cluttering the panel.
- Do not project content outside of the three defined slots (`corp-input-text`, `corp-input-checkbox`, `corp-text-button`). Unrecognised content will be silently ignored.

### Table Filter List vs. other filter controls

Use `corp-table-filter-list` when filtering applies to a specific column in a `corp-table`. For page-level or form-level filtering (e.g. a filter sidebar or a search bar above a list), use standalone `corp-input-text` and `corp-input-checkbox` components directly — the filter list panel is not appropriate outside of a table column context.

## Content guidelines

Filter panel content should help users narrow down table rows quickly. Each element inside the panel should be purposeful and unambiguous.

- Search input placeholder text should describe what the user is filtering by, not a generic prompt. Prefer "Search by name" over "Search…".
- Checkbox labels must match the exact values shown in the table column. Avoid abbreviations or synonyms that differ from the cell content.
- Include a count next to each checkbox label (e.g. "12") when it helps the user understand how many rows match that option before applying the filter.
- Action button labels must describe the action, not the component. Use "Clear filters" rather than "Reset" or an icon alone.
- Keep the option list short enough to avoid scrolling. If there are many options, the search input becomes mandatory to remain usable.

## Related components

- **InputText** (`corp-input-text`) — projected into the first slot to provide a search field within the panel.
- **InputCheckbox** (`corp-input-checkbox`) — projected into the first slot to provide the list of filterable options.
- **TextButton** (`corp-text-button`) — projected into the second slot for panel action buttons such as "Clear filters".

## Accessibility

The trigger button that opens and closes the panel must have `[attr.aria-expanded]="isOpen()"` bound to the same `isOpen` model passed to `corp-table-filter-list`. Without this, screen reader users have no indication of whether the panel is open.

The trigger button must have `aria-controls` pointing to the panel's `id`. Until the component exposes a `panelId` input, add a static `id` attribute directly on the host element and reference it from the trigger (e.g. `<corp-table-filter-list id="filter-id-col" ...>` and `<button aria-controls="filter-id-col" ...>`).

Icon-only trigger buttons (e.g. a filter icon button in the column header) must have an `aria-label` that describes both the action and the column (e.g. `aria-label="Filter by status"`).

The panel uses `display: none` when closed, which correctly removes it from the accessibility tree. No additional `aria-hidden` is needed on the panel itself.

Action buttons projected via `corp-text-button` must have a visible text label. Do not use icon-only buttons for panel actions — the panel context does not provide enough surrounding text to make an unlabelled icon unambiguous.

When the panel opens, focus is not automatically moved into it. Until this is resolved in the component, consider managing focus manually in your consumer by calling `.focus()` on the first input or checkbox inside the panel after `isOpen` becomes `true`.
