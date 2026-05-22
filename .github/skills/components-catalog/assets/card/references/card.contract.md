# Card contract

**Selector:** `corp-card, [corp-card]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isClickable` | `boolean` | `false` | Applies `cursor: pointer` and a hover shadow. When `true`, also add `role="button"`, `tabindex="0"`, and keyboard handlers (`Enter`/`Space`) on the host so the card is keyboard-accessible. |
| `isSelected` | `boolean` | `false` | Highlights the card with a primary-color border to indicate selection. When `true`, also add `aria-selected="true"` or `aria-pressed="true"` on the host to expose the state to assistive technologies. |
| `isFocusable` | `boolean` | `false` | Applies focus and hover border highlight styles. When `true`, also add `tabindex="0"` on the host so the card can actually receive keyboard focus. |
| `enableOnDesktop` | `boolean` | `false` | When `true`, the card renders as a flat, borderless, shadowless surface on mobile (below `$bp-md`), and any direct `corp-card-content` children lose their padding. On desktop the card displays normally. |
| `borderType` | `'split' \| 'inner' \| ''` | `''` | Controls the divider style between `corp-card-content` sections. `'split'` draws a full-width bottom border on each section; `'inner'` draws an inset border (respecting content padding). Leave empty for no dividers. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| (default) | Generic content projection for any child elements, typically `corp-card-content` components. |

## Variants and states

- **Size variants:** `2xs`, `xs`, `sm` (adjusts content padding)
- **Visual variants:** `no-shadows`, `grey`, `brand`, `responsive`, `v7wall-box`, `v7wall-warning`
- **Interactive states:** `isClickable`, `isSelected`, `isFocusable`
- **Layout states:** `enableOnDesktop`

## CSS tokens

| Token | Default | xs / 2xs | sm | Purpose |
|-------|---------|----------|-----|---------|
| `--card-border-radius` | `var(--border-radius)` — `0.4rem` | — | — | Rounded corners of the card |
| `--card-border-color` | `var(--color-secondary-15)` — `#C8B4A0` | — | — | Border color (changes on hover/focus) |
| `--card-border` | `0.1rem solid var(--card-border-color)` | — | — | Border shorthand |
| `--card-background-color` | `var(--color-light)` — `#FFFFFF` | — | — | Card background (changes by variant) |
| `--card-shadow` | `var(--shadow-light)` — `0px 2px 6px rgba(69, 35, 37, 0.15)` | — | — | Default drop shadow (removed by `no-shadows` and other variants) |
| `--card-shadow-hover` | `var(--shadow-hover)` — `0px 6px 8px var(--color-secondary-10)` | — | — | Hover shadow (clickable cards only) |

**Size-specific overrides:**
- **2xs / xs:** `--card-content-padding: 1.6rem`
- **sm:** `--card-content-padding: 2.4rem` (on desktop; smaller on mobile)
- **Default (no size):** `--card-content-padding: 3.2rem` (on desktop)

**Variant overrides:**
- **`no-shadows`:** `--card-shadow: none`; `--card-border: none` (but shadow restores on clickable hover)
- **`grey`:** `--card-background-color: var(--color-secondary-10)` — `#F0E5D0`; `--card-shadow: none`; `--card-border: none`
- **`brand`:** `--card-background-color: var(--color-primary-5)` — `#FFE5E5`; `--card-shadow: none`; `--card-border: none`
- **`responsive`:** On desktop, `--card-shadow: none`; hover state removes shadow and changes border to primary color
