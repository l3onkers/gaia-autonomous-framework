# Loader Layer documentation

A full-screen overlay that blocks all page interaction while a loading operation is in progress. It uses a fixed backdrop with a translucent background and centres any projected content — typically a spinner, a heading, and a short message.

## Best practices

- Use the loader layer only for operations that prevent meaningful page interaction, such as a full page navigation or a critical data fetch. For inline or partial loading states, prefer a spinner or skeleton.
- Toggle `isVisible` reactively from your smart component or service. Do not leave the layer mounted and visible indefinitely — dismiss it as soon as the operation completes or fails.
- Always project a visible loading indicator (e.g. `corp-spinner`) so sighted users understand what is happening.
- Project a short, descriptive message alongside the spinner so screen reader users receive meaningful content when the alert fires.
- Use the `light` variant when the loader is placed over a light-coloured section instead of the default dark background.
- Avoid nesting multiple loader layers — only one should be active at a time per viewport.

### Loader layer vs. spinner

`company-loader-layer` takes over the full viewport and blocks interaction. Use `corp-spinner` alone when the loading state is scoped to a single section, button, or card and page interaction outside that area should remain available.

## Content guidelines

Projected content should communicate what is happening and set expectations for how long the wait will last.

- Keep headings short and action-oriented: "Loading your flights…" rather than "Please wait while the system retrieves your search results."
- Complement the heading with a one-line supporting message that reassures the user: "This will only take a moment."
- Avoid technical language or error codes inside the loader — surface those in a feedback bar or error message after the loader is dismissed.
- Translate all projected text to match the application's language; the component does not provide localised default content.

## Related components

- **Spinner** — the animated loading indicator typically projected inside this overlay.

## Usage examples

### Default

```html
<article company-loader-layer [isVisible]="true">
	<h2 corp-subtitle variant="light" size="lg">
		Hang tight! We're loading your data
	</h2>

	<corp-spinner slot="spinner" [variant]="'is-waiting'"></corp-spinner>

	<p corp-body-text size="sm" class="u-color-secondary-40">
		We will be finished In just a moment.
	</p>
</article>
```
