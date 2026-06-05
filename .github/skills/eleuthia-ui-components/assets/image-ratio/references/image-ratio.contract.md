# Image Ratio contract

**Selector:** `corp-image-ratio, [corp-image-ratio]`

## API

### Inputs

None.

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `company-image-filter, [company-image-filter]` | Projects an `image-filter` component that wraps the image with a color overlay. |
| `img` | Projects the `<img>` element directly when no overlay is needed. |

## Variants and states

The component uses the `size` and `variant` inputs (inherited from `BaseUIComponent`) to control aspect ratio and focal-point alignment:

### Available sizes

- `2x1` — aspect ratio 2:1
- `2x3` — aspect ratio 2:3
- `3x2` — aspect ratio 3:2
- `4x3` — aspect ratio 4:3
- `16x9` — aspect ratio 16:9
- `absolute` — fills positioned parent (position: absolute; top: 0; left: 0; width: 100%; height: 100%)
- (default) — 1:1 square aspect ratio

### Available variants

- `is-top` — object-position: center top
- `is-bottom` — object-position: center bottom
- `is-left` — object-position: left center
- `is-right` — object-position: right center
- `is-left-top` — object-position: left top
- `is-right-top` — object-position: right top
- `is-left-bottom` — object-position: left bottom
- `is-right-bottom` — object-position: right bottom

### Internal variant

- `is-checkin-summary` — aspect ratio 38:13 with margin-bottom: -4rem and z-index: -1 (visible on mobile, hidden on md breakpoint and above)

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `aspect-ratio` | `1` (1:1) | Controls the image container's aspect ratio; overridden by size classes (e.g., `u-image-ratio--2x1` sets 2/1) |
| `overflow` | `hidden` | Ensures image content is clipped to the aspect-ratio bounds |
| `display` | `block` | Sets the host as a block-level container |
| `object-fit` | `cover` | Ensures the image fills the container while maintaining its intrinsic aspect ratio |
| `object-position` | `center center` | Default focal point; overridden by variant classes (e.g., `u-image-ratio--is-top` sets center top) |
