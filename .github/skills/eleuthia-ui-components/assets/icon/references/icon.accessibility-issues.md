# Icon — Accessibility Issues

## Issue 1 — No accessible name mechanism on host for standalone meaningful icons

**File:** `icon.component.ts`, host bindings
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

The host element has no semantic role and no built-in mechanism to provide an accessible name. When the icon is the sole content of an interactive element (e.g. a button with no visible label), the interactive parent has no accessible name. The component does not expose an `ariaLabel` input, so the consumer must remember to add `aria-label` directly on the host or on the parent element.

**Recommendation:** Document clearly that:
- Decorative icons must have `aria-hidden="true"` on the host element.
- Meaningful standalone icons (used without visible text) require `aria-label` on the host or on the interactive parent.
Consider exposing an `ariaLabel` input bound to `[attr.aria-label]` in the host to make this pattern more discoverable and consistent.
