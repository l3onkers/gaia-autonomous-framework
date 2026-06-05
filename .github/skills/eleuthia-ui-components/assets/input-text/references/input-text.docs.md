# Input text documentation

Text input fields are fundamental components for data entry in forms. They allow users to enter information such as names, email addresses, passwords, and other text data. The `corp-input-text` component provides a consistent and accessible interface for text input with support for icons, auxiliary buttons, and validation states.

## Best practices

Text input fields should:
- Have clear and descriptive labels that indicate what information is expected.
- Include helpful placeholders that guide the user about the expected format.
- Display clear and specific error messages when validation fails.
- Maintain consistent design with the rest of the interface.
- Provide immediate visual feedback about the field's state.

### Text inputs vs. Other controls
Use a **text input field** for free-form text data entry such as names, addresses, or comments. Use **Input Select** for predefined options, **Checkbox** for boolean selections, and **Radio Button** for mutually exclusive options. Use **Input Phone** component exclusively for phone numbers.

## Content guidelines

Text input fields should be clear and predictable. Users should be able to easily understand what information is required and how to provide it.

- Use concise but descriptive labels.
- Placeholders should be helpful examples, not complete instructions.
- Error messages should be specific and action-oriented.
- Use relevant icons to enhance understanding of the expected input type.
- Maintain consistent text styling throughout the interface.

## Related components

- **Phone input** — for entering phone numbers exclusively.
- **Input Select** — for selecting from predefined options.
- **Checkbox** — for boolean selections.
- **Radio Button** — for mutually exclusive options.
- **Error message** — for displaying validation messages.

## Accessibility

- This component is a **styling wrapper** — it does not create a `<label>` or any semantic structure. Always associate a visible label with the projected `<input>` using either a `<label for="inputId">` element, or `aria-label` / `aria-labelledby` directly on the `<input>`.
- Always project a native `<input type="text">`, `<input type="email">`, or `<input type="password">` element. Native inputs are keyboard accessible and correctly announced by screen readers without extra ARIA.
- The `isInvalid` input applies the invalid visual state. To communicate the invalid state to assistive technologies, also add `aria-invalid="true"` directly on the projected `<input>`, and connect the error message with `aria-describedby="[errorId]"` on the `<input>` pointing to the `id` of the projected `company-error-message` element.
- The disabled state is managed directly on the projected `<input disabled>` — there is no `isDisabled` input on this component.
- Decorative icons projected into the icon slot must have `aria-hidden="true"`. If a `corp-text-button` containing only an icon is projected, add an `aria-label` to the `<button>` element to provide an accessible name (e.g. `aria-label="Clear field"`). Without it, assistive technologies will announce an unlabelled button.
- Color contrast between text and background meets accessibility standards in all states (default, filled, invalid, disabled).
- Visual focus is handled by the browser's native focus ring on the projected `<input>`. Ensure custom stylesheets do not suppress `outline` on the input.

## Usage examples

### Default

```html
<corp-input-text>
	<input type="text" name="name" value="" placeholder="Your name" />
	<button corp-text-button>
		<i corp-icon icon="info-bold"></i>
	</button>
	<p company-error-message>This field is required</p>
</corp-input-text>
```

### Default With Icon

```html
<corp-input-text>
	<corp-icon icon="user-bold"></corp-icon>
	<input type="text" name="name" value="" placeholder="Your name" />
	<button corp-text-button>
		<i corp-icon icon="info-bold"></i>
	</button>
	<p company-error-message>This field is required</p>
</corp-input-text>
```

### Validation False

```html
<corp-input-text [isInvalid]="true">
	<corp-icon icon="user-bold"></corp-icon>
	<input type="text" name="name" value="" placeholder="Your name" />
	<button corp-text-button>
		<i corp-icon icon="info-bold"></i>
	</button>
	<p company-error-message>This field is required</p>
</corp-input-text>
```

### Validation True

```html
<corp-input-text [isFilled]="true">
	<corp-icon icon="user-bold"></corp-icon>
	<input type="text" name="name" value="" placeholder="Your name" />
	<button corp-text-button>
		<i corp-icon icon="info-bold"></i>
	</button>
	<p company-error-message>This field is required</p>
</corp-input-text>
```

### Disabled

```html
<corp-input-text>
	<corp-icon icon="user-bold"></corp-icon>
	<input type="text" name="name" value="Tom Cruise" placeholder="Your name" disabled />
	<button corp-text-button>
		<i corp-icon icon="info-bold"></i>
	</button>
</corp-input-text>
```

### Disabled Filled

```html
<corp-input-text [isFilled]="true">
	<corp-icon icon="user-bold"></corp-icon>
	<input type="text" name="name" value="Tom Cruise" placeholder="Your name" disabled />
</corp-input-text>
```

### Default With Custom Input

```html
<corp-input-text>
	<corp-icon icon="user-bold"></corp-icon>
	<input
		type="email"
		name="email"
		id="email"
		value=""
		placeholder="your@email.com"
	/>
	<button slot="button" size="responsive" corp-button>Apply</button>
	<p company-error-message>This field is required</p>
</corp-input-text>
```
