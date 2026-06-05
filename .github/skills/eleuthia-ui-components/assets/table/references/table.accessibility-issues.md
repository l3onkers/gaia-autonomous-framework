# Accessibility Issues — Table

The following issues were identified during a WCAG 2.2 audit of this component. They remain unresolved and must be addressed before using this component in production.

---

## 1. Missing accessible name on `<table>`

**File:** `table.component.html`, line 1
**WCAG:** 1.3.1 Info and Relationships (Level A)

The internal `<table>` element has no `<caption>`, `aria-label`, or `aria-labelledby`. Screen readers will announce an anonymous table, giving users no context about its content or purpose.

**Recommendation:** Expose a `tableLabel` input (type `string`) on `TableComponent` and bind it as `[attr.aria-label]="tableLabel()"` on the `<table>` element. Alternatively, render a visually-hidden `<caption>` using the input value. Document that consumers must always supply this value.

---

## 2. No focus-visible state on table rows

**File:** `table.component.scss`, lines 85–88
**WCAG:** 2.4.7 Focus Visible (Level AA), 2.4.11 Focus Appearance (Level AA, WCAG 2.2)

`tbody tr` changes background colour on `:hover` but there is no equivalent `:focus-within` rule. Keyboard users who tab into a row (e.g. to reach a button or checkbox inside a cell) cannot see which row contains the focused element.

**Recommendation:** Add `tbody tr:focus-within { background-color: var(--color-secondary-5); }` alongside the existing `:hover` rule to provide a visible focus indicator at the row level.

---

## 3. CSS Grid mode breaks native table accessibility semantics

**File:** `table.component.scss`, lines 127–213
**WCAG:** 1.3.1 Info and Relationships (Level A)

When `cssGridTemplateColumns` is provided, the component applies `display: grid` to `<table>`, `<thead>`, `<tbody>`, and `<tr>`. Overriding the default display values of these elements removes their native ARIA role mapping in some screen readers (notably VoiceOver on Safari), causing loss of row count, column count, and cell position announcements.

**Recommendation:** Restore explicit ARIA roles when CSS Grid mode is active: `role="table"` on `<table>`, `role="rowgroup"` on `<thead>` and `<tbody>`, `role="row"` on every `<tr>`. These attributes are redundant in standard display mode but required when `display: grid` overrides the defaults. An alternative approach is to use `display: contents` on `<tr>` elements so they participate in the grid without losing their table-row role.
