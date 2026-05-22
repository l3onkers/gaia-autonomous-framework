# Card documentation

`CardComponent` is a general-purpose surface container that groups related content inside a rounded, bordered, and shadowed box. It composes with `CardContentComponent` to divide its internal layout into padded sections with optional dividers.

## Best practices

- Always place content inside one or more `<corp-card-content>` children. Projecting content directly into the card root bypasses the padding and divider system.
- Use `borderType="split"` when sections are clearly distinct and need a full-width separator. Use `borderType="inner"` for a more subtle inset divider that aligns with the content padding.
- Use `isClickable` only when the entire card surface triggers a single action. If the card contains multiple interactive elements (links, buttons), do not make the card itself clickable.
- Use `isSelected` to reflect externally-managed selection state. The card does not manage selection internally — drive it with an `input` from the parent.
- Set `isFocusable` together with `tabindex="0"` and appropriate keyboard handlers on the host. The input alone only applies CSS styles; it does not make the element focusable.
- Use `enableOnDesktop` for layouts that should appear flat and edge-to-edge on mobile (e.g. full-bleed sections in a mobile sheet) but render as a standard raised card on desktop.

### Card vs. other containers

Use `CardComponent` when the content needs a visible container surface with border, shadow, and structured internal sections. For specialised use cases (tariffs, services, destinations), prefer the dedicated card variants (`PriceCard`, `BasicServiceCard`, `DestinationOfferCard`) which include their own layouts and data inputs.

## Content guidelines

Content placed inside `CardComponent` should be self-contained and scannable at a glance.

- Keep section content concise. Each `corp-card-content` section should communicate one idea or data group.
- Avoid placing long prose or scrollable tables inside a card unless you explicitly add `.is-scrollable` on the `corp-card-content`.
- When nesting cards (a card inside a `corp-card-content`), use a smaller `size` on the inner card (`size="sm"` or `size="xs"`) to create visual hierarchy.
- Variant `grey` and `brand` remove the border and shadow — use them for informational or highlight blocks that should sit flush within a page layout, not as standalone interactive surfaces.

## Related components

- **Basic Service Card** — specialized card for service offerings with structured layout
- **Destination Offer Card** — specialized card for travel destination offers
- **Newsletter Subscription Card** — specialized card for subscription calls-to-action

## Usage examples

### Default

```html
<corp-card>
	<corp-card-content>
		<p corp-body-text size="sm">Lorem ipsum dolor et.</p>
	</corp-card-content>
	<corp-card-content>
		<corp-card size="sm">
			<corp-card-content>
				<p corp-body-text size="sm">AAA</p>
			</corp-card-content>
		</corp-card>
	</corp-card-content>
	<corp-card-content>
		<p corp-body-text size="sm">Lorem ipsum dolor et.</p>
	</corp-card-content>
	<corp-card-content>
		<p corp-body-text size="sm">Lorem ipsum dolor et.</p>
	</corp-card-content>
</corp-card>
```
