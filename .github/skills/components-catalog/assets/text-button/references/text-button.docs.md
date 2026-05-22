# Text Button documentation

Text buttons are simple elements that display only text and, optionally, an icon to the right or left. They have no added styles (such as background or border), so their function is to offer secondary, tertiary, or low-emphasis actions within the interface. They are ideal for actions that should not visually compete with others but must remain accessible to the user.

## Best practices

Text buttons should:
- Have clear and precise labels.
- Use direct and simple action verbs.
- Be used for secondary, tertiary, or low-emphasis actions.
- Not visually compete with the main button in the interface.
- Maintain consistent locations within the interface.

### Buttons vs. Links

Use a **text button** for actions that modify data, cancel, close, show details, or trigger secondary processes in the application. Use a **link** only for navigation, that is, when the goal is to take the user to another page or section, without performing a direct action on the data.

## Content guidelines

Text buttons should be clear and predictable. The user should be able to anticipate what will happen when clicking. Never confuse the user with ambiguous or incorrect labels.

- Use universal iconography only if it adds context.
- The button can include only text, only an icon, or both.
- Prefer short phrases without unnecessary articles.
- Use sentence case (only the first word capitalized).
- Avoid unnecessary punctuation.

## Related components

Explore other button options:

- **Rectangle button** — a solid button for primary actions with customizable colors and sizes.
- **Rounded button** — a button with rounded corners for secondary or tertiary actions.

## Accessibility

- Always use a native `<button>` element as the host (e.g. `<button corp-text-button>`). Native buttons are natively focusable, operable via keyboard, and correctly announced by screen readers without extra ARIA. Only use a non-native element when strictly necessary, and add the appropriate `role` and `aria-*` attributes manually.
- When `isDisabled` is `true`, the component applies the `is-disabled` CSS class and sets the native `disabled` attribute on the host. This attribute only has semantic effect on native form elements such as `<button>`. If the host is a non-native element (e.g. `<a>`), add `aria-disabled="true"` manually.
- Icons projected into the button via `ng-content` are the consumer's responsibility. Add `aria-hidden="true"` to decorative icons, or provide an accessible label if the icon conveys meaning independent of the button text.
- When `isActive` is `true`, the component applies only a CSS class (`is-active`). It does not add any ARIA state. If the button represents a toggle (e.g., an active filter or a pressed state), add `aria-pressed="true"` to the host. If it signals the current item in a navigation context, use `aria-current="page"` or `aria-current="step"` instead.
- When the button contains only an icon and no visible text, the `<span class="c-btn-text__text">` is hidden via `display: none`. In this case the button has no accessible name — add `aria-label` to the host element to describe the action (e.g. `<button corp-text-button aria-label="Add item">`).
- Do not suppress the browser's default focus ring or any custom focus styles — keyboard users rely on visible focus indicators to navigate.
