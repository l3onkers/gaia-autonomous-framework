# FeedbackBar documentation

Feedback bars are notification components temporarily displayed to inform users about the status of an action, operation, or event. They support success, error, and general information messages, with optional close button, auto-close timer, and flexible positioning.

## Best practices

Feedback bars should:
- Display clear and concise messages that inform about the result of an action.
- Include relevant icons that visually reinforce the message type.
- Provide a manual close option when the message is not critical.
- Appear at the right moment without interrupting the user flow.
- Auto-dismiss for simple informational messages using `closeTimer`.

### Feedback bars vs. other controls

Use a **feedback bar** for temporary notifications about operation status. Use **Feedback Box** for persistent inline messages. Use **Pop-In** or **Pop-Up** for important confirmations that require user action.

## Content guidelines

- Use concise but descriptive messages.
- Include icons that reinforce the message type (success, error, information).
- Links should be specific and action-oriented.
- Avoid technical jargon or confusing terms.

## Related components

- **Feedback Box** — persistent inline messages for validation and informational feedback.
- **Pop-In** — modal dialog for important confirmations and user actions.
- **Pop-Up** — modal overlay for critical alerts and system notifications.

## Accessibility

- The component has `role="alert"` on the host, which is always present in the DOM. When the bar becomes visible, screen readers automatically announce its content — no extra ARIA needed.
- When `isVisible` is `false`, the bar is hidden with `display: none`, which removes it from the accessibility tree. Content is only announced when the bar becomes visible.
- When `showCloseButton` is `true`, provide a value for `closeButtonAriaLabel` translated to match the application's language. If omitted, the close button will have no accessible label.
- Icons projected into the bar should be decorative (`aria-hidden="true"`) unless they convey information not present in the text.
- Use `isOnTop` for critical messages that require immediate attention, keeping in mind that `role="alert"` already ensures announcement regardless of position.

## Usage examples

### Default

```html
<company-feedback-bar [isVisible]="true">
	<i corp-icon icon="check-circle-bold"></i>
	<p>
		Vamos alla ! Elijamos tu vuelo de <a href="">ida a Southampton.</a>
	</p>
</company-feedback-bar>
```

### Success

```html
<company-feedback-bar [isVisible]="true" variant="success">
	<i corp-icon icon="check-circle-bold"></i>
	<p>
		¡Bien!, tu pago se ha realizado correctamente. <a href="#"><strong>Ver detalles</strong></a>.
	</p>
</company-feedback-bar>
```

### Error

```html
<company-feedback-bar [isVisible]="true" variant="error">
	<i corp-icon icon="clear"></i>
	<p>
		<strong>Operación denegada</strong>. Por favor, revisa los errores del formulario. <a href="#"><strong>Ver detalles</strong></a>.
	</p>
</company-feedback-bar>
```
