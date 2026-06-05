# Input text contract

**Selector:** `corp-input-text, [corp-input-text]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isFullwidth` | `boolean` | `true` | When true, the input stretches to fill the full width of its container. |
| `isInvalid` | `boolean` | `false` | When true, applies the invalid visual state. Also add `aria-invalid="true"` directly to the projected `<input>` to communicate the state to assistive technologies. |
| `isFilled` | `boolean` | `false` | When true, applies the filled visual state to indicate the field has a value. |
| `align` | `'left' \| 'center' \| 'right'` | `'left'` | Controls the horizontal alignment of the input text. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `clicked` | `Event` | Emits when the component host is clicked. |
| `rightButtonClicked` | `Event` | Emits when the projected `corp-text-button` is clicked. |

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `[corp-button], corp-button` | Primary button projected above the input field (full-width on mobile, alongside on desktop). |
| `corp-icon, [corp-icon]` | Icon projected to the left of the input field for visual context (e.g., user, email, lock). |
| `input[type=text], input[type=email], input[type=password]` | The native input element for text data entry. |
| `corp-text-button, [corp-text-button]` | Auxiliary button projected to the right of the input field (e.g., clear, reveal password). |
| `corp-body-text[slot=legend], [corp-body-text][slot=legend]` | Helper text or legend displayed below the input field. |
| `company-error-message, [company-error-message]` | Error message displayed below the input field when validation fails. |

## Variants and states

| Variant | Values | Purpose |
|---------|--------|---------|
| `clear` | — | Removes borders and border-radius from the input field for a minimal appearance. |

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--padding` | `0 1.6rem` | Inner container padding (horizontal and vertical). |
| `--height` | `4.8rem` | Inner container height. |
| `--gap` | `0.8rem` | Gap between icon, input, and button inside the inner container. |
| `--color-secondary-15` | `var(--color-brown-200)` | Border color in default state. |
| `--color-secondary-5` | `var(--color-brown-50)` | Background color in disabled state. |
| `--color-quaternary` | `var(--color-khaki-500)` | Border color in filled state and on hover. |
| `--color-tertiary-5` | `var(--color-mustard-50)` | Background color in filled state. |
| `--color-primary` | `var(--color-red-500)` | Border and text color in invalid state; icon color in default state. |
| `--color-primary-5` | `var(--color-red-50)` | Background color in invalid state. |
| `--color-primary-90` | `var(--color-red-520)` | Border color in invalid state during hover/focus. |
| `--color-tertiary` | `var(--color-mustard-600)` | Border color on focus. |
| `--color-secondary-40` | `var(--color-brown-300)` | Placeholder text color; disabled icon color. |
| `--color-secondary-60` | `var(--color-brown-400)` | Disabled input text color. |
| `--color-light` | `#FFFFFF` | Background color in default and filled states. |
| `--border-radius` | `0.4rem` | Border radius of the inner container. |