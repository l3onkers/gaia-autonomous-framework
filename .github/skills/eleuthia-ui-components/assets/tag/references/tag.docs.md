# Tag documentation

Tags are compact, non-interactive labels used to categorize, highlight, or add contextual information to content. They support multiple visual variants and sizes to fit different design contexts.

## Best practices

- Use tags to label or categorize items — not as interactive controls. Tags do not trigger actions.
- Choose the variant that aligns with the semantic meaning of the label: use the primary variant for the most prominent tags, `secondary` or `tertiary` for supporting context, and `bordered` for subtle, low-emphasis labels.
- Keep tag text short. A tag should communicate a single concept in one to three words.
- Use the `xs` or `sm` size when tags appear in dense layouts or alongside other compact elements.
- Do not nest interactive elements inside a tag unless the entire component is meant to behave as a button — in that case, use a native `<button>` as the host with the `[corp-tag]` attribute selector.

### Tag vs. badge

Use a **tag** when the label is part of the content and describes a category, status, or attribute of an item. Use a **badge** when you need to show a count or a numeric indicator overlaid on another element.

## Content guidelines

Tag labels should be concise and descriptive enough to stand on their own without surrounding context.

- Use sentence case (capitalize only the first word).
- Prefer nouns or short noun phrases over verbs.
- Avoid punctuation at the end of the label.
- Do not use more than three words in a single tag.
- Projected icons should reinforce the meaning of the label — do not use icons as the sole content of a tag without a visible label or an accessible alternative.

## Related components

- **Tooltip** — can be projected into the tag via its dedicated `ng-content` slot to provide additional context on hover or focus.

## Accessibility

- Tags are purely presentational by default. They carry no implicit ARIA role, so screen readers announce their text content only. If a tag communicates important status information that is not expressed elsewhere in the page, add `role="status"` or `role="note"` to the host element as appropriate.
- When the host is used as an attribute selector on a non-native element (e.g. `<div corp-tag>`), the element is not focusable or keyboard-operable. If the tag must be interactive, use a native `<button>` as the host (e.g. `<button corp-tag>`) so it is natively focusable and correctly announced by screen readers.
- Icons projected via `ng-content` are the consumer's responsibility. Add `aria-hidden="true"` to decorative icons. If an icon is the only content conveying meaning, provide a visually hidden text alternative or an `aria-label` on the host.
- When a `corp-tooltip` is projected into the tag, wire up the accessible description relationship manually using `aria-describedby` on the host and a matching `id` on the tooltip.
- The `bordered` variant uses a lower-contrast color combination. Verify that the contrast ratio between the text color (`--color-secondary-70`) and the background meets WCAG 2.2 AA (4.5:1 for normal text) in the specific design token context where the component is deployed.
