# ErrorMessage documentation

Error messages are brief, specific hints that help users correct validation issues in forms or fields. They support an optional icon and explicit visibility control via the `isVisible` input.

## Best practices

Error messages should:
- Be clear, specific, and action-oriented.
- Indicate how to resolve the issue when possible.
- Be placed close to the field they refer to.
- Avoid technical jargon or irrelevant information.
- Maintain a respectful tone consistent with the brand.
- Be visible only when a real validation error exists.

### Error messages vs. other controls

Use an **error message** for field-level validation issues. Use **Feedback Bar** for global notifications about the status of an operation. Use **Pop-In** or **Pop-Up** for critical confirmations that require user action.

## Content guidelines

- Use concise and direct phrases.
- Explain the expected correction when applicable.
- Avoid blaming the user; focus on the solution.
- Maintain terminology consistency across the interface.

## Related components

- **Input Text** — form field that displays error messages below or adjacent
- **Input Select** — dropdown field with validation error display
- **Feedback Bar** — global notifications and alerts
- **Feedback Box** — feedback messages and status containers

## Accessibility

- The component has `role="alert"` on the host. Because the host starts hidden with `display:none`, the alert fires when `isVisible` becomes `true` and the element enters the accessibility tree — this is the intended and correct behaviour.
- Link the message to its field via `aria-describedby` on the input and a matching `id` on the error message host, so screen readers associate the two elements even before the error appears.
- If an icon is provided, it is decorative. Add `aria-hidden="true"` to the icon element so screen readers do not announce it alongside the text.
- Do not move focus automatically when the error appears; respect the tab order and let the user discover the message naturally.

## Usage examples

### Default

```html
<p company-error-message [isVisible]="true">This field is required</p>
```

### WithIcon

```html
<p company-error-message [isVisible]="true" icon="warning-bold">This field is required</p>
```
