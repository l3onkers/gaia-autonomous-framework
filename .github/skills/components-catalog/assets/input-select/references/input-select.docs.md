# InputSelectComponent documentation

Select input fields are essential components for choosing from predefined options in forms. They allow users to select from a list of choices such as countries, categories, or any other predefined data. The `corp-input-select` component provides a consistent and accessible interface for dropdown selection with support for search functionality and grouping options.

## Best practices

Select input fields should:
- Have clear and descriptive labels that indicate what options are available.
- Include a meaningful placeholder that guides the user about the expected selection.
- Display clear and specific error messages when validation fails.
- Maintain consistent design with the rest of the interface.
- Provide immediate visual feedback about the field's state.
- Group related options logically using optgroups when appropriate.

### Select inputs vs. other controls
Use a **select input field** for choosing from predefined options such as countries, categories, or time slots. Use **Input Text** for free-form text data entry, **Checkbox** for boolean selections, and **Radio Button** for mutually exclusive options.

## Content guidelines

Select input fields should be clear and predictable. Users should be able to easily understand what options are available and how to make a selection.

- Use concise but descriptive labels for the field and options.
- Placeholders should be helpful examples, not complete instructions.
- Error messages should be specific and action-oriented.
- Use relevant icons to enhance understanding of the expected input type.
- Group related options logically using optgroups.
- Maintain consistent text styling throughout the interface.

## Related components

- **Input Text** — used for free-form text data entry.
- **Checkbox** — used for boolean selections.
- **Radio** — used for mutually exclusive options.
- **Error Message** — provides validation feedback for this field.

## Accessibility

This component renders a **custom dropdown UI** on top of a native `<select>` projected by the consumer. The native select is used as the data source but is not visually presented.

Key accessibility considerations:
- Always associate a visible label with the field using a `<label for="selectId">` element, or `aria-label` / `aria-labelledby` on the host, so assistive technologies can announce the field purpose.
- The `isInvalid` property applies the invalid visual state. To communicate the invalid state to assistive technologies, also add `aria-invalid="true"` directly to the projected `<select>` element.
- The disabled state is managed directly on the projected `<select disabled>` element.
- The mobile close button (back arrow) requires an accessible label since it contains only an icon. Always provide `closeButtonAriaLabel` in the language of the interface (e.g. `closeButtonAriaLabel="Back"`).
- The visible text input implements the ARIA combobox pattern: it has `role="combobox"`, `aria-haspopup="listbox"`, `aria-expanded` (reactive to open/close state), and `aria-controls` pointing to the dropdown list. The dropdown list has `role="listbox"` and each selectable option has `role="option"` with `aria-selected`.
- Decorative icons inside the component have `aria-hidden="true"` and do not contribute to the accessible name.
- Icons projected via `ng-content` are the consumer's responsibility — add `aria-hidden="true"` if decorative, or an accessible label if they convey meaning.
- The color contrast between text and background meets accessibility standards to ensure readability.
- Visual focus is maintained through browser default or custom styles, enabling keyboard navigation.

## Usage examples

### Default

```html
<corp-input-select [isReadonly]="false" title="Select option">
	<select name="options">
		<option value="">Select an option</option>
		<option value="ABC" selected>Option 1</option>
		<option value="2" disabled>Option 2</option>
		<option value="3">Option 3</option>
		<option value="4">Option 4</option>
		<option value="5">Option 5</option>
		<option value="6">Option 6</option>
	</select>
	<p company-error-message>This field is required</p>
</corp-input-select>
```

### CustomOptionTemplate

```html
<corp-input-select [isReadonly]="false" title="Select option">
	<select name="options">
		<option value="">Select an option</option>
		<option value="ABC" selected>Option 1</option>
		<option value="2" disabled>Option 2</option>
		<option value="3">Option 3</option>
		<option value="4">Option 4</option>
		<option value="5">Option 5</option>
		<option value="6">Option 6</option>
	</select>

	<p company-error-message>This field is required</p>

	<ng-template let-option>
		{{option.text}}
		<p company-iata-tag [label]="option.value" class="u-flex__right"></p>
	</ng-template>
</corp-input-select>
```

### WithGrouping

```html
<corp-input-select title="Select option">
	<select name="options">
		<option value="">Select and option</option>
		<optgroup label="Group 1">
			<option value="ABC">Option 1</option>
			<option value="2" disabled>Option 2</option>
		</optgroup>
		<optgroup label="Group 2">
			<option value="3">Option 3</option>
			<option value="4">Option 4</option>
		</optgroup>
		<option value="5">Option 5</option>
		<option value="6">Option 6</option>
	</select>
	<p company-error-message>This field is required</p>
</corp-input-select>
```

### DefaultWithIcon

```html
<corp-input-select title="Select option">
	<i corp-icon icon="search-bold"></i>
	<option value="">Select and option</option>
	<select name="options">
		<option value="">Select an option</option>
		<option value="ABC">Option 1</option>
		<option value="2" disabled>Option 2</option>
		<option value="3">Option 3</option>
		<option value="4">Option 4</option>
		<option value="5">Option 5</option>
		<option value="6">Option 6</option>
	</select>
	<p company-error-message>This field is required</p>
</corp-input-select>
```

### Disabled

```html
<corp-input-select title="Select option">
	<select name="options" disabled>
		<optgroup label="Group 1">
			<option value="1">Option 1</option>
			<option value="2" disabled>Option 2</option>
		</optgroup>
		<optgroup label="Group 2">
			<option value="3">Option 3</option>
			<option value="4">Option 4</option>
		</optgroup>
		<option value="5">Option 5</option>
		<option value="6">Option 6</option>
	</select>
	<p company-error-message>This field is required</p>
</corp-input-select>
```

### DisabledWithIcon

```html
<corp-input-select title="Select option">
	<i corp-icon icon="search-bold"></i>
	<select name="options" disabled>
		<optgroup label="Group 1">
			<option value="1">Option 1</option>
			<option value="2" disabled>Option 2</option>
		</optgroup>
		<optgroup label="Group 2">
			<option value="3">Option 3</option>
			<option value="4">Option 4</option>
		</optgroup>
		<option value="5">Option 5</option>
		<option value="6">Option 6</option>
	</select>
	<p company-error-message>This field is required</p>
</corp-input-select>
```

### Inline

```html
<corp-input-select title="Select option" variant="inline">
	<select name="time">
		<option value="07:00">07:000000000</option>
		<option value="08:00">08:00</option>
		<option value="09:00">09:00</option>
		<option value="10:00">10:00</option>
		<option value="11:00">11:00</option>
		<option value="12:00">12:00</option>
		<option value="13:00">13:00</option>
		<option value="14:00">14:00</option>
		<option value="15:00">15:00</option>
		<option value="16:00">16:00</option>
		<option value="17:00">17:00</option>
		<option value="18:00">18:00</option>
		<option value="19:00">19:00</option>
		<option value="20:00">20:00</option>
		<option value="21:00">21:00</option>
	</select>
</corp-input-select>
```
