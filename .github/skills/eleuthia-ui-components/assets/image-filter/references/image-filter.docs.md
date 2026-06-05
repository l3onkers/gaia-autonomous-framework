# ImageFilterComponent documentation

`ImageFilterComponent` is a full-bleed image container that stacks a projected `<img>`, an optional overlay, and arbitrary content on top of each other. It supports a `grayscale` variant that desaturates the image and adjusts the overlay blend mode.

## Best practices

- Always nest `company-image-filter` inside `corp-image-ratio` so that the aspect ratio is controlled by the parent. The component uses `position: absolute` and fills 100% of its container.
- Project a native `<img>` in the first slot and give it a meaningful `alt` attribute. Then add `aria-hidden="true"` to the `<img>` so that the host's `role="img"` is the single image landmark announced by screen readers.
- Add `aria-label` (or `aria-labelledby`) on the host element so that assistive technologies can announce a meaningful name for the image region.
- Use the `grayscale` variant for images that represent inactive, unavailable, or past destinations.
- When projecting `company-overlay`, place it after the `<img>` in markup order so that the visual stacking (overlay above image, content above overlay) matches the DOM order.
- Avoid projecting interactive elements (buttons, links) in the default slot without ensuring they are reachable by keyboard and are not obscured by the overlay's `z-index`.

## Content guidelines

The projected `<img>` alt text describes the image content for users who cannot see it. Follow these rules:

- Write the alt text as a concise description of the scene, not a file name or generic label (e.g., "Marseille Calanques coastline at sunset", not "image" or "photo").
- If the image is purely decorative and the host's `aria-label` already conveys the full meaning, the `<img>` should still receive an empty `alt=""` in addition to `aria-hidden="true"`.
- Keep overlaid text short and legible. The overlay reduces image contrast, but do not rely on that alone for text readability — use appropriate font size and weight tokens.
- Avoid placing long body copy directly over the image. Reserve the overlay for short labels, destination names, or calls to action.

## Related components

- **Overlay** — projected into the second slot to apply a colour tint or gradient over the image.
- **ImageRatio** — the recommended container that establishes the aspect-ratio box in which `company-image-filter` is absolutely positioned.

## Usage examples

### Default

```html
<corp-image-ratio size="2x1">
	<company-image-filter aria-label="Marseille destination">
		<img src="https://example.com/marseille.jpg" alt="" aria-hidden="true">
		<company-overlay variant="regular"></company-overlay>
		<div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; z-index: 1;">
			<h2 corp-title size="sm" variant="light">MARSEILLE</h2>
		</div>
	</company-image-filter>
</corp-image-ratio>
```

### Grayscale

```html
<corp-image-ratio size="2x1">
	<company-image-filter variant="grayscale" aria-label="Unavailable destination">
		<img src="https://example.com/marseille.jpg" alt="" aria-hidden="true">
		<company-overlay variant="regular"></company-overlay>
		<div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; z-index: 1;">
			<h2 corp-title size="sm" variant="light">COMING SOON</h2>
		</div>
	</company-image-filter>
</corp-image-ratio>
```
