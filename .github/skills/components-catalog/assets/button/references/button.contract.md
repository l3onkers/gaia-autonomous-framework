# Button contract

**Selector:** `corp-button, [corp-button]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `size` | `string \| Sizes \| undefined` | `undefined` | Size variant of the component. Available values: `sm`, `responsive` |
| `variant` | `string \| undefined` | `undefined` | Visual variant of the component. Available values: `secondary`, `tertiary`, `quaternary`, `apple`, `facebook`, `paypal` |
| `isDisabled` | `boolean` | `false` | Whether the button is disabled. The component binds the native `disabled` attribute on the host automatically. For non-native elements (e.g. `<a>`), also add `aria-disabled="true"` manually. |
| `isFullwidth` | `boolean` | `false` | When true, the button stretches to fill the full width of its container. |
| `isLoading` | `boolean` | `false` | When true, shows a loading indicator and sets aria-busy on the host. Interaction is blocked while loading. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `corp-icon, [corp-icon]` | Icon component or element projected before the button text to add visual context |
| (default unnamed slot) | Button text content |

## Variants and states

**Sizes:**
- `sm` — Small button
- `responsive` — Responsive button that adapts at smaller breakpoints

**Variants:**
- `secondary` — Secondary button with border and transparent background
- `tertiary` — Tertiary button with border and transparent background
- `quaternary` — Quaternary button with border and transparent background
- `apple` — Apple sign-in button
- `facebook` — Facebook sign-in button
- `paypal` — PayPal sign-in button

**States:**
- `isDisabled` — Disabled state
- `isLoading` — Loading state with animated dots indicator
- `isFullwidth` — Full-width variant

## CSS tokens

| Token | Default | sm | responsive | Purpose |
|-------|---------|-----|------------|---------|
| `--btn-height` | `6.4rem` | `4.8rem` | `6.4rem` | Height of the button |
| `--color-primary` | `#E63946` (red-500) | — | — | Background color for primary button |
| `--color-light` | `#FFFFFF` | — | — | Text color for primary button |
| `--color-primary-90` | `#DD4A5C` (red-520) | — | — | Hover background color for primary button |
| `--color-secondary-10` | `#F5E5E3` (brown-100) | — | — | Background color for disabled button |
| `--color-secondary-40` | `#A39690` (brown-300) | — | — | Text color for disabled button |
| `--border-radius` | `0.4rem` | — | — | Border radius of the button |
