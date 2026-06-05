# Input Checkbox Documentation

Checkboxes are used to allow users to select one or more options from a list. They are typically used in forms to collect user preferences or settings.

## Best practices

- Use a checkbox when users can select **one or more options** from a list.
- Always accompany a checkbox with a clear, concise label placed next to it.
- Group related checkboxes using spacing or visual hierarchy. When grouping is semantically significant, wrap them in a `<fieldset>` with a `<legend>`.
- Reflect the true state of the control visually and programmatically at all times.
- Avoid using checkboxes to trigger immediate actions — use a button or a toggle switch instead.
- Use the `switch` variant for binary on/off settings (such as enabling a feature or notification). Do not use it for multi-select scenarios.

### Checkbox vs. radiobutton

Use a **checkbox** when the user can select multiple options independently. Use a **radiobutton** when only one option from a group can be selected at a time.

## Content guidelines

Checkbox labels should be clear, concise, and reflect the setting or option being toggled. Users should immediately understand what is being selected or deselected.

- Use sentence case (capitalize only the first word).
- Keep labels short — usually 1–3 words when possible.
- Describe what the checkbox controls, not the action performed.
- Avoid verbs that suggest an immediate action ("Enable notifications" is preferred over "Turn on notifications now").
- Never end a label with punctuation.

## Related components

- **Radiobutton** — for single-select scenarios within a group of mutually exclusive options.

## Accessibility

> **Pending accessibility issues.** This component has known accessibility problems. See the **Accessibility Issues** documentation before using in production.

- Always project a native `<input type="checkbox">` into the component. The component wraps it inside a `<label>`, providing an accessible association between the control and its visible label text without requiring an explicit `for`/`id` pair.
- When `isInvalid` is `true`, also add `aria-invalid="true"` directly to the projected `<input>` so assistive technologies announce the invalid state.
- When using the `switch` variant, add `role="switch"` to the projected `<input>`. Without it, screen readers announce the control as "checkbox" instead of "switch", misrepresenting the semantic intent.
- When grouping multiple related checkboxes, wrap them in a `<fieldset>` with a `<legend>` so assistive technologies announce the group context for each individual control.
- To disable a checkbox, add the native `disabled` attribute directly to the projected `<input>`. The component detects `input:disabled` via CSS `:has()` to apply the disabled visual state, but it does not manage the disabled attribute itself.

## Usage examples

### Default

```html
<corp-input-checkbox>
	<input type="checkbox" name="base" id="base" />
	<span>Accept terms and conditions</span>
	<span company-error-message>This field is required</span>
</corp-input-checkbox>
```

### Disabled

```html
<corp-input-checkbox>
	<input disabled type="checkbox" name="base" id="base" />
	<span>Accept terms and conditions</span>
	<span company-error-message>This field is required</span>
</corp-input-checkbox>
```

### DisabledChecked

```html
<corp-input-checkbox>
	<input disabled checked type="checkbox" name="base" id="base" />
	<span>Accept terms and conditions</span>
	<span company-error-message>This field is required</span>
</corp-input-checkbox>
```

### Invalid

```html
<corp-input-checkbox [isInvalid]="true">
	<input type="checkbox" name="base" id="base" />
	<span>Accept terms and conditions</span>
	<span company-error-message>This field is required</span>
</corp-input-checkbox>
```

### AlignedRight

```html
<corp-input-checkbox [alignment]="'right'">
	<input type="checkbox" name="base" id="base" />
	<span>Accept terms and conditions</span>
	<span company-error-message>This field is required</span>
</corp-input-checkbox>
```

### VariantSwitch

```html
<corp-input-checkbox [variant]="'switch'">
	<input type="checkbox" name="base" id="base" />
	<span>Accept terms and conditions</span>
	<span company-error-message>This field is required</span>
</corp-input-checkbox>
```
