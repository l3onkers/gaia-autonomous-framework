# Accessibility Issues — PaginatorItem

These are known accessibility problems that require attention before this component is used in production.

---

## 1. Missing `aria-current="page"` on the selected item

**File:** `paginator-item.component.ts` / `paginator-item.component.html`
**WCAG criterion:** 1.3.1 Info and Relationships (Level A)

**Problem:** When `isSelected` is `true`, only the CSS class `is-selected` is applied. Screen readers have no programmatic way to identify which page is currently active.

**Recommendation:** The consumer must add `aria-current="page"` to the host element when `isSelected` is `true`. Alternatively, the component should bind `[attr.aria-current]` internally based on the `isSelected` input.

---

## 2. Missing `aria-disabled="true"` on disabled items

**File:** `paginator-item.component.ts` / `paginator-item.component.scss`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

**Problem:** When `isDisabled` is `true`, only the CSS class `is-disabled` is applied and `pointer-events: none` suppresses clicks. Screen readers do not receive any signal that the item is disabled.

**Recommendation:** The consumer must add `aria-disabled="true"` to the host element when `isDisabled` is `true`. Alternatively, the component should bind `[attr.aria-disabled]` internally.

---

## 3. Missing accessible name on arrow-only items

**File:** `paginator-item.component.html`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A) / 2.4.6 Headings and Labels (Level AA)

**Problem:** When `isPrev` or `isNext` is `true` and `label` is empty, the rendered `<button>` contains only a `<corp-icon>` element with no visible text. The icon does not carry an `aria-label`, so the button has no accessible name.

**Recommendation:** The consumer must add `aria-label` to the host element (e.g. `aria-label="Previous page"` / `aria-label="Next page"`) when no label text is provided. Alternatively, the component should expose `ariaLabel = input<string>()` and bind it to the inner `<button>` / `<a>`.

---

## 4. `<a>` element without a valid `href`

**File:** `paginator-item.component.html`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A) / 2.1.1 Keyboard (Level A)

**Problem:** When `routerLink` is provided, the template renders an `<a>` element with `[attr.routerLink]` as a plain HTML attribute. This does not produce a valid `href`, so the anchor is not keyboard-focusable by default and is not announced as a link by screen readers.

**Recommendation:** Use Angular's `RouterLink` directive properly (e.g. bind `[routerLink]="routerLink()"`) so that the Angular router sets a real `href` on the element. This makes the link keyboard-accessible and correctly announced.
