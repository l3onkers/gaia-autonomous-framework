# Accessibility Issues — Tooltip

> These issues were identified during a WCAG 2.2 audit and are pending resolution. This page will be updated or removed once the issues are fixed.

---

## 1. No `aria-describedby` bridge between trigger and tooltip

**File:** `tooltip.component.ts` (host configuration)

**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

**Problem:**
The component sets `role="tooltip"` on its host but does not expose an `id` input nor auto-generate one. Without a stable `id` on the tooltip element, the trigger element has no way to declare `aria-describedby` pointing to the tooltip. Assistive technologies therefore cannot associate the tooltip content with its trigger, and will not announce it when the element receives focus or the tooltip becomes visible.

**Recommendation:**
Expose an `id` input on `TooltipComponent` and bind it to the host element (`[attr.id]`). Document that the consumer must set a matching `id` on `corp-tooltip` and add `aria-describedby="<that-id>"` to the trigger element. Alternatively, auto-generate a unique id inside the component and expose it as a read-only signal for the consumer to bind.

---

## 2. Keyboard inaccessibility — no `focus`/`blur` handlers in `TooltipWrapperDirective`

**File:** `tooltip.component.ts` — `TooltipWrapperDirective`

**WCAG criteria:** 2.1.1 Keyboard (Level A), 1.4.13 Content on Hover or Focus (Level AA)

**Problem:**
`TooltipWrapperDirective` handles `mouseenter` and `mouseleave` only. There are no `focusin` or `focusout` host listeners. Keyboard users who tab to the wrapper's trigger element cannot show or hide the tooltip. WCAG 1.4.13 requires that content triggered by hover is also triggerable by keyboard focus.

**Recommendation:**
Add `'(focusin)': 'onMouseEnter()'` and `'(focusout)': 'onMouseLeave()'` to the `host` object of `TooltipWrapperDirective`. This ensures parity between pointer and keyboard interactions with no behavioral change for mouse users. The existing delay logic will apply equally to both interaction modes.

---

## 3. `htmlContent` may introduce interactive elements inside `role="tooltip"`

**File:** `tooltip.component.html` — line 3

**WCAG criterion:** 4.1.1 Parsing, 1.3.1 Info and Relationships (Level A)

**Problem:**
The `htmlContent` input is rendered via `[innerHTML]` with no constraint on the markup type. The ARIA specification states that `role="tooltip"` must contain only non-interactive descriptive text. If the consumer passes markup that includes links (`<a>`), buttons, or form controls, those interactive elements appear inside a tooltip role, creating an invalid ARIA structure that screen readers and automated tools will flag.

**Recommendation:**
Document clearly (JSDoc + MDX) that `htmlContent` must contain only non-interactive markup (plain text, `<strong>`, `<em>`, `<br>`). As a defensive measure, consider running the value through Angular's `DomSanitizer` to strip interactive elements before binding, or add a runtime warning in development mode when a focusable element is detected inside `htmlContent`.
