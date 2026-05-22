# Global Styles Quick Reference

Compact summary for frequent global-style requests. Use this file for bounded summary output, then load the deeper topic references when the request needs more than the baseline rules below.

## Key Rules

- **rem only** — all sizing values use rem. Base font-size is 62.5%, so 1rem = 10px (e.g. 16px = 1.6rem). Exception: `@media` breakpoints always use px.
- **Semantic tokens only** — never use primitive tokens like `--color-red-500` directly. Always use `--color-primary`, `--color-secondary`, etc.
- **Utility classes in templates** — `u-*` classes go on HTML elements in Angular templates.
- **Design tokens in SCSS** — `var(--token)` goes in component `.scss` files, always inside `:host { }`.
- **SCSS nesting pattern** — always nest state modifiers with `&`: `:host { &.is-active { } }`.
- **Grid systems are independent** — `l-grid-*` (CSS Grid) and `g-col-*` (Flexbox Grid) coexist. Never mix them in the same layout block.

## Breakpoints

| Key | Min-width |
|-----|-----------|
| `xs` | 0px |
| `sm` | 768px |
| `md` | 992px |
| `lg` | 1224px |

Responsive class syntax: `u-{property}-{breakpoint}-{value}` (e.g. `u-mt-md-24`)

## Most Used Classes

| Class | Effect |
|-------|--------|
| `u-flex` | `display: flex; align-items: center` |
| `u-flex-md` | `display: flex` from 992px upwards |
| `is-column` | `flex-direction: column` (modifier on `u-flex`) |
| `is-jc-sb` | `justify-content: space-between` (modifier on `u-flex`) |
| `is-jc-c` | `justify-content: center` (modifier on `u-flex`) |
| `u-flex__right` | `margin-left: auto` — pushes siblings to the left |
| `u-gap-{value}` | `gap: var(--size-{value})` |
| `u-mt-{value}` | `margin-top: var(--size-{value})` |
| `u-mb-{value}` | `margin-bottom: var(--size-{value})` |
| `u-p-{value}` | `padding: var(--size-{value})` |
| `u-p-inline-{value}` | `padding-inline: var(--size-{value})` |
| `u-hide-md` | `display: none` from 992px upwards (mobile-only element) |
| `u-show-md` | `display: none` below 992px (desktop-only element) |
| `u-color-primary` | `color: var(--color-primary)` |
| `u-color-secondary-40` | `color: var(--color-secondary-40)` — disabled text |
| `u-bgcolor-primary-5` | `background-color: var(--color-primary-5)` — error background |
| `u-border-bottom` | `border-bottom: var(--border-solid-dark)` |
| `u-bradius` | `border-radius: var(--border-radius)` (4px) |
| `u-sticky-top` | `position: sticky; top: var(--sticky-top, 0)` |
| `u-ellipsis` | Truncate overflowing text with ellipsis |