# Image Ratio — Accessibility Issues

The following issues were identified during the WCAG 2.2 audit of this component. They have not yet been resolved. Address them before using this component in a production context.

---

## Issue 1 — `role="img"` on host without accessible name

**File:** `image-ratio.component.ts` — `host: { role: 'img' }`

**WCAG criterion:** 1.1.1 Non-text Content (Level A)

**Problem:** The component unconditionally sets `role="img"` on the host element. An element with this role must have an accessible name provided via `aria-label` or `aria-labelledby`. Without one, assistive technologies announce a nameless image region, which is uninformative and may confuse screen reader users.

**Recommendation:** Expose an `ariaLabel = input<string>()` bound to `[attr.aria-label]` on the host, or explicitly document (and enforce through review) that every consumer must add `aria-label` or `aria-labelledby` to the `corp-image-ratio` host element.

---

## Issue 2 — Projected `<img>` and host `role="img"` create a nested image structure

**File:** `image-ratio.component.html` — `<ng-content select="img">`

**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

**Problem:** The host has `role="img"` and the projected `<img>` also carries the native implicit `img` role. Screen readers interpret this as an image nested inside another image, and may announce both separately — once for the outer `role="img"` container (with no name) and once for the projected `<img>` (using its `alt` text). This creates a redundant or confusing announcement.

**Recommendation:** When the accessible name is provided on the host via `aria-label`, add `aria-hidden="true"` to the projected `<img>` to remove it from the accessibility tree and prevent the double announcement. Document this pattern clearly for consumers.

---

## Issue 3 — No mechanism to enforce `alt` attribute on projected `<img>`

**File:** `image-ratio.component.html` — `<ng-content select="img">`

**WCAG criterion:** 1.1.1 Non-text Content (Level A)

**Problem:** The component accepts an `<img>` via `ng-content` with no way to enforce that the projected element includes a meaningful `alt` attribute. If a consumer omits `alt` or leaves it empty on a non-decorative image, the image will be inaccessible to screen reader users.

**Recommendation:** Document prominently that consumers must always supply a meaningful `alt` attribute on the projected `<img>`. For decorative images, `alt=""` must be used in combination with `aria-hidden="true"` on the `corp-image-ratio` host element.
