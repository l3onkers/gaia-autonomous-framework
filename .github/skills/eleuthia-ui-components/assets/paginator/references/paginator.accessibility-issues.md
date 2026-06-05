# Accessibility Issues — Paginator

These are known accessibility problems identified during the WCAG 2.2 audit. They must be resolved before this component is used in a production interface.

---

## 1. Missing navigation landmark and accessible name on the host

**File:** `paginator.component.ts` / `paginator.component.html`
**WCAG criterion:** 1.3.1 Info and Relationships (Level A), 2.4.1 Bypass Blocks (Level A)

The host element `<corp-paginator>` has no `role="navigation"` and no `aria-label`. Screen reader users cannot identify it as a pagination region, and it provides no landmark for keyboard navigation.

**Recommendation:** Wrap `<corp-paginator>` inside a `<nav aria-label="Pagination">` element, or add `role="navigation"` and an `ariaLabel = input<string>()` to the component host so consumers can supply a translated label.

---

## 2. Disabled items are not communicated to assistive technologies

**File:** `paginator-item/paginator-item.component.html`, `paginator-item/paginator-item.component.scss`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

When `isDisabled` is `true`, the component applies `pointer-events: none` via CSS and the `is-disabled` class. However, the inner `<button>` element remains keyboard-focusable and carries no `disabled` attribute or `aria-disabled="true"`. Screen readers do not announce the disabled state.

**Recommendation:** Bind `[attr.aria-disabled]="isDisabled() || null"` (or `[disabled]="isDisabled()"`) on the inner `<button>` and `<a>` elements inside `paginator-item.component.html`. Also set `tabindex="-1"` when disabled to remove the item from the tab sequence.

---

## 3. Active page item does not communicate current state

**File:** `paginator-item/paginator-item.component.html`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

When `isSelected` is `true`, only a CSS style change is applied. The inner `<button>` has no `aria-current="page"` attribute, so screen readers do not announce which page is currently active.

**Recommendation:** Add `[attr.aria-current]="isSelected() ? 'page' : null"` on the inner `<button>` and `<a>` elements inside `paginator-item.component.html`.

---

## 4. Previous/Next buttons in the `simple` variant can have no accessible name

**File:** `paginator.component.html`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A), 2.4.6 Headings and Labels (Level AA)

In the `simple` variant, the previous/next buttons render a `<corp-icon>` element. When `pagination.texts.prevString` and `pagination.texts.nextString` are not provided, the buttons display only an icon with no visible text and no `aria-label`. The computed accessible name is empty.

**Recommendation:** Either require that `prevString` and `nextString` always be provided (document this as mandatory), or add a fallback `aria-label` on the `<button corp-text-button>` element bound to a new `ariaLabel` input exposed on `PaginatorComponent`.

---

## 5. Ellipsis separators are focusable interactive elements

**File:** `paginator.component.ts` (`getPageObject`), `paginator-item/paginator-item.component.html`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

Ellipsis items are created with `label: '...'` and `isDisabled: true`. They are rendered as `<button>` elements, remain in the tab sequence, and carry the label `...` which is not meaningful for screen readers. They represent visual separators, not interactive controls.

**Recommendation:** In `paginator-item.component.html`, when the item is disabled, set `tabindex="-1"` on the inner button and add `aria-hidden="true"` on the host so the element is skipped by keyboard navigation and removed from the accessibility tree. Alternatively, render ellipsis items as `<span aria-hidden="true">` in the parent `paginator.component.html` instead of using `corp-paginator-item`.
