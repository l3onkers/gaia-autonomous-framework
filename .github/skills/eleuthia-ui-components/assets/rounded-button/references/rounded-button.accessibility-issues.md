# Rounded Button accessibility issues

This report lists known accessibility issues for the Rounded Button component. It is generated automatically and updated as issues are resolved. Do not use this component in production until all issues are addressed.

## Issue 1 — Missing focus-visible indicator (WCAG 2.4.11)

**File:** `rounded-button.component.scss`

**WCAG criterion:** 2.4.11 Focus Appearance (Level AA, WCAG 2.2)

**Problem:** The component does not define any `:focus-visible` style. The circular host relies entirely on the browser's default `outline`, which is rendered over a coloured background (`--color-primary`, transparent, etc.). Depending on the browser and the active variant, the default outline may not meet the minimum area and contrast requirements defined by WCAG 2.4.11: the focus indicator must have a minimum area equal to the perimeter of the component multiplied by 2 CSS pixels, and a contrast ratio of at least 3:1 between the focused and unfocused states.

**Recommendation:** Add an explicit `:focus-visible` block inside `:host` that renders a clearly visible focus ring. A safe cross-variant approach is to use `outline` with a sufficient offset so it appears outside the circular shape regardless of background color:

```scss
:host {
  &:focus-visible {
    outline: 0.3rem solid var(--color-focus, #005fcc);
    outline-offset: 0.3rem;
  }
}
```

Adjust the color token and offset to match the design system's focus specification. Ensure the chosen color meets 3:1 contrast against all backgrounds on which the button appears.
