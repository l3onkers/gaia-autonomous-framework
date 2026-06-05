# Popin documentation

The Popin is a full-screen overlay modal used to display contextual content or multi-step flows on top of the current page. It supports both the native `<dialog>` element and a `<div>`/`<article>` host, a sticky header, a back-button slot, and scroll event forwarding.

## Best practices

- Use the popin for flows that require the user's full attention and that are too complex for a tooltip or a bottom sheet.
- Prefer using a native `<dialog>` element as the host (`<dialog corp-popin>`). It handles `showModal()` / `close()`, `Escape` key dismissal, and focus trapping natively without extra JavaScript.
- When using a non-`<dialog>` host, implement focus trapping manually and listen for `Escape` to call `close()`.
- Control visibility exclusively through the `isVisible` input — do not toggle CSS classes directly on the host.
- Use the `isSticky` input when the popin contains a secondary navigation bar or filter bar that must remain visible during scroll.
- Use the `popinBackButton` slot only on mobile. The component automatically hides it on medium breakpoints and above.
- Avoid opening multiple popins at the same time. If a nested flow is needed, consider replacing the popin content instead of stacking overlays.

### Popin vs. other overlays

Use the **Popin** when the content requires full-screen real estate or multi-step user interaction. Use a **tooltip** or **popover** for brief contextual information that does not require user action. Use a **bottom sheet** for lightweight action lists on mobile.

## Content guidelines

Popin content should be focused and purposeful — the overlay interrupts the user's flow, so every element inside it must earn its place.

- Use the `popinTitle` slot to provide a concise, descriptive title that tells the user what the popin is about.
- Keep body copy short. If a large amount of information is needed, break it into steps rather than scrolling a wall of text.
- The close button is provided automatically. Do not add a second close mechanism unless there is a clear UX reason (e.g. a "Cancel" action button with distinct consequences).
- Use the `popinBackButton` slot only when the popin represents a sub-step reachable from a parent popin or screen. The button is hidden on desktop automatically.
- Label all action buttons with clear verbs that describe what will happen (e.g. "Confirm", "Save changes", not "OK" or "Yes").

## Related components

- **Text Button** — used in the `popinBackButton` slot for mobile back navigation and rendered internally as the desktop close button.
- **Rounded Button** — rendered internally as the mobile close button.
- **Logo** — projected into the header via `ng-content` using `select="corp-logo, [corp-logo]"`.

## Accessibility

This component has known accessibility problems. See the **Accessibility Issues** page in the Storybook sidebar before using in production.

- Add `aria-labelledby` on the host element pointing to the `id` of the projected title element. The component sets `role="dialog"` internally but does not associate a label. Every dialog must have an accessible name for screen readers to announce it correctly (WCAG 4.1.2).
- When using the non-`<dialog>` host pattern, add `aria-modal="true"` manually on the host. The native `<dialog showModal()>` sets this implicitly; the div/article host does not.
- When using the non-`<dialog>` host pattern, implement focus management yourself: move focus to the first focusable element inside the popin when it opens, and return focus to the trigger element when it closes.
- When using the non-`<dialog>` host pattern, listen for `Escape` keydown and call `close()`. The native `<dialog>` handles this automatically; the non-`<dialog>` path does not.
- The `isVisible = false` state on the non-`<dialog>` host uses `opacity: 0` and `left: -200vw` to visually hide the popin, but the element remains in the DOM and in the accessibility tree. Keyboard focus and screen reader browsing can still reach hidden content. Pair this state with the `inert` attribute on the host to fully suppress interaction when the popin is not visible.
- The internal close buttons (desktop text-button and mobile rounded-button) have no accessible label. Until the component exposes a `closeButtonAriaLabel` input, both buttons are announced by screen readers without a meaningful name. Track this in the Accessibility Issues page.

## Usage examples

### Default

```html
<article corp-popin [isVisible]="isVisible" aria-labelledby="popin-title">
	<h2 corp-title slot="popinTitle" id="popin-title">Popin Title</h2>
</article>
```

### With Logo

```html
<article corp-popin [isVisible]="isVisible">
	<corp-logo>
		<p app-subtitle>
			YOUR AWESOME TAGLINE HERE
		</p>
	</corp-logo>
	<h2 corp-title slot="popinTitle">Popin Title</h2>
</article>
```

### With Back Button

```html
<article corp-popin [isVisible]="isVisible" aria-labelledby="popin-title">
	<button slot="popinBackButton" corp-text-button size="lg">
		<i corp-icon icon="arrow-left-bold"></i>
	</button>
	<h2 corp-title slot="popinTitle" id="popin-title">Popin Title</h2>
</article>
```
