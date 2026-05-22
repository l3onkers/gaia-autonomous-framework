# Logo contract

**Selector:** `corp-logo, [corp-logo]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `size` | `string \| Sizes \| undefined` | `undefined` | Size variant of the component. Available values depend on each component's configuration. |
| `variant` | `string \| undefined` | `undefined` | Visual variant of the component. Available values depend on each component's configuration. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `app-subtitle, [app-subtitle]` | Optional strapline text projected beneath the logo mark. Use to display the brand tagline (e.g., "YOUR AWESOME TAGLINE HERE"). |

## Variants and states

The component supports the following variants via the `variant` input:

- `default` — Full-color logo with icon variant `logo`. Primary brand placement.
- `flat` — Flat-color logo variant `logo-flat`. Use on dark or colored backgrounds where full-color lacks contrast.
- `text` — Text-forward horizontal treatment variant `logo-text`. Suitable for footers and email templates.
- `square` — Compact diamond mark variant `logo-diamond`. Space-constrained contexts (favicons, app icons, mobile navigation).
- `square-flat` — Flat-color diamond mark variant `logo-diamond-flat`. Compact variant with flat colors.

No size variants are available (`sizes: []` in defaults.ts).

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--color-secondary` | `(theme variable)` | Text color applied to the host element. Controls the strapline color and icon context. |
