# Logo — Accessibility Issues

This page documents known accessibility problems in the `LogoComponent` that must be resolved before using this component in production.

---

## Issue 1 — Missing accessible name when used as a link

**File:** `logo.component.html` + consumer usage
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

**Problem:** All documented story templates wrap `corp-logo` in an `<a>` element. The link's accessible name is derived entirely from its content — which is a graphical SVG icon with no text alternative. Screen readers will announce the element as "link" with no description, leaving keyboard and AT users unable to determine the link's purpose.

**Recommendation:** The consumer must provide an `aria-label` on the host `<a>` element that describes the link destination:

```html
<a corp-logo aria-label="Company — Go to homepage">
  <p app-subtitle>YOUR AWESOME TAGLINE HERE</p>
</a>
```

The strapline text projected via `ng-content` is styled as a small decorative subtitle and does not reliably serve as an accessible name on its own.

---

## Issue 2 — Decorative icon not hidden from assistive technology

**File:** `logo.component.html`, line 1
**WCAG criterion:** 1.1.1 Non-text Content (Level A)

**Problem:** The `<i corp-icon>` element renders the brand logo SVG without `aria-hidden="true"`. When the host element is a link with an `aria-label`, the icon's content may still be announced by some assistive technologies, causing redundant or confusing output.

**Recommendation:** Add `aria-hidden="true"` to the `<i corp-icon>` element inside the template so that the icon is removed from the accessibility tree. The accessible name of the component should come exclusively from the host element (via `aria-label` set by the consumer).

```html
<!-- logo.component.html -->
<i corp-icon aria-hidden="true" [dynamicAxe]="'height'" [icon]="icon"></i>
<ng-content select="app-subtitle,[app-subtitle]"></ng-content>
```
