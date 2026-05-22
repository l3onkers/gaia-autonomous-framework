# Image Ratio documentation

`ImageRatioComponent` is a layout wrapper that constrains a projected `<img>` (or an `<img>` inside `company-image-filter`) to a fixed aspect ratio, cropping the image with `object-fit: cover` to fill the available space.

## Best practices

- Always project a single `<img>` element directly inside `corp-image-ratio`, or wrap it in `company-image-filter` when a color overlay is needed.
- Choose the `size` input to set the aspect ratio: `2x1`, `2x3`, `3x2`, `4x3`, or `16x9`. When no size is provided the component defaults to a 1:1 square.
- Use the `variant` input to control focal-point alignment when the image subject is not centered: `is-top`, `is-bottom`, `is-left`, `is-right`, and the diagonal combinations (`is-left-top`, `is-right-top`, `is-left-bottom`, `is-right-bottom`).
- Use `size="absolute"` when the container needs to fill a positioned parent completely (the component becomes `position: absolute; top: 0; left: 0; width: 100%; height: 100%`). The parent must have `position: relative` (or another non-static value).
- Avoid placing additional content beside the `<img>` inside the component — the slot is designed for a single image node.

### ImageRatioComponent vs. a plain `<img>` with CSS

Use `ImageRatioComponent` when the design requires a fixed aspect-ratio crop that must be consistent across breakpoints. For fluid images where the intrinsic dimensions can be preserved, a plain `<img>` with `width: 100%` is sufficient and simpler.

## Content guidelines

The image projected into this component is a visual asset, not a text element. Apply these guidelines to keep the experience meaningful:

- Provide a descriptive `alt` attribute on the `<img>` that conveys the subject of the image to users who cannot see it.
- Use `alt=""` only when the image is truly decorative and adds no informational value — and in that case also add `aria-hidden="true"` to the `corp-image-ratio` host element so that the `role="img"` container is removed from the accessibility tree.
- Keep `alt` text concise and factual — describe what is depicted, not the file name or URL.
- Avoid duplicating surrounding text content in the `alt` attribute; if a visible caption already describes the image, an empty `alt=""` (with `aria-hidden="true"` on the host) is preferred.

## Related components

- **Image Filter** — adds a color overlay on top of the projected image; designed to be projected inside `corp-image-ratio`.

## Accessibility

The host element has `role="img"` set internally. An element with this role requires an accessible name. Always add `aria-label="[description of the image]"` or `aria-labelledby="[id of a visible caption]"` to the `corp-image-ratio` host element.

The projected `<img>` also carries the native `img` role, creating a nested image structure in the accessibility tree. To avoid double announcement by screen readers, add `aria-hidden="true"` to the projected `<img>` when the accessible name is provided on the host via `aria-label`.

When the image is purely decorative, add `aria-hidden="true"` to the `corp-image-ratio` host element so the entire container — including its `role="img"` — is removed from the accessibility tree.

## Usage examples

### Default

```html
<corp-image-ratio>
	<img src="https://volare-static.company.com/wp-content/uploads/2021/05/calanques-marseille.jpg" alt="Marseille Calanques">
</corp-image-ratio>
```

### With 2x1 aspect ratio

```html
<corp-image-ratio size="2x1">
	<img src="https://example.com/image.jpg" alt="Image description">
</corp-image-ratio>
```

### With focal-point variant

```html
<corp-image-ratio size="3x2" variant="is-top">
	<img src="https://example.com/image.jpg" alt="Image description">
</corp-image-ratio>
```

### With image filter overlay

```html
<corp-image-ratio size="16x9">
	<company-image-filter>
		<img src="https://example.com/image.jpg" alt="Image description">
	</company-image-filter>
</corp-image-ratio>
```

### Absolute positioning (fills parent)

```html
<div style="position: relative; width: 300px; height: 300px;">
	<corp-image-ratio size="absolute">
		<img src="https://example.com/image.jpg" alt="Image description">
	</corp-image-ratio>
</div>
```
