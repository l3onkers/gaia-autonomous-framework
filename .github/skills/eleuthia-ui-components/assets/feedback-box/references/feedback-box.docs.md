# Feedback Box documentation

Feedback boxes display persistent inline messages, status updates, or contextual information. They support success, info, alert, and section variants, and accept optional icons and rich text content via projection.

## Best practices

- Use the appropriate variant to convey the message type clearly: `success` for confirmations, `info` for general notices, `alert` for warnings or errors, and `section` for standalone contextual blocks with card-style treatment.
- Include a relevant icon when it reinforces the message — omit it when it adds no value.
- Keep messages concise and focused on what the user needs to know or do.
- Use `lg` size for standalone or prominent messages; default size for inline or secondary content.

### Feedback boxes vs. other controls
Use a **feedback box** for persistent inline messages. Use **Feedback Bar** for temporary notifications that auto-dismiss. Use **Pop-In** or **Pop-Up** for confirmations that require user action.

## Content guidelines

Text inside a feedback box should be clear enough to stand alone without relying on color or icon alone to convey meaning.

- Use descriptive messages that provide context and, when relevant, a next step.
- Links should be specific and action-oriented.
- Avoid single-word labels like "Success", "Info", or "Alert" as the entire message.

## Related components

- **Feedback Bar** — for temporary notifications that auto-dismiss
- **Pop-In** — for confirmations that require user action
- **Pop-Up** — for confirmations that require user action

## Accessibility

- This component does not set any ARIA role. The consumer is responsible for adding the appropriate role based on the context of use:
  - Static informational content that is always visible → no role needed.
  - Content that appears dynamically in response to a user action → add `role="alert"` or `aria-live="polite"` on the host element.
- Icons projected into the box should be decorative (`aria-hidden="true"`) since the text already conveys the message.
- Links and interactive elements projected inside the box are the consumer's responsibility — ensure they have visible focus indicators and descriptive labels.

## Usage examples

### Default

```html
<company-feedback-box>
  <p corp-body-text>
    <strong>Lorem, ipsum dolor sit amet consectetur.</strong>
  </p>
</company-feedback-box>

<company-feedback-box class="u-mt-16">
  <p corp-body-text>
    <strong>Lorem, ipsum dolor sit amet consectetur</strong>. Quibusdam aspernatur ex nobis hic quaerat consequuntur
    maxime corrupti, quis voluptate. Sequi nam facere dolor voluptatibus nesciunt qui <a href="">atque natus</a> officiis iure.
  </p>
</company-feedback-box>
```

### CustomIcon

```html
<company-feedback-box>
  <i corp-icon icon="seat" size="sm"></i>
  <p>
    <strong>Lorem, ipsum dolor sit amet consectetur adipisicing elit</strong>. Quibusdam aspernatur ex nobis hic quaerat consequuntur
    maxime corrupti, quis voluptate. Sequi nam facere dolor voluptatibus nesciunt qui <a href="">atque natus</a> officiis iure.
  </p>
</company-feedback-box>
```

### Success

```html
<company-feedback-box variant="success">
  <p corp-body-text>
    <strong>Lorem, ipsum dolor sit amet consectetur adipisicing elit</strong>. Quibusdam aspernatur ex nobis hic quaerat consequuntur
    maxime corrupti, quis voluptate. Sequi nam facere dolor voluptatibus nesciunt qui <a href="">atque natus</a> officiis iure.
  </p>
</company-feedback-box>
```

### Info

```html
<company-feedback-box variant="info">
  <p corp-body-text>
    <strong>Lorem, ipsum dolor sit amet consectetur adipisicing elit</strong>. Quibusdam aspernatur ex nobis hic quaerat consequuntur
    maxime corrupti, quis voluptate. Sequi nam facere dolor voluptatibus nesciunt qui <a href="">atque natus</a> officiis iure.
  </p>
</company-feedback-box>
```

### Alert

```html
<company-feedback-box variant="alert">
  <p corp-body-text>
    <strong>Lorem, ipsum dolor sit amet consectetur adipisicing elit</strong>. Quibusdam aspernatur ex nobis hic quaerat consequuntur
    maxime corrupti, quis voluptate. Sequi nam facere dolor voluptatibus nesciunt qui <a href="">atque natus</a> officiis iure.
  </p>
</company-feedback-box>
```
