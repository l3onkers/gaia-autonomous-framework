# Error Message contract

**Selector:** `company-error-message, [company-error-message]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `icon` | `string \| undefined` | `undefined` | Optional icon name displayed before the message text. The icon is decorative and will be hidden from assistive technologies by the component. |
| `isVisible` | `boolean` | `false` | When `true`, the component switches from `display:none` to `display:flex`, triggering the `role="alert"` announcement to screen readers. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| (default) | The error message text content. |

## Variants and states

The component has no variant system. It is controlled entirely via the `isVisible` input:
- `isVisible: false` — hidden with `display:none`
- `isVisible: true` — visible with `display:flex`

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--color-primary` | `#DD0D47` | Text color of the error message. |
