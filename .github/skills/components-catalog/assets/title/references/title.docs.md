# Title documentation

`TitleComponent` is a typographic wrapper that applies the design system's title styles — condensed font, bold weight, uppercase transform, and design-token color — to any host element. It supports multiple size steps and a light color variant, and is typically applied as an attribute directive on a semantic HTML element such as `<h1>` or `<p>`.

## Best practices

- Apply the component as an attribute directive on a semantically correct element. Use `<h1 corp-title>` through `<h6 corp-title>` when the text serves as a section heading, or `<p corp-title>` when it is a prominent display label that does not function as a heading in the document outline.
- Choose the `size` input to reflect the visual hierarchy of the surrounding layout. The default (no `size`) renders at 2.4 rem on mobile and scales to 3.2 rem on medium-breakpoint viewports.
- Use the `light` variant only on dark or saturated backgrounds where `--color-light` provides sufficient contrast. Do not use it on white or light backgrounds.
- Do not use this component for body copy, captions, or labels — use the dedicated `corp-body-text` component for running text.
- Avoid placing multiple competing `corp-title` elements at the same visual weight in the same section without a clear hierarchical reason.

### Title vs. other typography components

Use `corp-title` for prominent display text: page titles, section headings, and marketing headlines. For body copy, descriptions, and captions, use `corp-body-text`. For small supporting labels that do not carry heading semantics, evaluate whether a dedicated label component better fits the context.

## Content guidelines

Title text anchors the visual hierarchy of a screen. Keep it short, impactful, and consistent with the surrounding context.

- Write titles in the language of the application. The component applies `text-transform: uppercase` in CSS — write the source text in the intended case rather than relying on the transform for meaning.
- Keep titles concise. The component applies `text-wrap: balance` and `overflow-wrap: break-word` to handle long strings, but shorter titles produce a more balanced layout.
- Do not use punctuation at the end of standalone titles unless the title is a question or exclamation.
- Avoid using title styles for full sentences or multi-line paragraphs — the condensed uppercase treatment reduces readability at longer lengths.

## Related components

No related components.

## Accessibility

- The component does not impose a `role` on the host. The semantic meaning of the text is determined entirely by the element you choose as host. When the title functions as a document or section heading, always use a native heading element (`<h1>` through `<h6>`) so that the heading structure is correctly exposed to assistive technologies (WCAG 1.3.1, Info and Relationships).
- When the title is purely decorative or presentational and does not function as a heading in the document outline, a `<p>` or `<div>` host is acceptable. In that case verify that no heading hierarchy gap is created in the surrounding content.
- The default text color (`--color-secondary`) is provided by the design system token and meets WCAG 1.4.3 (Contrast Minimum, AA) against the default background. When using the `light` variant, ensure that the background color provides sufficient contrast against `--color-light`.
- `text-transform: uppercase` is applied by the component. Screen readers announce the text as written in the source markup, not as it visually appears. Write source text in regular mixed case if the uppercase treatment is purely decorative.
- When the content of a `corp-title` element changes dynamically and users need to be informed of the change, add `role="status"` or `aria-live="polite"` on the host element. The component does not provide live-region behavior by default.
