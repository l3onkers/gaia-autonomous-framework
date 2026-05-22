# Subtitle documentation

The subtitle component renders a styled text block using the secondary type scale. It is applied as an attribute directive (`corp-subtitle`) on any semantic text element, allowing the consumer to choose the correct HTML tag while the component handles typography tokens, responsive sizing, and colour variants.

## Best practices

- Apply `corp-subtitle` on the HTML element that best matches the document outline: `<h2>`, `<h3>`, `<p>`, `<span>`, etc.
- Use the `size` input to adjust the type scale to the layout context (`xs`, `sm`, `lg`, `xl`). Omit it to use the default size (2.4 rem on mobile, 2.4 rem on desktop).
- Reserve the `light` variant for subtitles placed on dark or coloured backgrounds. Verify that the resulting colour contrast meets the minimum requirement (WCAG 2.2 AA, 4.5:1 for text).
- Avoid using this component for interactive text. For clickable labels use a button or link element with the appropriate component.
- Do not nest a subtitle inside another subtitle — the component contains only an `ng-content` slot and produces no structural wrapper.

### SubtitleComponent vs. other typography components

Use `corp-subtitle` for secondary headings and supporting titles. For the primary page title use the `corp-title` component. For body copy, captions, or supporting text use the appropriate text or caption component.

## Content guidelines

Subtitle text should be concise and support the primary heading that precedes it. Keep subtitles focused on a single idea so they can be scanned quickly.

- Use sentence case: capitalise the first word only.
- Avoid ending with a full stop unless the subtitle forms a complete sentence in a paragraph context.
- Aim for one or two lines at most; long subtitles compete visually with the content below.
- Do not duplicate the heading above — the subtitle should add context, not repeat it.

## Related components

No related components.

## Accessibility

- Choose the host element to match the document outline. Screen readers announce headings by level; using `<h2 corp-subtitle>` or `<h3 corp-subtitle>` is semantically correct, while `<p corp-subtitle>` is appropriate for decorative or non-heading subtitles.
- The component sets no ARIA attributes internally. If the subtitle acts as a label for a section, add `aria-labelledby` on the section pointing to the subtitle's `id`.
- When the `light` variant is used, verify colour contrast against the actual background at runtime. The design token `--color-light` does not guarantee contrast on all backgrounds.
- The component does not manage focus and contains no interactive elements; no keyboard or focus-management responsibilities fall on the consumer.
