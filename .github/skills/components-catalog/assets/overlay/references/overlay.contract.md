# Overlay contract

**Selector:** `company-overlay, [company-overlay]`

## API

### Inputs

None.

### Outputs

None.

### Models

None.

## Slots

None.

## Variants and states

- `light` — subtle tint (primary opacity 0.1, secondary hidden)
- `regular` — moderate contrast (primary opacity 0.15, secondary opacity 0.1)
- `dark` — strong contrast (secondary opacity 0.6, after hidden)
- `heavy` — maximum contrast (primary opacity 0.45, secondary opacity 0.9)
- `grayscale` — declared in defaults but has no CSS rules; applied by parent image-filter component

## CSS tokens

| Token | Default | light | regular | dark | heavy | Purpose |
|-------|---------|-------|---------|------|-------|---------|
| `--color-primary` | `#DD0D47` | `opacity: 0.1` | `opacity: 0.15` | — | `opacity: 0.45` | Red tint applied via `::before` pseudo-element |
| `--color-secondary` | `#452325` | — | `opacity: 0.1` | `opacity: 0.6` | `opacity: 0.9` | Brown tint applied via `::after` pseudo-element |
