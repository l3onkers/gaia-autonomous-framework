# Popup documentation

The Popup component is a full-screen modal overlay that displays contextual content above the current page. It supports both a native `<dialog>` host (recommended) and any HTML element, and exposes slots for a header, scrollable content area, and a sticky footer.

## Best practices

- Always use a native `<dialog>` element as the host (`<dialog corp-popup>`). The `<dialog>` path provides built-in focus trapping, `showModal()` / `close()` semantics, and a native `::backdrop`, which removes the need for workarounds. The non-`<dialog>` path carries known accessibility limitations (see the Accessibility Issues page).
- Use `[(isVisible)]` for two-way binding when the parent component needs to react to close events. Use the `popupClosed` output when you only need to run a side effect (reset state, reload data) without holding a reference to visibility.
- Place long-running actions (form submissions, loading states) inside `corp-popup-content` rather than in the footer. The footer is sticky and should contain only the primary action buttons.
- If the popup content can exceed the viewport height, leave `disableScroll` at its default (`false`) so the inner panel scrolls independently. Set `disableScroll` to `true` only when the parent explicitly needs to control scrolling (e.g. a custom virtual scroll container).
- Use `size="sm"` for confirmation dialogs, session warnings, and single-form popups. The default (full) width is appropriate for multi-step flows or content-heavy panels.
- Avoid nesting interactive overlays. Do not open a second popup on top of an already-open one.
- Use template references marked with `#popupClose` on any custom close trigger inside the popup. The component wires click handlers to all such elements automatically.

### Popup vs. other overlay patterns

Use a **popup** when the content interrupts the user flow and requires acknowledgment or explicit dismissal (e.g. session expiry, account sign-in, product detail). Use a **tooltip** for non-blocking contextual hints that do not require interaction. Use a **bottom bar** or an inline panel for persistent supplementary content that does not block the page.

## Content guidelines

- The heading projected into `corp-popup-header` should name the task or context, not echo the triggering action. Prefer "Reset your password" over "Password reset form".
- Keep descriptive text in the header brief — one or two sentences. Move detailed explanations and instructions into `corp-popup-content`.
- Primary action labels in the footer should be verbs that describe the outcome: "Confirm booking", "Create account", "Extend session". Avoid generic labels like "OK" or "Submit".
- Secondary actions (cancel, go back) should use a lower-emphasis button variant and be placed after the primary action.
- Do not use the popup solely to display read-only information that could live on a regular page. Reserve it for flows that require focused user attention.

## Related components

- **Feedback Bar** — can be projected into the top slot of the popup (before `c-popup__inner`) to display contextual alerts.
- **Icon** — projected into `corp-popup-header` as a decorative illustration above the heading.

## Accessibility

> ⚠️ **Pending accessibility issues.** This component has known accessibility problems. See the **Accessibility Issues** page before using in production.

- Always use a native `<dialog>` element as the host. The `<dialog>` element with `showModal()` provides built-in focus trapping, correct `aria-modal` semantics, and automatic focus management — none of which are implemented by the component for non-`<dialog>` hosts.
- When using a non-`<dialog>` host, add `role="dialog"` and `aria-modal="true"` manually on the host element. Without these, screen readers do not announce the overlay as a modal.
- Add `aria-labelledby` to the host element pointing to the `id` of the heading inside `corp-popup-header`. This gives the dialog an accessible name that screen readers announce on focus. Example: `<dialog corp-popup aria-labelledby="popup-title">` with `<h2 id="popup-title" corp-title>…</h2>` inside the header.
- The built-in close button currently has no accessible label (see Accessibility Issues, Issue 5). Until resolved, add `aria-label="Close"` directly on the host or wrap the close icon in a visually hidden text node. Translate the label to match the application language.
- When the popup content is hidden on the non-`<dialog>` path, it remains accessible to screen readers (see Accessibility Issues, Issue 6). Until resolved, consider toggling `aria-hidden` on the host when `isVisible` is `false`.
- Icons projected into `corp-popup-header` for decorative purposes should carry `aria-hidden="true"` so screen readers skip them.

## Usage examples

### Default

```html
<article corp-popup [(isVisible)]="isVisible">
	<header corp-popup-header>
		<corp-icon icon="combo-plus" size="xl"></corp-icon>
		<h1 corp-title>
			COMBO PLUS
		</h1>
		<p corp-body-text size="sm">
			Lorem ipsum dolor sit amet consectetur adipisicing elit.
		</p>
	</header>

	<section corp-popup-content>
		<p corp-body-text size="sm">
			Lorem ipsum dolor sit amet consectetur adipisicing elit.
		</p>
	</section>
</article>
```

### Dialog

```html
<dialog corp-popup [(isVisible)]="isVisible">
	<header corp-popup-header>
		<corp-icon icon="combo-plus" size="xl"></corp-icon>
		<h1 corp-title>
			COMBO PLUS
		</h1>
	</header>

	<section corp-popup-content>
		<p corp-body-text size="sm">
			Lorem ipsum dolor sit amet consectetur adipisicing elit.
		</p>
	</section>
</dialog>
```
