# Accessibility Issues — Loader Layer

This page lists known accessibility problems in the `LoaderLayerComponent` that have not yet been resolved. Address these before using the component in a production context.

---

## Issue 1 — Alert region has no accessible name

**File:** `loader-layer.component.ts`, host metadata (`role: 'alert'`)

**WCAG criterion:** 1.3.1 Info and Relationships (Level A) / 4.1.2 Name, Role, Value (Level A)

**Problem:** The host element has `role="alert"` but neither `aria-label` nor `aria-labelledby` is provided. WCAG requires that landmark and live-region elements carry an accessible name when more than one of the same role exists on a page, and recommends it in all cases to help screen reader users identify the region in the document structure. Because the content is projected via `ng-content`, the component cannot derive a label automatically.

**Recommendation:** Expose an `ariaLabel` input bound to `[attr.aria-label]` on the host, with a sensible English default such as `"Loading"`. Consumers are responsible for translating this value to match the application's language.

---

## Issue 2 — Semi-transparent backdrop may reduce projected content contrast

**File:** `loader-layer.component.scss`, line 32–33 (`opacity: .95` on `::before`)

**WCAG criterion:** 1.4.3 Contrast (Minimum) (Level AA)

**Problem:** The overlay backdrop is rendered as a `::before` pseudo-element with `opacity: 0.95` and a `z-index: -1`. This means background content from behind the loader bleeds through the overlay at 5% opacity. Depending on what is rendered beneath the loader, this can reduce the effective contrast between the projected text/spinner and the backdrop, potentially falling below the 4.5:1 ratio required for normal text.

**Recommendation:** Either remove the opacity (use a fully opaque background), or expose it as a CSS custom property (`--loader-layer-backdrop-opacity`) so consuming applications can override it. Document clearly that consumers must verify contrast of projected content against the actual rendered backdrop when the semi-transparent mode is intentional.
