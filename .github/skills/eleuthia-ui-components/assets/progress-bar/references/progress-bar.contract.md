# Progress Bar contract

**Selector:** `corp-progress-bar, [corp-progress-bar]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isVisible` | `boolean` | `false` | Whether the progress bar track and fill are visible. When `false`, the bar is hidden via `opacity: 0` but the host element with `role="progressbar"` remains in the DOM. Bind `aria-hidden` on the host when this is `false` to remove it from the accessibility tree. |
| `isOnTop` | `boolean` | `false` | When `true`, positions the bar fixed at the top of the viewport with a high z-index, typically used as a page-level loading indicator. |

### Outputs

None.

### Models

None.

## Slots

None.

## Variants and states

The component supports the following variants via the `variant` input (managed by `BaseUIComponent`):

- `is-loading` — quick fill animation from 90% to 100%
- `is-loading-with-steps` — multi-step animated fill (0% → 20% → 25% → 50% → 90% → 100%)
- `is-waiting` — indeterminate animation with a progress segment moving across the bar
- `is-loaded` — fills to 100% and holds
- `is-15s` — linear fill over 15 seconds
- `is-30s` — linear fill over 30 seconds
- Percentage variants: `is-0-percent`, `is-5-percent`, `is-10-percent`, ..., `is-100-percent` (5% increments) — static width at the specified percentage

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--color-primary` | `#DD0D47` (red-500) | Background color of the progress fill bar |
| `--color-secondary-10` | `#ECE9E9` (brown-100) | Background color of the track (base) |
| `--z-index-xl` | `15` | Z-index used when `isOnTop` is `true` for fixed positioning |

Height is set to `0.375rem` (6px) for both track and fill. Width transitions with `0.3s ease-in-out` easing.
