# Body Text contract

**Selector:** `corp-body-text, [corp-body-text]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `size` | `'2xs' \| 'xs' \| 'sm' \| 'lg' \| 'xl' \| ''` | `''` | Size variant affecting font size and line height. Empty string applies the base body size (scales to larger on medium-breakpoint viewports). |
| `dark` | `boolean` | `false` | If true, applies the dark variant which uses `--color-secondary` instead of `--color-secondary-70` for higher contrast on light backgrounds. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| (default) | The text content to be styled with body text typography. Can include inline HTML elements like links. |

## Variants and states

**Size variants:** `2xs`, `xs`, `sm` (default), `lg`, `xl`
- `2xs`: 1.2rem / 1.6rem (mobile), stays 1.2rem / 1.6rem (desktop)
- `xs`: 1.2rem / 1.6rem (mobile), becomes 1.6rem / 2.4rem (desktop)
- `sm`: 1.6rem / 2.4rem (mobile), becomes 2rem / 2.8rem (desktop)
- `lg`: 2rem / 2.8rem (mobile), stays 2.4rem / 3.2rem (desktop)
- `xl`: 2.4rem / 3.2rem (mobile), stays 2.4rem / 3.2rem (desktop)
- (no size): 1.6rem / 2.4rem (mobile), becomes 2rem / 2.8rem (desktop)

**Color variants:** `dark`
- Default: uses `--color-secondary-70` (#7C6566)
- `dark`: uses `--color-secondary` (#452325) for higher contrast on light backgrounds

## CSS tokens

| Token | Default | 2xs | xs | sm | lg | xl | dark | Purpose |
|-------|---------|-----|----|----|----|----|------|---------|
| `--font-size` | 1.6rem | 1.2rem | 1.2rem | 1.6rem | 2rem | 2.4rem | — | Font size, responsive |
| `--line-height` | 2.4rem | 1.6rem | 1.6rem | 2.4rem | 2.8rem | 3.2rem | — | Line height, responsive |
| `--font-color` | #7C6566 | — | — | — | — | — | #452325 | Text color, changes with dark variant |
| `--font-weight` | 400 | — | — | — | — | — | — | Font weight (normal) |

Note: Values in responsive columns reflect desktop (md+) overrides. Mobile defaults are shown in the Default column. The `dark` variant only affects `--font-color`.
