# Popup — Accessibility Issues

The following issues were identified during a WCAG 2.2 audit of the `PopupComponent`. They are pending resolution. Do not use this component in production without addressing these issues or implementing the recommended workarounds on the consumer side.

---

## Issue 1 — Missing dialog role on non-`<dialog>` hosts

**File:** `popup.component.ts`
**WCAG:** 4.1.2 Name, Role, Value (Level A)

When the host element is not a native `<dialog>` (e.g. `<article corp-popup>`), the component sets no `role` attribute. Screen readers do not announce the overlay as a dialog, and assistive technology users receive no context about the modal nature of the content.

**Recommendation:** Add `role="dialog"` and `aria-modal="true"` to the host when the element is not a native `<dialog>`. The component should expose an input (e.g. `ariaLabel` or `ariaLabelledby`) so the dialog can have an accessible name, or document clearly that the consumer must add these attributes manually.

---

## Issue 2 — Missing accessible name on the dialog

**File:** `popup.component.html` / consumer markup
**WCAG:** 4.1.2 Name, Role, Value (Level A)

A dialog without an accessible name is announced by screen readers as "dialog" with no further context. Neither the component template nor any input enforces an `aria-labelledby` pointing to the heading projected inside `corp-popup-header`.

**Recommendation:** Document (or enforce via input) that the consumer must add `aria-labelledby` on the host element, pointing to the `id` of the heading rendered inside `corp-popup-header`.

---

## Issue 3 — Focus is not trapped inside the popup (non-`<dialog>` path)

**File:** `popup.component.ts`
**WCAG:** 2.1.1 Keyboard (Level A)

When the popup is open and the host is not a native `<dialog>`, keyboard focus is not contained inside the popup panel. Users can Tab through elements behind the overlay. The native `<dialog showModal()>` path handles this correctly; the non-`<dialog>` path does not.

**Recommendation:** Implement a focus trap for the non-`<dialog>` path using the `FocusTrap` CDK primitive or equivalent logic, or require consumers to always use a native `<dialog>` element as the host.

---

## Issue 4 — Focus is not moved into the popup on open (non-`<dialog>` path)

**File:** `popup.component.ts`
**WCAG:** 2.4.3 Focus Order (Level A)

When `isVisible` becomes `true` on the non-`<dialog>` path, focus remains on the element that triggered the popup. Users navigating by keyboard must Tab through all elements from their current position to reach the popup content. The native `<dialog showModal()>` path moves focus automatically; the non-`<dialog>` path does not.

**Recommendation:** On open, programmatically move focus to the popup container or the first focusable element inside it for the non-`<dialog>` path.

---

## Issue 5 — Close button has no accessible label

**File:** `popup.component.html`, lines 5–13
**WCAG:** 4.1.2 Name, Role, Value (Level A)

The built-in close button contains only a `corp-icon` with no visible text and no `aria-label`. Screen readers announce it as an unnamed button, giving keyboard and assistive technology users no indication of its purpose.

**Recommendation:** Add a `closeButtonAriaLabel` input to `PopupComponent` (defaulting to `"Close"`), apply it as `[attr.aria-label]` on the close button in the template, and document that consumers must translate this value to match the application language.

---

## Issue 6 — Hidden popup content remains in the accessibility tree (non-`<dialog>` path)

**File:** `popup.component.scss`, lines 28–29
**WCAG:** 1.3.1 Info and Relationships (Level A)

When the popup is hidden, the non-`<dialog>` path uses `opacity: 0` and `top: -200vw` to move it off-screen. These CSS techniques do not remove the element from the accessibility tree. Screen reader users can still navigate to and interact with the popup content while it is visually hidden.

**Recommendation:** Add `visibility: hidden` to the hidden state (`:not(.is-visible)`) and `visibility: visible` to the visible state (`.is-visible`). This removes the element from the accessibility tree when hidden while allowing CSS transitions.
