# Input Radio documentation

Radio buttons are used when users must select **only one option** from a group. They are commonly used in forms where only a single choice is valid at a time.

## Best practices

Radio buttons should:

- Be used when the user must choose **only one option** from two or more.
- Always be presented in a **group**, using `company-radiobutton-group` or a native `<fieldset>` with `<legend>` for semantic grouping.
- Be accompanied by clear, concise **labels**, placed next to the radio circle.
- Be ordered in a logical and predictable way (typically vertical for readability).
- Never be used to trigger actions — only to make a selection.

### Radiobuttons vs. Checkboxes
Use a **radiobutton** when only one option can be selected. Use a **checkbox** when multiple selections are allowed.

## Content guidelines

Radio button labels should clearly describe the available options. Labels must be **short and scannable**, with no ambiguity about what each option represents.

- Use sentence case (capitalize only the first word).
- Avoid punctuation.
- Keep labels concise, preferably 1-3 words.
- Don't repeat or restate the question in the label.
- Avoid unnecessary words like "option" or "select."

## Related components

Explore related components:

- **Input checkbox** — use when multiple selections are allowed.

## Accessibility

- Always group radio buttons using `company-radiobutton-group` (which sets `role="radiogroup"` on the host). When using the group component, add `aria-label` or `aria-labelledby` directly to the host element to provide an accessible name for the group (e.g. `<company-radiobutton-group aria-label="Title">`). Alternatively, use a native `<fieldset>` with `<legend>` for the same purpose.
- Each radio option must include a native `<input type="radio">` projected into the component. The component automatically associates the visible label with the input via the `for`/`id` relationship — ensure every projected input has a unique `id`.
- Navigation between options within a group is handled natively by the browser using arrow keys. Tab moves focus to the group, not between individual options.
- The `isInvalid` property applies the invalid visual state. To communicate the invalid state to assistive technologies, also add `aria-invalid="true"` directly to the projected `<input>` element.
- The decorative icon inside the component has `aria-hidden="true"` and does not contribute to the accessible name.
- Avoid disabling all options in a group without a clear explanation or fallback.

## Usage examples

### Default

```html
<company-radiobutton-group>
	<company-input-radio>
		<input type="radio" name="base" id="src" />
		<span>Sr.</span>
	</company-input-radio>

	<company-input-radio>
		<input type="radio" name="base" id="sra" />
		<span>Sra.</span>
	</company-input-radio>
</company-radiobutton-group>
```

### Invalid

```html
<company-radiobutton-group>
	<company-input-radio [isInvalid]="true">
		<input type="radio" name="base" id="src" aria-invalid="true" />
		<span>Sr.</span>
	</company-input-radio>

	<company-input-radio [isInvalid]="true">
		<input type="radio" name="base" id="sra" aria-invalid="true" />
		<span>Sra.</span>
	</company-input-radio>
</company-radiobutton-group>
```

### Small

```html
<company-radiobutton-group>
	<company-input-radio size="sm">
		<input type="radio" name="base" id="src" />
		<span>Sr.</span>
	</company-input-radio>

	<company-input-radio size="sm">
		<input type="radio" name="base" id="sra" />
		<span>Sra.</span>
	</company-input-radio>
</company-radiobutton-group>
```

### Keypad

```html
<company-radiobutton-group>
	<company-input-radio variant="keypad">
		<input type="radio" name="base" id="src" />
		<span>Sr.</span>
	</company-input-radio>

	<company-input-radio variant="keypad">
		<input type="radio" name="base" id="sra" />
		<span>Sra.</span>
	</company-input-radio>
</company-radiobutton-group>
```

### Disabled

```html
<company-radiobutton-group>
	<company-input-radio>
		<input disabled type="radio" name="base" id="src" />
		<p>Sr.</p>
	</company-input-radio>

	<company-input-radio>
		<input disabled type="radio" name="base" id="sra" />
		<p>Sra.</p>
	</company-input-radio>
</company-radiobutton-group>
```

### Disabled and Checked

```html
<company-input-radio>
	<input disabled checked type="radio" name="base" id="src" />
	<span>Sr.</span>
	<span company-error-message>This field is required</span>
</company-input-radio>
```
