# Spinner — Accessibility Issues

The following issues were identified during a WCAG 2.2 audit of this component. They are pending resolution. Consumers should be aware of these limitations before using this component in production.

---

## Issue 1 — `role="progressbar"` missing accessible name

**File:** `spinner.component.html`, line 13

**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

**Problem:** The `<div role="progressbar">` element has no `aria-label` or `aria-labelledby` attribute. Screen readers will announce the element as a progressbar with no name, providing no context about what process is in progress.

**Recommendation:** Add an `aria-label` input to `SpinnerComponent` and bind it to the progressbar element. Example: `<div role="progressbar" [attr.aria-label]="ariaLabel()">`. Consumers should pass a translated description such as `"Loading flight results"`.

---

## Issue 2 — `role="progressbar"` missing value attributes

**File:** `spinner.component.html`, line 13

**WCAG criterion:** 4.1.2 Name, Role, Value (Level AA)

**Problem:** The `role="progressbar"` element does not expose `aria-valuenow`, `aria-valuemin`, or `aria-valuemax`. For determinate states (e.g. `is-50-percent`), the current value is only expressed visually via CSS. For indeterminate states, `aria-valuenow` should be omitted and `aria-valuetext` used instead.

**Recommendation:** Derive the current value from the active variant and bind it: for percentage variants, set `aria-valuenow` to the numeric percentage, `aria-valuemin="0"`, and `aria-valuemax="100"`. For indeterminate variants (`is-waiting`), omit `aria-valuenow` and add `aria-valuetext="Loading"` (or a translatable equivalent).

---

## Issue 3 — Decorative background SVG not hidden from the accessibility tree

**File:** `spinner.component.html`, line 1

**WCAG criterion:** 1.3.1 Info and Relationships (Level A)

**Problem:** The `<div class="c-spinner__bg">` element contains a purely decorative SVG that renders the track ring behind the progress arc. It has no `aria-hidden="true"` attribute, so assistive technologies may traverse its contents unnecessarily.

**Recommendation:** Add `aria-hidden="true"` to `<div class="c-spinner__bg">` so the decorative background is removed from the accessibility tree entirely.

---

## Issue 4 — Projected icons lack guidance for `aria-hidden`

**File:** `spinner.component.html`, line 32

**WCAG criterion:** 1.1.1 Non-text Content (Level A)

**Problem:** Icons can be projected into the spinner center via `ng-content select="corp-icon, [corp-icon]"`. In the spinner context these icons are decorative, but the component provides no mechanism or documentation to ensure consumers add `aria-hidden="true"` to them. A screen reader inside the `role="status"` live region will announce the icon element if it carries accessible text.

**Recommendation:** Document clearly (and enforce via JSDoc) that consumers must add `aria-hidden="true"` to any icon projected into the spinner. Alternatively, expose an `iconAriaLabel` input and render the icon internally so the component controls its accessibility attributes.
