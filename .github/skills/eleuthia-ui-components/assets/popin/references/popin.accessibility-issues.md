# Popin — Accessibility Issues

This page lists known accessibility problems for the `PopinComponent`. Each item includes the affected file, the relevant WCAG 2.2 criterion, a description of the problem, and a recommended fix.

---

## Issue 1 — Missing accessible name on `role="dialog"`

**File:** `popin.component.ts` — `host: { role: 'dialog' }`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

The host element carries `role="dialog"` but neither `aria-labelledby` nor `aria-label` is set by the component. Screen readers announce the dialog without a name, leaving users with no context about what the overlay contains.

**Recommendation:** The consumer must add `aria-labelledby` on the host element, pointing to the `id` of the projected title element (e.g. the element in the `[slot=popinTitle]` slot). Example:

```html
<article corp-popin aria-labelledby="popin-title-id">
  <h2 corp-title slot="popinTitle" id="popin-title-id">Select your seat</h2>
</article>
```

---

## Issue 2 — Hidden non-`<dialog>` host remains in the accessibility tree

**File:** `popin.component.scss` — `:host:not(dialog)` rules (lines 16–34)
**WCAG criterion:** 2.1.1 Keyboard (Level A), 4.1.2 Name, Role, Value (Level AA)

When `isVisible` is `false` and the host is not a `<dialog>`, the component moves the host to `left: -200vw` and sets `opacity: 0`, but the element stays in the DOM and in the accessibility tree. Keyboard focus and screen reader virtual cursor can still reach all interactive content inside the closed popin.

**Recommendation:** The consumer must add the `inert` attribute to the host whenever `isVisible` is `false`. This removes focus, pointer events, and screen reader access in a single attribute:

```html
<article corp-popin [isVisible]="isOpen" [attr.inert]="isOpen ? null : ''">
```

---

## Issue 3 — Missing `aria-modal="true"` on non-`<dialog>` host

**File:** `popin.component.ts` — `host: { role: 'dialog' }`
**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

When the host is not a native `<dialog>`, the `role="dialog"` element does not have `aria-modal="true"`. Screen readers such as NVDA and JAWS do not restrict their virtual cursor to the dialog bounds, allowing users to browse content behind the overlay.

**Recommendation:** The consumer must add `aria-modal="true"` on the host when using a non-`<dialog>` element:

```html
<article corp-popin aria-modal="true">
```

---

## Issue 4 — No focus management on non-`<dialog>` host

**File:** `popin.component.ts` — visibility `effect()` (lines 68–85)
**WCAG criterion:** 2.4.3 Focus Order (Level AA)

When `isVisible` becomes `true` on a non-`<dialog>` host, the component does not move focus to the first focusable element inside the popin. On close, focus is not returned to the trigger element. The native `<dialog showModal()>` handles both of these automatically; the non-dialog path does not.

**Recommendation:** The consumer must implement focus management. On open, move focus to the first focusable element inside the popin (or to the popin host itself if it has `tabindex="-1"`). On close, return focus to the element that triggered the opening.

---

## Issue 5 — No `Escape` key dismissal on non-`<dialog>` host

**File:** `popin.component.ts` — `host` bindings
**WCAG criterion:** 2.1.2 No Keyboard Trap (Level A)

The component handles `(scroll)` on the host but has no `(keydown.escape)` binding. A native `<dialog>` fires a `cancel` event on Escape that can be wired to `close()`, but the non-`<dialog>` path provides no keyboard dismissal at all.

**Recommendation:** The consumer must add an `Escape` keydown listener and call `close()` when using a non-`<dialog>` host. Alternatively, the component could expose this as a built-in `(keydown.escape)` host binding.

---

## Issue 6 — Internal close buttons have no accessible label

**File:** `popin.component.html` — lines 12–28
**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

The desktop close button contains only `<corp-icon icon="clear-bold">` with no visible text or `aria-label`. The mobile rounded-button is also rendered without an explicit label. Both buttons are announced by screen readers without a meaningful name.

**Recommendation:** Add a configurable `closeButtonAriaLabel` input to `PopinComponent` and bind it to both internal close buttons. The consumer is responsible for providing a translated string. Until then, a hardcoded `aria-label` (e.g. `"Close"`) should be added directly to both buttons in the template as a temporary fix.
