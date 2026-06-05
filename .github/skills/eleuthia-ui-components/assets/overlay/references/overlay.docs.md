# Overlay documentation

`OverlayComponent` is a full-bleed decorative layer that paints a colour tint over its positioned container using CSS pseudo-elements. It is always projected as a child of another component (such as `company-banner` or `company-image-filter`) to control the visual depth of a background image.

## Best practices

- Always place `company-overlay` inside a container that has `position: relative` (or any other positioning context). The overlay uses `position: absolute` and fills 100% of its parent — without a positioning context it will overflow or position against the nearest positioned ancestor.
- Choose the variant that provides enough contrast between the background image and the text content placed above the overlay. Use `light` for subtle tints, `regular` for moderate contrast, `dark` or `heavy` when text must remain legible over a bright or complex image.
- When using the overlay as a purely decorative tint, always add `aria-hidden="true"` to the `<company-overlay>` host element so that it is removed from the accessibility tree.
- When using the overlay as a clickable backdrop (e.g. to close a mobile menu or a modal panel), bind the `(click)` event on the host element. Do not add an additional wrapper element solely for click handling.
- The `grayscale` variant is declared in `defaults.ts` but has no CSS rules defined in the component stylesheet. Do not use `variant="grayscale"` directly on `company-overlay` — the grayscale effect is applied by the parent `company-image-filter` component via its own variant logic.
- Maintain DOM order: place `company-overlay` after the background `<img>` and before any content that must appear above the tint, so that the visual stacking order matches the markup order.

### Overlay vs. other visual layers

Use `company-overlay` when you need a controllable colour tint between a background image and foreground content. Do not use it as a modal backdrop — for that, rely on the dedicated overlay mechanism provided by the dialog or drawer component. Do not use it as a loading indicator or skeleton; those have their own dedicated components.

## Content guidelines

The overlay carries no text content and is fully visual. These guidelines apply to the context in which it is used:

- Always ensure the text or interactive content placed above the overlay has sufficient contrast against the combined image-plus-tint background. Use the browser's devtools accessibility panel or a contrast checker to verify.
- Do not place long body copy directly over an overlay. Reserve overlaid content for short labels, destination names, prices, or single calls to action.
- The overlay does not communicate information on its own. If the presence or absence of the overlay changes the meaning of the UI for the consumer, document that logic in the parent component's content guidelines instead.

## Related components

- **Image Filter** — projects `company-overlay` as its second content slot to add a tint over a destination image.
- **Banner** — projects `company-overlay` as a named content slot to tint the background image of a hero section.

## Accessibility

- When the overlay is used as a decorative tint, add `aria-hidden="true"` directly on the `<company-overlay>` element. Without it, the host is present in the accessibility tree as an anonymous element, which adds noise for screen reader users.
- When the overlay acts as a clickable backdrop (for example, to dismiss a mobile menu), it becomes an interactive element. In that case the consumer must ensure it receives an accessible name and, if it is not a native `<button>`, the appropriate `role` attribute so that keyboard users can activate it.

## Usage examples

### Default (heavy variant)

```html
<div style="position: relative; width: 100%; height: 280px; overflow: hidden; display: block;">
	<img
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;"
		src="https://static.company.com/assets/img/stations/agp_4-1.jpg"
		alt=""
		aria-hidden="true"
	/>
	<company-overlay aria-hidden="true"></company-overlay>
</div>
```

### Light variant

```html
<div style="position: relative; width: 100%; height: 280px; overflow: hidden; display: block;">
	<img
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;"
		src="https://static.company.com/assets/img/stations/agp_4-1.jpg"
		alt=""
		aria-hidden="true"
	/>
	<company-overlay aria-hidden="true" [variant]="'light'"></company-overlay>
</div>
```

### Regular variant

```html
<div style="position: relative; width: 100%; height: 280px; overflow: hidden; display: block;">
	<img
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;"
		src="https://static.company.com/assets/img/stations/agp_4-1.jpg"
		alt=""
		aria-hidden="true"
	/>
	<company-overlay aria-hidden="true" [variant]="'regular'"></company-overlay>
</div>
```

### Dark variant

```html
<div style="position: relative; width: 100%; height: 280px; overflow: hidden; display: block;">
	<img
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;"
		src="https://static.company.com/assets/img/stations/agp_4-1.jpg"
		alt=""
		aria-hidden="true"
	/>
	<company-overlay aria-hidden="true" [variant]="'dark'"></company-overlay>
</div>
```

### Heavy variant

```html
<div style="position: relative; width: 100%; height: 280px; overflow: hidden; display: block;">
	<img
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;"
		src="https://static.company.com/assets/img/stations/agp_4-1.jpg"
		alt=""
		aria-hidden="true"
	/>
	<company-overlay aria-hidden="true" [variant]="'heavy'"></company-overlay>
</div>
```

### Clickable backdrop

```html
<div style="position: relative; width: 100%; height: 280px; overflow: hidden; display: block; cursor: pointer;">
	<img
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;"
		src="https://static.company.com/assets/img/stations/agp_4-1.jpg"
		alt=""
		aria-hidden="true"
	/>
	<company-overlay [variant]="'heavy'" (click)="onOverlayClick()"></company-overlay>
</div>
```
