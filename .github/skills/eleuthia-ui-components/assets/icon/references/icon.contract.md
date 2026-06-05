# Icon contract

**Selector:** `corp-icon, [corp-icon]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `iconColor` | `string` | (none) | Overrides the icon color. Accepts any valid CSS color value. |
| `isRotate` | `boolean` | `false` | When true, applies a continuous rotation animation to the icon. Useful for loading or toggle states. |
| `dynamicAxe` | `'width' \| 'height'` | (none) | Axis on which to apply dynamic aspect ratio scaling. Use when the icon has a non-square viewBox. |

### Outputs

None.

### Models

| Name | Type | Description |
|------|------|-------------|
| `icon` | `string` | Name of the icon to display, taken from the SVG sprite. |

## Slots

| Selector | Purpose |
|----------|---------|
| default (no selector) | Badge or other content projected on top of the icon (e.g. a numeric indicator via `corp-badge`). |

## Variants and states

The component supports the following size variants via the `variant` input:

- `xs` — font-size: 1.6rem
- `sm` — font-size: 2.4rem
- (default/no variant) — font-size: 3.2rem
- `lg` — font-size: 4.8rem
- `xl` — font-size: 6.4rem
- `2xl` — font-size: 8.4rem

Additional class variants (applied via `variant` or consumer CSS):
- `vmiddle` — vertical-align: middle

Transformation variants:
- `circle`, `circle-wide` — scale the SVG to 50%
- `eurowings-horizontal` — special aspect ratio for Eurowings logo

State classes:
- `is-rotate` — rotates the icon 180 degrees
- `is-dynamic-width` — scales width by aspect ratio, maintains height as 1em
- `is-dynamic-height` — maintains width as 1em, scales height by aspect ratio

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--dynamic-aspect-ratio` | `1` | Aspect ratio multiplier for non-square icons when `dynamicAxe` is set. Calculated automatically from SVG viewBox or width/height attributes. |
| `--color-light` | `#FFFFFF` | Used as border color for badges projected into the icon (via `::ng-deep`). |
