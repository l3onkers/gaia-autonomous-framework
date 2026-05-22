# Strapline Title documentation

A compact uppercase label used to introduce or contextualise a section, acting as an eyebrow text above a main heading or content block.

## Best practices

- Use the strapline title to introduce a section heading, not as a standalone heading.
- Keep the text short — one to five words is the ideal length.
- Apply the `stroke` variant when the label needs a horizontal rule on both sides to visually divide a section.
- Apply the `lg` size only at medium breakpoints and above; the component handles the size change automatically via responsive CSS.
- Always project the strapline onto a semantically appropriate host element (`<p>`, `<span>`, `<h2>`, etc.) that matches its role in the document.

### Strapline title vs. heading components

Use the strapline title for short eyebrow labels that provide context for the content that follows. Use a heading component (`<h1>`–`<h6>`) for the actual section title that drives the document outline and is announced as a heading by screen readers.

## Content guidelines

Strapline text should be concise and complement the heading below it rather than repeat it.

- Write in uppercase conceptually — the component applies `text-transform: uppercase` automatically.
- Avoid full sentences; fragments and short noun phrases work best.
- Do not add punctuation at the end.
- Match the language and tone of the surrounding content.

## Related components

No related components.

## Accessibility

- The component applies no semantic `role` on its own. Choose a host element that is appropriate for the context: use a `<p>` or `<span>` for a decorative label, or a heading element (`<h2>`, `<h3>`, etc.) if the strapline is part of the document outline.
- When the strapline is purely decorative and its content is already conveyed by the heading below it, add `aria-hidden="true"` to the host element to remove it from the accessibility tree.
- Color contrast is provided by the design token `--color-secondary-70`. Verify that this token meets a minimum contrast ratio of 4.5:1 against the background color used in your application.
- The `stroke` variant adds decorative `::before` and `::after` pseudo-elements. These are purely visual and have no impact on the accessibility tree.
