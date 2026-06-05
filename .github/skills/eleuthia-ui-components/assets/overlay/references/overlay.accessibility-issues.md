# Overlay accessibility issues

This report was generated automatically. It reflects the state of the component at the time of the last audit. Resolve each issue and run a review to update or remove this file.

## Issue 1 — Host element not hidden from the accessibility tree when used decoratively

**File:** `overlay.component.ts` — `host` metadata
**WCAG criterion:** 1.3.1 Info and Relationships (Level A) / 4.1.2 Name, Role, Value (Level A)

**Problem:**
The component does not set `aria-hidden="true"` on its host element. When `company-overlay` is used purely as a decorative colour tint over a background image, the host element remains in the accessibility tree as an anonymous, nameless element. Screen readers may announce it as an unlabelled region or traverse it, adding noise to the reading experience.

**Recommendation:**
When using the overlay decoratively, the consumer must add `aria-hidden="true"` on the host element:

```html
<company-overlay variant="regular" aria-hidden="true"></company-overlay>
```

Alternatively, if the overlay is always decorative (i.e. it never acts as an interactive backdrop), add `'aria-hidden': 'true'` to the component's `host` metadata so that it is applied automatically. If the component is also used as a clickable backdrop (as in `mobile-menu.component.html`), this default would need to be overridden by the consumer for that use case — document both patterns clearly.
