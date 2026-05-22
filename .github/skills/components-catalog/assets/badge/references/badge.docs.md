# Badge documentation

The Badge component is a compact circular indicator that displays a short number or label. It is typically used to signal counts or status (e.g. unread notifications) and is often overlaid on icons or avatars.

## Best practices

- Use the badge exclusively for numeric counts or very short labels (one or two characters). Longer text will overflow the circular shape.
- Keep the number meaningful — only show a badge when the count requires the user's attention.
- Use `size="sm"` in dense contexts such as navigation icons or tight list items where the default size would be visually disruptive.
- Apply `u-bgcolor-*` utility classes on the host to change the background color when the default primary color does not fit the design context (e.g. success, warning, or danger states).
- Avoid stacking multiple badges on the same element; choose the most relevant one.

### Badge vs. tag

Use a **badge** for numeric counts that update dynamically (unread messages, cart items). Use a tag (chip/label) when the label is static, descriptive text that classifies or categorises content rather than quantifying it.

## Content guidelines

- Prefer plain integers (e.g. `3`, `12`). Avoid decimals or currency inside a badge.
- When the count exceeds a reasonable display threshold, show a capped value with a plus sign (e.g. `99+`) — handle this formatting in the consumer, not in the component.
- Never use empty badges without content; an empty circle conveys no information and may confuse screen reader users.

## Related components

- **Avatar** — often used alongside or within a badge for profile pictures or user indicators.
- **Icon** — frequently combined with badges to add visual context.

## Accessibility

- The badge has no `role` set internally. When it represents a live count that updates (e.g. new notifications arriving), add `role="status"` or wrap it in an `aria-live="polite"` region so screen readers announce the change.
- The projected text content is the only accessible name of the badge. If the badge is placed next to or over another element (icon, avatar), add `aria-label` to the badge host or to the surrounding interactive element to give the count full context (e.g. `aria-label="3 unread notifications"`).
- When the badge is used purely as a visual decoration and its count is already conveyed by surrounding text, add `aria-hidden="true"` to the host to prevent redundant announcements.
- Color alone is not used to convey meaning — the number itself carries the information — but ensure the text-to-background contrast meets WCAG AA (4.5:1). The default primary-color background paired with `--color-light` text meets this requirement; verify contrast when overriding with `u-bgcolor-*`.

## Usage examples

### Default

```html
<p corp-badge>
	2
</p>
```

### Small size

```html
<p corp-badge size="sm">
	5
</p>
```

### With custom background color

```html
<p corp-badge class="u-bgcolor-success">
	3
</p>
```

### As an attribute directive

```html
<span corp-badge>
	12
</span>
```
