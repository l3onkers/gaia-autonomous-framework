# Spinner documentation

The spinner is a circular progress indicator that communicates a loading or processing state to the user. It supports indeterminate spinning, timed countdowns, and static percentage fills, and can optionally display a centered icon or text.

## Best practices

- Use the spinner to represent a background operation whose duration is unknown (`is-waiting`) or known (`is-15s`, `is-30s`, or a custom `duration`).
- Use percentage variants (`is-0-percent` through `is-100-percent`) when the progress value is known and needs to be reflected visually.
- Use the `sm` size when the spinner appears inline or inside compact UI regions such as buttons or cards.
- Avoid displaying multiple spinners on the same screen simultaneously — prefer a single loading indicator for the entire region.
- When the loading operation completes, transition to `is-loaded` before removing the spinner, so users perceive a clean end state.
- Do not use the spinner as a decorative element. It always implies a process is ongoing.

### Spinner vs. progress bar

Use the **spinner** for circular, self-contained loading states that occupy a small area of the layout (e.g. inside a card or a modal). Use a **progress bar** for linear, horizontal feedback that spans a content area and makes the remaining progress immediately clear to the user.

## Content guidelines

The spinner can project optional content — an icon or text — to provide additional context about the operation in progress.

- Keep projected text short: a value (number) and a unit (label) are the only recommended text slots.
- Use the `slot="value"` slot for numeric values and `slot="unit"` for the unit label (e.g. "seconds", "%").
- Icons projected into the center should be simple, recognisable glyphs that reinforce the nature of the operation (e.g. a credit card icon during payment processing).
- Do not project explanatory sentences or multi-line text — the spinner is not a message container.

## Related components

- **Icon** — projected into the spinner center via `ng-content` to add visual context.
- **Body Text** — projected via `slot="value"` and `slot="unit"` to display a numeric value and its unit label inside the spinner.

## Accessibility

The host element carries `role="status"` automatically. This creates an ARIA live region: screen readers will announce its text content when the spinner appears in the DOM or its content changes. No extra attribute is needed from the consumer for this role.

The inner `role="progressbar"` element currently lacks an accessible name and the required `aria-valuenow` / `aria-valuemin` / `aria-valuemax` attributes. Until this is resolved, consumers must be aware that screen readers may announce the progressbar without enough context.

Icons projected via `ng-content` are decorative in most spinner use cases. Add `aria-hidden="true"` to every projected icon so screen readers skip it and focus on the status text instead.

When the spinner appears dynamically (e.g. toggled with `@if`), the `role="status"` live region fires automatically as the element enters the DOM. Ensure the projected text content is present at render time so screen readers pick it up correctly.
