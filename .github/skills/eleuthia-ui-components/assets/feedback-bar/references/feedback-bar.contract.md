# Feedback Bar contract

**Selector:** `company-feedback-bar, [company-feedback-bar]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `showCloseButton` | `boolean` | `false` | Shows a close button that allows users to manually dismiss the bar. |
| `closeTimer` | `number` | `0` | Automatically closes the bar after the specified milliseconds. Minimum value: 1000ms. Set to 0 to disable. |
| `isOnTop` | `boolean` | `false` | Positions the bar fixed at the top of the viewport. |
| `textAlignment` | `'center' \| 'left'` | `'center'` | Controls the text alignment inside the bar. |
| `closeButtonAriaLabel` | `string` | `undefined` | Accessible label for the close button. Translate this value to match the application's language. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `close` | `void` | Emitted when the bar is closed, either manually or via the auto-close timer. |

### Models

| Name | Type | Description |
|------|------|-------------|
| `isVisible` | `boolean` | Controls the visibility of the bar. Supports two-way binding with `[(isVisible)]`. |

## Slots

| Selector | Purpose |
|----------|---------|
| `corp-icon, [corp-icon]` | Icon element projected into the feedback bar to visually reinforce the message type. |
| default (unnamed) | Main content of the feedback bar (typically text wrapped in `<p>` tags). |

## Variants and states

- `variant="success"` — Displays success messages with tertiary background color (`--color-tertiary`).
- `variant="error"` — Displays error messages with primary background color (`--color-primary`).
- Default (no variant) — Displays general information messages with secondary background color (`--color-secondary`).

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--color-light` | `#FFFFFF` | Text color and icon color inside the bar. |
| `--color-secondary` | `#7B5C47` (brown-500) | Background color for default/information variant. |
| `--color-tertiary` | `#F5C44F` (mustard-600) | Background color for success variant. |
| `--color-primary` | `#C41E3A` (red-500) | Background color for error variant. |
| `--z-index-xl` | `15` | Z-index when positioned fixed at top (`isOnTop`). |
