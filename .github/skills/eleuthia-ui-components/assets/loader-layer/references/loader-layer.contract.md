# Loader Layer contract

**Selector:** `company-loader-layer, [company-loader-layer]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isVisible` | `boolean` | `false` | Controls whether the loader layer is shown. When `false`, the overlay is removed from the accessibility tree via `display:none`. When set to `true`, the element re-enters the tree and screen readers announce its content because of the `role="alert"` on the host. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `ng-content` (default, no select) | Any content projected into the overlay — typically a spinner, heading, and message text. |

## Variants and states

| Variant | Class | Purpose |
|---------|-------|---------|
| `light` | `c-loader-layer--light` | Changes the backdrop from dark brown to white. Use when the loader is placed over a light-colored section. |

## CSS tokens

| Token | Default | light | Purpose |
|-------|---------|-------|---------|
| `--padding` | `3.2rem` | — | Vertical and horizontal padding inside the overlay (adjusts to `6.4rem` at `md` breakpoint). |
| `--gap` | `1.6rem` | — | Gap between projected elements (spinner, heading, message). |
| `--color-secondary` | `#452325` (brown-500) | — | Backdrop background color in default variant. |
| `--color-light` | `#FFFFFF` | `#FFFFFF` | Backdrop background color in light variant. |
| `--z-index-xl` | `15` | — | Z-index of the overlay when visible. |
