# Tooltip contract

**Selector:** `corp-tooltip, [corp-tooltip]`

**Associated directive:** `companyTooltipWrapper` — Attach to the trigger element to enable automatic hover/focus management.

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `position` | `'left' \| 'right' \| 'bottom' \| 'bottom-left' \| 'bottom-right'` | `undefined` | Position of the tooltip relative to its anchor. Defaults to top-center when omitted. |
| `delay` | `number` | `0` | Delay in milliseconds before the tooltip appears on hover. Values above 499 ms activate delayed-show behavior managed by `TooltipWrapperDirective`. |
| `textAlignment` | `'left' \| 'center' \| 'right'` | `'center'` | Horizontal alignment of the tooltip text content. |
| `htmlContent` | `string` | `undefined` | Optional raw HTML string rendered inside the tooltip via `[innerHTML]`. When provided, the `ng-content` slot is ignored. Must contain only non-interactive markup (e.g. `<strong>`, `<em>`). Do NOT pass links or buttons. |

### Models

| Name | Type | Description |
|------|------|-------------|
| `isVisible` | `boolean` | Controls whether the tooltip is visible. Can be set from the parent or updated internally by `TooltipWrapperDirective`. Default: `false`. |

### Outputs

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `(default / unnamed)` | Text or inline markup to display inside the tooltip. Used only if `htmlContent` is not provided. |

## Variants and states

### Size variants

- `xs` — 13rem width
- `sm` — 24rem width (default)
- `lg` — 35rem width
- `xl` — 42rem width

### Other variants

- `dark` — Dark theme variant (dark background, light text)

### States

- `is-visible` — Applied when `isVisible` is `true`. Transitions the tooltip into `display: block` with full opacity and corrected transform.
- `has-delay` — Applied when `delay > 499`. Indicates delayed-show behavior is active.
- `is-align-left` — Applied when `textAlignment === 'left'`.
- `is-align-right` — Applied when `textAlignment === 'right'`.

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--z-index-lg` | `10` | Z-index for visible tooltip overlay (show state). |
| `--z-index-xs` | `-1` | Z-index for hidden tooltip (default state). |
| `--color-light` | `#FFFFFF` | Background color of the tooltip inner box (light variant). |
| `--color-secondary` | `var(--color-brown-500)` | Text color (light variant) and background color (dark variant). |
| `--color-secondary-15` | `var(--color-brown-200)` | Border color (light variant). |
| `--border-radius` | `0.4rem` | Border radius of tooltip pseudo-elements. |
| `--shadow-light` | `0px 2px 6px rgba(69, 35, 37, 0.15)` | Box shadow applied to the tooltip inner box. |

**Token overrides by variant:**

- **dark:** `--color-secondary` (background), `--color-light` (text)
- **dark (border):** `--color-secondary` (replaces `--color-secondary-15`)