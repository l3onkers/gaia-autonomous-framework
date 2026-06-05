# Tooltip documentation

`TooltipComponent` displays a small overlay of contextual information when the user hovers over or focuses on a trigger element. It is paired with `TooltipWrapperDirective` to manage show/hide behavior automatically.

## Best practices

- Always place `corp-tooltip` as a direct child of an element that carries the `companyTooltipWrapper` directive so that hover management works correctly.
- Use tooltips for supplementary information only — never for content the user must read to complete a task.
- Keep tooltip text short. A tooltip is not a replacement for inline help text or an error message.
- Use `position` to prevent the tooltip from overflowing the viewport. The default (top-center) works for most cases; use `bottom`, `bottom-left`, or `bottom-right` when the trigger is near the top of the screen.
- Use `size` (`xs`, `sm`, `lg`, `xl`) to match the content length. Avoid very wide tooltips on narrow viewports.
- Use the `dark` variant when displaying the tooltip over a light-colored surface that would make the default border invisible.
- Set `delay` above 499 ms only when the tooltip carries non-essential information and a small latency improves perceived performance (e.g. icon-only buttons in dense toolbars).
- When `htmlContent` is used, pass only non-interactive markup (`<strong>`, `<em>`, plain text). Do not embed links or buttons inside a tooltip.

### Tooltip vs. other feedback components

Use `TooltipComponent` when the information is directly tied to a single element and is optional context. Use `FeedbackBarComponent` or `FeedbackBoxComponent` for page-level or form-level messages that must always be visible and cannot be dismissed by moving the pointer.

## Content guidelines

Tooltip text should be concise and read as a short phrase or sentence that adds value beyond what the label already communicates.

- Write in sentence case without a trailing period for short phrases. Use a period only for full sentences.
- Do not repeat the label of the trigger element verbatim — add new information.
- Avoid starting with "This" or "Click to" — be direct.
- Do not include step-by-step instructions; use a popover or inline help text for those.
- When using `htmlContent`, use markup only to emphasize a key term. Do not create lists or multi-paragraph content inside a tooltip.

## Related components

- **Icon** — commonly used as the trigger element wrapped with `companyTooltipWrapper`, as shown in the default story.

## Accessibility

> ⚠️ **Pending accessibility issues.** This component has known accessibility problems. See the **Accessibility Issues** page in the Storybook sidebar before using in production.

- The component sets `role="tooltip"` on its host. For assistive technologies to announce the tooltip when it becomes visible, the trigger element **must** have `aria-describedby` pointing to the tooltip's `id`. Set a unique `id` attribute directly on `corp-tooltip` and add the matching `aria-describedby` on the trigger: `<corp-tooltip id="tip-1">...</corp-tooltip>` and `<button aria-describedby="tip-1">`.
- `TooltipWrapperDirective` only handles `mouseenter` and `mouseleave`. Keyboard users cannot trigger the tooltip in its current state. Until fixed, avoid placing critical information exclusively in a tooltip for keyboard-dependent users. See the Accessibility Issues page for details.
- When `htmlContent` contains markup, ensure it does not include focusable or interactive elements. `role="tooltip"` is intended for plain descriptive text only.
- When the tooltip becomes visible it transitions out of `display: none`, which re-adds it to the accessibility tree. The `aria-describedby` link on the trigger is what causes screen readers to read the content at that point — without it the re-entry is silent.
- Icons projected as decorative triggers (e.g. an info icon with a visible text label nearby) should carry `aria-hidden="true"` so they are not announced redundantly.

## Usage examples

### Default

```html
<div class="container">
	<div class="row">
		<div class="col-xs-12" style="height: 50vh; display: flex; align-items: center; justify-content: center">
			<p class="t-body-text t-body-text--sm" style="display: flex; align-items: center;">
				Lorem ipsum dolor et.
				<corp-icon icon="info-bold" size="sm" class="u-ml-8 u-color-brand-secondary" companyTooltipWrapper>
					<corp-tooltip [isVisible]="true" textAlignment="left">
						Lorem ipsum dolor et.
					</corp-tooltip>
				</corp-icon>
			</p>
		</div>
	</div>
</div>
```

### With HTML content

```html
<button companyTooltipWrapper>
	<corp-tooltip [htmlContent]="'<strong>Bold text</strong> with emphasis'">
	</corp-tooltip>
	Hover me
</button>
```

### Bottom position with delay

```html
<div companyTooltipWrapper>
	<corp-tooltip position="bottom" [delay]="1000">
		Delayed tooltip below the trigger
	</corp-tooltip>
	Trigger
</div>
```

### Dark variant

```html
<span companyTooltipWrapper>
	<corp-tooltip variant="dark" textAlignment="left">
		Dark themed tooltip
	</corp-tooltip>
	Info
</span>
```
