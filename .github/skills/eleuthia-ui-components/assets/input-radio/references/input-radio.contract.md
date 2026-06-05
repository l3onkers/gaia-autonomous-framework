# Input Radio contract

**Selector:** `company-input-radio, [company-input-radio]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isInvalid` | `boolean` | `false` | When true, applies the invalid visual state. Also add `aria-invalid="true"` directly to the projected `<input>` to communicate the state to assistive technologies. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| (default/unnamed) | Label content projected next to the radio icon (typically text or inline elements). |
| `input[type=radio]` | Native HTML radio input element. Must be included; automatically associated with the visible label via `for`/`id`. |
| `company-error-message, [company-error-message]` | Error message component projected below the radio option. |

## Variants and states

From `defaults.ts`:
- **variant:** `keypad` — displays radio options as button-like elements in a horizontal row with borders and hover/selected styling
- **size:** `sm` — renders a smaller radio button (1.6rem instead of 2.4rem)

Default: no variant, standard size (2.4rem).

## CSS tokens

| Token | Default | sm | keypad | Purpose |
|-------|---------|-----|--------|---------|
| `--size` | `2.4rem` | `1.6rem` | `2.4rem` | Height and width of the radio icon circle |
| `--color-primary` | var(--color-red-500) | — | — | Border and background color in invalid state; selected border in keypad |
| `--color-secondary` | var(--color-brown-500) | — | — | Default text color in content |
| `--color-secondary-10` | var(--color-brown-100) | — | — | Icon border color when disabled |
| `--color-secondary-15` | var(--color-brown-200) | — | — | Icon border color when disabled |
| `--color-secondary-40` | var(--color-brown-300) | — | — | Icon color when checked and disabled |
| `--color-tertiary` | var(--color-mustard-600) | — | — | Default icon border and checked background color; content color in keypad hover |
| `--color-quaternary` | var(--color-khaki-500) | — | — | Icon color in default unchecked state; hover border color |
| `--color-light` | #FFFFFF | — | — | Icon background color; inner dot color when checked; text color inside icon |
| `--z-index-sm` | 1 | — | `1` | Stacking context for keypad label on hover/checked |
| `--border-radius` | 0.4rem | — | `0.4rem` | Applied to first and last keypad option labels for rounded corners |

Note: In the `keypad` variant, the icon is hidden (`z-index: -1`, `opacity: 0`) and the label itself becomes the interactive element with border styling.
