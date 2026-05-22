# BodyText documentation

`BodyTextComponent` is a typographic wrapper that applies the design system's body text styles — font size, line height, weight, and color — to any host element. It supports multiple size steps and a dark variant, and is typically applied as an attribute directive on a semantic HTML element such as `<p>`.

## Best practices

- Apply the component as an attribute directive on a semantically correct element: use `<p corp-body-text>` for paragraphs, `<span corp-body-text>` for inline text, or `<div corp-body-text>` when grouping multiple paragraphs.
- Choose the `size` input to match the visual hierarchy of the surrounding layout. The default (no `size`) renders at the base body size and scales up on medium-breakpoint viewports.
- Use the `dark` variant only on light backgrounds where the increased contrast of `--color-secondary` is appropriate.
- Do not use this component as a heading — use the dedicated heading components from the typography system instead.
- Override color only through `u-color-*` utility classes. The component's color rule is scoped to avoid overriding those utilities.

### BodyText vs. other typography components

Use `corp-body-text` for running text: paragraphs, descriptions, captions, and labels. For prominent titles and headings, use the heading components. For small supporting text that stands apart visually, evaluate whether a dedicated label or caption component better fits the context.

## Content guidelines

Body text is the primary medium for communicating information to users. Keep it concise, consistent, and readable.

- Write in plain language — avoid jargon and overly technical terms unless the audience expects them.
- Keep paragraphs short. Dense blocks of text reduce readability, especially on mobile.
- Use sentence case for all body content.
- Do not rely on font size alone to convey hierarchy — combine size with spatial separation and heading structure.
- Avoid placing multiple competing font sizes in the same reading block without a clear visual reason.

## Related components

No related components.

## Accessibility

- The component does not impose a `role` on the host. The semantic meaning of the text comes from the element you choose as host. Always use the most appropriate native HTML element (`<p>`, `<span>`, `<li>`, etc.) so that the structure is correctly announced by screen readers.
- Projected links inside the component are styled via `::ng-deep a`. The component does not suppress browser default focus styles on these links — the default focus ring remains visible for keyboard users.
- The text color (`--color-secondary-70`) is provided by the design system token and is guaranteed to meet contrast requirements against the default background. When applying a custom `u-color-*` class, verify that the chosen color meets WCAG 1.4.3 (Contrast Minimum, AA) against its background.
- When the content of a `corp-body-text` element changes dynamically and users need to be informed of the change, add `role="status"` or `aria-live="polite"` on the host element. The component does not provide live-region behavior by default.

## Usage examples

### Default

```html
<p corp-body-text>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed magna ultricies, varius turpis ac,
	fringilla est. Duis vel interdum magna, <a href="">quis</a> dictum nunc. Suspendisse aliquet arcu est,
	vitae bibendum orci dignissim et. Nulla nec accumsan arcu, id accumsan urna. Suspendisse tellus dolor,
	imperdiet sed pharetra quis, bibendum vel felis. Nullam non gravida nisl. Aenean vel cursus eros.
	Sed sit amet leo ullamcorper, convallis dui non, pretium felis. Cras placerat, lectus in luctus egestas,
	lacus est tempor justo, non volutpat metus sem vitae enim
</p>
```
