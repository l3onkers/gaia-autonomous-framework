# Input Select contract

**Selector:** `corp-input-select, [corp-input-select]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `title` | `string \| undefined` | `undefined` | Placeholder text shown when no option is selected. Also used as the dropdown header title on mobile. |
| `isFullwidth` | `boolean` | `true` | When true, the component stretches to fill the full width of its container (has no effect on `inline` variant). |
| `isFilled` | `boolean` | `false` | When true, applies the filled visual state to indicate a value has been selected. |
| `isInvalid` | `boolean` | `false` | When true, applies the invalid visual state. |
| `isReadonly` | `boolean` | `true` | When true, the search input is read-only and the dropdown cannot be filtered by typing. When false, the user can type to filter options. |
| `isIATA` | `boolean` | `false` | When true, enables IATA code matching in addition to text matching when filtering options. |
| `closeButtonAriaLabel` | `string` | `''` | Accessible label for the mobile close button (back arrow). Must be provided in the language of the interface. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `optionClick` | `DropdownOption` | Emitted when a dropdown option is clicked. Also emitted for label and disabled options; check `option.isLabel` and `option.isDisabled` if you need to filter those out. |

### Models

| Name | Type | Description |
|------|------|-------------|
| `isOpen` | `boolean` | Controls whether the dropdown is open. Supports two-way binding. |

## Slots

| Selector | Purpose |
|----------|---------|
| `corp-icon, [corp-icon]` | Icon projected into the input field (e.g., search icon for searchable variants). |
| `select` | Native HTML `<select>` element that serves as the data source for dropdown options. |
| `company-error-message, [company-error-message]` | Error message displayed below the input when validation fails. |
| Custom template (unnamed `<ng-template>`) | Optional template for rendering custom option content. The template receives `let-option` context with `DropdownOption` data. |

## Variants and states

The component supports the following variant:

- **`inline`** — Compact variant used for form fields with limited width. Renders as an inline button instead of a full-width input field.

Default variant (no variant specified) renders as a standard dropdown select with full width and integrated search input.

## CSS tokens

| Token | Default | inline | Purpose |
|-------|---------|--------|---------|
| `--border-radius` | `0.4rem` | — | Border radius for the dropdown container and input field. |
| `--border-solid` | `0.1rem solid var(--border-color)` | — | Border style and color applied to the dropdown on desktop. |
| `--color-primary` | `#E63946` (red-500) | — | Color for selected options, interactive icons, and primary visual elements. |
| `--color-secondary-40` | `#8B7355` (brown-300) | — | Text color for disabled options and disabled state button icon. |
| `--color-secondary-10` | `#F5EBE0` (brown-100) | — | Background color for option group labels. |
| `--color-secondary-15` | `#D4C4B9` (brown-200) | — | Border color for dividing lines between options and header. |
| `--color-secondary-5` | `#FAF7F3` (brown-50) | `#FAF7F3` | Background color on hover (desktop) or inline variant hover state. |
| `--color-light` | `#FFFFFF` | — | Background color for the dropdown container and mobile full-screen view. |
| `--color-tertiary` | `#F0A500` (mustard-600) | — | Border color when dropdown is open or focused on desktop. |
| `--color-quaternary` | `#D4A574` (khaki-500) | — | Text color on hover for unselected options. |
| `--z-index-xs` | `-1` | — | Stacking context for closed dropdown (behind other content). |
| `--z-index-xl` | `15` | — | Stacking context for open dropdown (above other content). |
| `--input-width` | `auto` | `auto` | Width of the trigger button (inline variant only). |
| `--input-text-align` | `left` | `left` | Text alignment in the trigger button (inline variant only). |
| `--input-font-weight` | `normal` | `normal` | Font weight for the trigger button text (inline variant only). |
| `--input-background-color` | `transparent` | `transparent` | Background color of the trigger button (inline variant only). |
| `--dropdown-border` | `var(--border-solid)` | `0.1rem solid var(--color-light)` | Border applied to dropdown on desktop. |
| `--dropdown-border-radius` | `var(--border-radius)` | `0 0 var(--border-radius) var(--border-radius)` | Border radius for dropdown container on desktop. |
| `--dropdown-border-focus-color` | `var(--color-tertiary)` | `var(--color-light)` | Border color when dropdown is focused or open on desktop. |
