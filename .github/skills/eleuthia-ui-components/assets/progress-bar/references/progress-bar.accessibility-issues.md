# Accessibility Issues — Progress Bar

This page documents known accessibility problems identified during the WCAG 2.2 audit of the `ProgressBarComponent`. Each issue includes the affected file, the relevant criterion, a description of the problem, and a recommended fix.

---

## Issue 1 — Missing `aria-valuenow`, `aria-valuemin`, `aria-valuemax`

**File:** `progress-bar.component.ts` — `host` declaration

**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

**Problem:** The host carries `role="progressbar"` but no `aria-valuenow`, `aria-valuemin`, or `aria-valuemax` attributes are bound. The ARIA specification requires these three attributes on any element with this role. Without them, screen readers cannot announce the progress value or range, and may report the element as broken or valueless.

**Recommendation:** Expose `ariaValueNow`, `ariaValueMin`, and `ariaValueMax` as `input<number>()` signals and bind them in the `host` object:

```typescript
host: {
  'role': 'progressbar',
  '[attr.aria-valuenow]': 'ariaValueNow()',
  '[attr.aria-valuemin]': 'ariaValueMin()',
  '[attr.aria-valuemax]': 'ariaValueMax()',
}
```

For indeterminate states (e.g. `is-waiting` variant), `aria-valuenow` may be omitted, but `aria-valuemin` and `aria-valuemax` must still be present.

---

## Issue 2 — Missing accessible name

**File:** `progress-bar.component.ts` — `host` declaration

**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

**Problem:** The `role="progressbar"` element has no `aria-label` or `aria-labelledby`. Screen readers will announce the element without a name, making it impossible for users to understand what operation is in progress.

**Recommendation:** Expose an `ariaLabel` input and bind it in `host`:

```typescript
ariaLabel = input<string>();

host: {
  '[attr.aria-label]': 'ariaLabel()',
}
```

The consumer is responsible for providing a translated label that describes the active operation (e.g. `aria-label="Loading search results"`).

---

## Issue 3 — `role="progressbar"` present in accessibility tree when bar is not visible

**File:** `progress-bar.component.html` / `progress-bar.component.scss`

**WCAG criterion:** 1.3.1 Info and Relationships (Level A)

**Problem:** Visibility is toggled via `opacity: 0` on the inner `.c-progress-bar__bg` element. The `opacity` property has no effect on the accessibility tree — the host element with `role="progressbar"` remains announced by screen readers even when the bar is invisible to sighted users. This creates a phantom progress bar that assistive technology users cannot correlate with any visible state.

**Recommendation:** Bind `aria-hidden` on the host to exclude the component from the accessibility tree when it is not visible:

```typescript
host: {
  '[attr.aria-hidden]': '!isVisible()',
}
```

Alternatively, use `display: none` when hidden (which removes the element from the tree natively), though this would require changing the show/hide mechanism.
