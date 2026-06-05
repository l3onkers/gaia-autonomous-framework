# Input Checkbox contract

**Selector:** `corp-input-checkbox, [corp-input-checkbox]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isFullwidth` | `boolean` | `false` | When true, the checkbox stretches to fill the full width of its container. |
| `alignment` | `'left' \| 'right'` | `'left'` | Controls the position of the checkbox indicator relative to the label content. |
| `isInvalid` | `boolean` | `false` | When true, applies the invalid visual state. Also add `aria-invalid="true"` directly to the projected `<input>` to communicate the state to assistive technologies. |
| `variant` | `string` | `''` | Style variant; use `'switch'` for toggle switch appearance. |
| `size` | `string` | `''` | Size variant; only `'sm'` is available (not applicable when `variant='switch'`). |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `input[type=checkbox]` | Receives the native `<input type="checkbox">` element. |
| (default/unnamed) | Receives the label content (text, spans, links, etc.). |
| `company-error-message, [company-error-message]` | Receives an error message component to display validation feedback. |

## Variants and states

- **`variant=""`** (default) — Standard checkbox with square indicator
- **`variant="switch"`** — Toggle switch variant with rounded track and thumb indicator
- **`size="sm"`** — Small checkbox (default is regular; only applies to standard checkbox, not switch variant)

Supported disabled and checked states are detected from the projected `<input>` via CSS `:has()` selectors.

## CSS tokens

| Token | Default | sm | Purpose |
|-------|---------|-----|---------|
| `--size` | `2.4rem` | `1.6rem` | Height and width of the checkbox indicator |
| `--color-tertiary` | (theme variable) | — | Border color of the checkbox indicator (default state) |
| `--color-light` | `#FFFFFF` | — | Background color of the checkbox indicator (default/unchecked state) |
| `--color-quaternary` | (theme variable) | — | Border and background color when checkbox is checked |
| `--color-secondary-10` | (theme variable) | — | Background color of switch track (unchecked state) |
| `--color-secondary-15` | (theme variable) | — | Border color of switch track (unchecked state) |
| `--color-tertiary` | (theme variable) | — | Background and border color of switch track (checked state) |
| `--color-secondary-40` | (theme variable) | — | Color of switch thumb when disabled or icon when checked/disabled |
| `--color-secondary` | (theme variable) | — | Text color of label content |
| `--color-primary` | (theme variable) | — | Border color when `isInvalid=true` |
| `--border-radius-sm` | `0.2rem` | — | Border radius of standard checkbox indicator |
| `--switchTopOffset` | `0rem` | — | Vertical offset of switch track within the component |
| `--switchWidth` | `4.4rem` | — | Width of switch track |
| `--switchHeight` | `2.4rem` | — | Height of switch track |
| `--switchThumbSize` | `1.6rem` | — | Diameter of switch thumb |
| `--switchThumbOffset` | `0.4rem` | — | Padding between track edge and thumb |
