# Image Filter contract

**Selector:** `company-image-filter, [company-image-filter]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `variant` | `string` | `''` | Variant name from the options (e.g. `'grayscale'`). Applied to the host element via class binding. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `img` | Receives the native `<img>` element. Position fixed at `z-index: -1` with `object-fit: cover` and `object-position: center center`. |
| `company-overlay, [company-overlay]` | Receives the overlay component projected in the second slot to apply colour tint or gradient over the image. |
| (default, no select) | Generic slot for arbitrary content (text, buttons, etc.) overlaid on top of the image and overlay. |

## Variants and states

| Variant | Purpose |
|---------|---------|
| `grayscale` | Desaturates the image via CSS `filter: grayscale(100%)` and adjusts the overlay blend mode to `screen` for better visibility of text on top. |

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--z-index-sm` | (theme variable) | Stack level for the host element itself. |
