# MenuItemComponent — Accessibility Issues

This page lists known accessibility problems found during a WCAG 2.2 audit of `MenuItemComponent`. Each issue includes the affected file, the violated criterion, a description of the problem, and a recommendation for fixing it.

---

## Issue 1 — Duplicate `role` attribute on the dropdown toggle button

**File:** `menu-item.component.html`, lines 11 and 16
**WCAG criterion:** 4.1.1 Parsing (Level A)

The `<button>` rendered when `isDropdown()` is `true` declares `role="button"` twice in the same element. The `<button>` element already carries an implicit `role="button"`, so both declarations are redundant. Having duplicate `role` attributes in the same element produces invalid HTML that some browsers and assistive technologies may handle inconsistently.

**Recommendation:** Remove both `role="button"` attributes from the dropdown toggle `<button>`. The native element role is sufficient.

---

## Issue 2 — Hardcoded English `aria-label` on the dropdown toggle button

**File:** `menu-item.component.html`, line 13
**WCAG criterion:** 3.1.2 Language of Parts (Level AA) / 4.1.2 Name, Role, Value (Level A)

`aria-label="Open/close menu"` is a hardcoded English string. The label is also reinforced by `lang="en"` on the same element (see Issue 3). Because the component is used in multilingual applications, this label is read to screen reader users in English regardless of the page language.

**Recommendation:** Expose the label as an `input<string>()` (e.g. `dropdownToggleAriaLabel`) so consumers can translate it. Remove the hardcoded `aria-label` from the template and bind it to the input.

---

## Issue 3 — `lang="en"` hardcoded on an internal button

**File:** `menu-item.component.html`, line 14
**WCAG criterion:** 3.1.2 Language of Parts (Level AA)

The dropdown toggle button has `lang="en"` set directly on the element. This instructs assistive technologies to use English pronunciation rules for the content of that element, overriding the document's declared language. This causes mispronunciation for non-English applications.

**Recommendation:** Remove the `lang="en"` attribute from the toggle button. Language should be declared at the `<html>` level and should not be overridden on internal component elements.

---

## Issue 4 — Disabled state not exposed to assistive technologies

**File:** `menu-item.component.scss`, lines 4–7 / `menu-item.component.ts`, line 26
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

When `isDisabled` is `true`, the component applies `is-disabled` which sets `pointer-events: none` and `opacity: 0.5`. No `aria-disabled="true"` attribute is set on the host element. Screen readers have no programmatic indicator that the item is disabled and will still announce it as interactive.

**Recommendation:** Bind `aria-disabled` to the `isDisabled` signal in the component's `host` configuration:
```typescript
host: {
  '[attr.aria-disabled]': 'isDisabled() || null',
}
```
Using `|| null` removes the attribute when the value is `false`, avoiding `aria-disabled="false"` on every item.

---

## Issue 5 — `role="menuitem"` may be invalid outside a `menu` or `menubar` context

**File:** `menu-item.component.ts`, line 21
**WCAG criterion:** 1.3.1 Info and Relationships (Level A)

The component sets `role="menuitem"` unconditionally on its host. The `menuitem` role is only valid when it is an owned child of an element with `role="menu"` or `role="menubar"`. When `MenuItemComponent` is used inside `corp-menu-tab` — which may expose a tab-list structure — the ARIA ownership requirement is violated, producing an invalid accessibility tree.

**Recommendation:** Verify the role assigned by parent containers (`corp-menu`, `corp-menu-tab`, `corp-menu-segment`). If any parent does not carry `role="menu"` or `role="menubar"`, the `menuitem` role must be changed to match the actual pattern (e.g. `tab` inside a tablist). Consider making the `role` configurable via an input or removing it from the host so parent containers can govern the role assignment.

---

## Issue 6 — `isSelected` does not reflect a programmatic selected or current state

**File:** `menu-item.component.ts`, line 27
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

`isSelected` applies the `is-active` CSS class (bold text, brand color) but no corresponding ARIA attribute is set. When `role="menuitem"` is used, the appropriate attribute for a checked/selected state is `aria-checked` (for `menuitemcheckbox`) or none at all. For navigation contexts, `aria-current="page"` is the correct attribute. Screen readers cannot convey the selected state to the user.

**Recommendation:** If the item represents the current page, the consumer should add `aria-current="page"` to the host element. If the item is part of a selection context, the consumer should add `aria-selected` or `aria-checked` as appropriate. Document this responsibility clearly in the component's public API and in the Accessibility section of the docs.

---

## Issue 7 — Dropdown toggle has no `aria-expanded` or `aria-controls`

**File:** `menu-item.component.html`, lines 10–19 and 29
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

The `<button class="c-menu-item__arrow">` that triggers the dropdown panel has neither `aria-expanded` nor `aria-controls`. The projected dropdown content (via `[slot=dropdown]`) has no linked `id`. Keyboard and screen reader users cannot determine whether the panel is open or closed, and cannot navigate from the trigger to its controlled region.

**Recommendation:** Expose the expanded state of the dropdown as a signal (or model) and bind it to `aria-expanded` on the toggle button. Assign a stable `id` to the dropdown container and reference it with `aria-controls` on the button. The consumer is responsible for toggling the state; the component must wire the ARIA attributes once the mechanism is in place.
