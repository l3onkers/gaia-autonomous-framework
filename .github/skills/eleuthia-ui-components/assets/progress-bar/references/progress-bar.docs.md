# Progress Bar documentation

The Progress Bar communicates the status of an ongoing operation to the user. It supports animated loading states, timed linear progressions, and static percentage-based fill, making it suitable for both indeterminate and determinate feedback scenarios.

## Best practices

- Use the progress bar when an operation takes enough time to warrant feedback (typically more than one second).
- Choose the variant that matches the nature of the operation: use `is-waiting` for indeterminate background tasks, `is-loading` or `is-loading-with-steps` for multi-step flows, and a timed variant (`is-2_5s`, `is-5s`, etc.) when the duration is predictable.
- Use `isOnTop` only for page-level loading (e.g. route transitions) — avoid it inside modals or drawers where the fixed positioning would overlap other elements.
- Always toggle `isVisible` to `true` when loading starts and back to `false` once complete, rather than removing the component from the DOM; this preserves the animation state and avoids layout shifts.
- Do not use multiple progress bars simultaneously on the same view — use a single indicator to avoid confusing users.

### Progress Bar vs. Spinner

Use a **progress bar** when loading is tied to a page or section and a visual baseline across the full width is appropriate. Use a **spinner** when loading is scoped to a smaller element (e.g. a button or a card) where horizontal fill would feel out of place.

## Content guidelines

The progress bar does not render visible text, so content guidelines apply to its accessible label.

- Always supply a translated `aria-label` on the host element describing what is loading (e.g. `aria-label="Loading search results"`).
- Keep the label concise and action-oriented — describe the operation, not the component (prefer "Loading flights" over "Progress bar").
- Update the label if the operation changes mid-flow (e.g. from "Searching" to "Confirming booking").

## Related components

No related components.

## Usage examples

### Default

```html
<corp-progress-bar [isVisible]="true"></corp-progress-bar>
```
