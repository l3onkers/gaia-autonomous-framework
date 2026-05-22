# Badge contract

**Selector:** `corp-badge, [corp-badge]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `size` | `'sm' \| ''` | `''` | Inherited from BaseUIComponent. Supports `'sm'` for a reduced-size badge. |
| `variant` | `string` | `''` | Inherited from BaseUIComponent. No variants defined; reserved for future use. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `[default]` | The projected content (number or short text) to be displayed inside the circular badge. |

## Variants and states

The badge supports a single size variant:

- **`size="sm"`** — Reduced-size badge for dense contexts (e.g. navigation icons, tight list items). Sets `--badge-padding: 0.4rem` and `--badge-font-size: 1rem`.

The component uses the default primary color for the background. Override it by applying `u-bgcolor-*` utility classes on the host element to change the background color for success, warning, or danger states.

## CSS tokens

| Token | Default | sm | Purpose |
|-------|---------|-----|---------|
| `--badge-padding` | `0.6rem` | `0.4rem` | Padding inside the circular badge, controlling spacing from the edge. |
| `--badge-font-size` | `1.2rem` | `1rem` | Font size of the badge text. |
| `--color-light` | `#FFFFFF` | — | Text color (always light text for contrast). |
| `--color-primary` | `#DD0D47` | — | Default background color when no `u-bgcolor-*` is applied. |