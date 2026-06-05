# Logo documentation

The Logo component renders the Company brand mark as a scalable SVG icon with optional strapline text. It supports multiple visual variants — full-color, flat, text-only, and diamond — to suit different layout contexts and brand placement needs.

## Best practices

- Use the default variant for primary brand placement such as the main navigation header.
- Use `variant="flat"` on dark or colored backgrounds where the full-color version lacks sufficient contrast.
- Use `variant="text"` when a horizontal, text-forward logo treatment is needed (e.g., footers, email templates).
- Use `variant="square"` or `variant="square-flat"` in space-constrained contexts such as favicons, app icons, or mobile navigation where a compact mark is preferred over the full wordmark.
- Always wrap the logo in an `<a>` element when it functions as a navigation link to the homepage.
- Do not place the logo inside another interactive element (e.g., a button) if it is already wrapped in an `<a>`.
- The strapline (`app-subtitle`) is optional — only include it when the layout has sufficient space and the tagline adds meaningful brand context.

### Logo vs. icon

`corp-logo` renders the official Company brand mark. Use it for brand identity placement. For generic UI icons (arrows, checkmarks, decorative glyphs), use `corp-icon` directly instead.

## Content guidelines

The strapline text projected via `app-subtitle` should follow these rules:

- Keep the strapline short — a single uppercase phrase (e.g., `YOUR AWESOME TAGLINE HERE`).
- Do not translate the strapline unless the brand guidelines explicitly allow localized versions of the tagline.
- Do not substitute the strapline with arbitrary marketing copy — it is a brand tagline, not a generic subtitle slot.
- Omit the strapline entirely for compact variants (`square`, `square-flat`) — the diamond mark is used without accompanying text.

## Related components

- **Icon** — the icon component used internally to render the logo SVG mark.
- **Strapline Title** — the text component projected via `ng-content` to display the brand tagline beneath the logo mark.

## Accessibility

- When `corp-logo` is placed on an `<a>` element, add `aria-label` on the host to provide an accessible name for the link (e.g., `aria-label="Company — Go to homepage"`). The logo mark is a graphical element and does not provide a text alternative on its own.
- The icon rendered inside the template currently lacks `aria-hidden="true"`. Until this is resolved in the component, assistive technology may announce the icon alongside the host element's accessible name, resulting in redundant output.
- When the logo is purely decorative (not a link, not interactive), apply `aria-hidden="true"` to the host element to remove it from the accessibility tree entirely.

## Usage examples

### Default with strapline

```html
<a corp-logo>
	<p app-subtitle>
		YOUR AWESOME TAGLINE HERE
	</p>
</a>
```

### Flat variant

```html
<a corp-logo variant="flat">
	<p app-subtitle>
		YOUR AWESOME TAGLINE HERE
	</p>
</a>
```

### Text variant

```html
<a corp-logo variant="text">
	<p app-subtitle>
		YOUR AWESOME TAGLINE HERE
	</p>
</a>
```

### Diamond (square) variant

```html
<a corp-logo variant="square"></a>
```

### Diamond flat variant

```html
<a corp-logo variant="square-flat"></a>
```
