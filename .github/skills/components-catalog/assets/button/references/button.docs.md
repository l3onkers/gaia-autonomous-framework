# Button documentation

Rectangle buttons are used primarily for important actions, such as "Add", "Save", or "Submit". They feature a rectangular shape and their background style may vary depending on the selected variant, helping to visually distinguish different types of actions within the interface.

## Best practices
Buttons should:
- Have clear and precise labels.
- Use direct action verbs.
- Apply variant colors according to their purpose.
- Prioritize the primary action and avoid showing too many buttons together.
- Maintain consistent locations within the interface.

### Buttons vs. Links
Use a **button** for actions that modify data, submit forms, or trigger processes in the application. Use a **link** only for navigation, that is, when the goal is to take the user to another page or section, without performing a direct action on the data.

## Content guidelines

Buttons should be clear and predictable. Users should be able to anticipate what will happen when they click it. Never confuse users with ambiguous or incorrect labels.

- Use universally understood iconography when possible.
- Buttons can include an icon, text, or both.
- Verbs like "View", "Go" or "Read" are often unnecessary if the action is already clear.
- Use sentence case (capitalize only the first word).
- Avoid unnecessary articles ("the", "a", "an").
- Don't use punctuation.

## Related components

- [**Icon**](?path=/docs/base-components-icon--documentation) — projected into the button via `ng-content` to add visual context alongside the label.

## Accessibility

- Always use a native `<button>` element as the host (e.g. `<button corp-button>`). Native buttons are natively focusable, operable via keyboard, and correctly announced by screen readers without extra ARIA. Only use a non-native element when strictly necessary, and add the appropriate `role` and `aria-*` attributes manually.
- When `isDisabled` is `true`, the component applies the `is-disabled` CSS class and sets the native `disabled` attribute on the host. This attribute only has semantic effect on native form elements such as `<button>`. If the host is a non-native element (e.g. `<a>`), add `aria-disabled="true"` manually.
- When `isLoading` is `true`, the component sets `aria-busy="true"` on the host automatically — no extra attribute is needed from the consumer.
- Icons projected into the button via `ng-content` are the consumer's responsibility. Add `aria-hidden="true"` to decorative icons, or provide an accessible label if the icon conveys meaning independent of the button text.
- Do not suppress the browser's default focus ring or any custom focus styles — keyboard users rely on visible focus indicators to navigate.

## Usage examples

### Default

```html
<button corp-button>
	Click me
</button>
```

### WithIcon

```html
<button corp-button>
	<i corp-icon icon="user-bold"></i>
	Click me
</button>
```

### Disabled

```html
<button corp-button [isDisabled]="true">
	Click me
</button>
```

### Loading

```html
<button corp-button [isLoading]="true">
	Click me
</button>
```

### FullWidth

```html
<button corp-button [isFullwidth]="true">
	Click me
</button>
```

### Small

```html
<button corp-button size="sm">
	Click me
</button>
```

### Secondary

```html
<button corp-button variant="secondary">
	Click me
</button>
```

### Tertiary

```html
<button corp-button variant="tertiary">
	Click me
</button>
```

### Quaternary

```html
<button corp-button variant="quaternary">
	Click me
</button>
```
