# Menu Accessibility Issues

The following issues were identified during a WCAG 2.2 audit of this component. They must be resolved before this component is used in production.

---

## 1. Missing accessible name on `role="menu"` host

**File:** `base/menu.component.ts` — host directive
**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

`role="menu"` is set statically on the host via the `BaseMenuComponent` directive, but no accessible name is provided or exposed as an input. Screen readers announce the element as an unnamed menu, which prevents users from distinguishing it from other menus or navigation regions on the same page.

**Recommendation:** Expose an `ariaLabel` input on `BaseMenuComponent` and bind it to `[attr.aria-label]` in the host, or document clearly that the consumer must add `aria-label` or `aria-labelledby` directly on the host element.

---

## 2. Hardcoded `aria-label` in English on the dropdown toggle button

**File:** `menu-item.component.html` — line 14
**WCAG criterion:** 3.1.2 Language of Parts (Level AA) / 4.1.2 Name, Role, Value (Level AA)

The toggle button rendered when `isDropdown` is `true` carries `aria-label="Open/close menu"` hardcoded in English, together with `lang="en"`. When the application is served in another language, this label is never translated, resulting in an accessible name that does not match the surrounding content language.

**Recommendation:** Expose a `dropdownAriaLabel` input on `MenuItemComponent` and bind it to `[attr.aria-label]` on the button element. Remove the static `lang="en"` attribute.

---

## 3. `isDisabled` does not communicate disabled state to assistive technologies

**File:** `menu-item.component.ts` — `isDisabled` model input / `menu-item.component.html`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

When `isDisabled` is `true`, the component adds the `is-disabled` CSS class and applies visual styling, but does not set `aria-disabled="true"` on the host element. Assistive technologies therefore announce the item as fully interactive even when it is visually disabled, misleading keyboard and screen-reader users.

**Recommendation:** Add `[attr.aria-disabled]="isDisabled() || null"` to the host bindings in `MenuItemComponent`. If the host is a native `<button>`, also document that the consumer should add the native `disabled` attribute to prevent keyboard focus.

---

## 4. `isSelected` does not communicate current state to assistive technologies

**File:** `menu-item.component.ts` — `isSelected` model input
**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

When `isSelected` is `true`, the component adds the `is-active` CSS class, but no ARIA attribute communicates the selected or current state. Screen-reader users have no way to identify the currently active item in the navigation menu.

**Recommendation:** Add `[attr.aria-current]="isSelected() ? 'page' : null"` to the host bindings in `MenuItemComponent` for page-level navigation use cases. For other use cases (for example, tab-style selection), consider `aria-selected` with `role="tab"` instead, and document the appropriate pattern for each context.
