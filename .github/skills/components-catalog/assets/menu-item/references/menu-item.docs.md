# MenuItemComponent documentation

`MenuItemComponent` is an attribute-based navigation item that renders a label, an optional icon, an optional legend, and an optional dropdown trigger. It is designed to be used as a direct child of `corp-menu`, `corp-menu-tab`, or `corp-menu-segment`, inheriting context-specific styling from its parent container.

## Best practices

- Always use `MenuItemComponent` as a child of a navigation container (`corp-menu`, `corp-menu-tab`, or `corp-menu-segment`). Using it in isolation breaks the ARIA ownership requirement of `role="menuitem"`.
- Apply the selector as an attribute on a native `<button>` element (`<button corp-menu-item>`) so the host element carries correct keyboard interaction and focus behaviour natively.
- Use `isSelected` to reflect the externally controlled selection state — do not use it to manage selection logic inside the component. Pair it with `aria-current="page"` on the host when the item represents the active page.
- Use `isDisabled` to visually suppress an item. Because the component only adds a CSS class, also add `aria-disabled="true"` to the host element so assistive technologies can read the state.
- When projecting an icon alongside a label, always include a visible text label. Icons alone are not sufficient for accessibility.
- Set `iconPosition="right"` only when the icon's position communicates a specific meaning (e.g. an external-link indicator placed after the text).
- Use `legend` for a short secondary descriptor that appears below the main label — for example a route code or a short subtitle. Keep it to one line; it does not wrap gracefully at narrow widths.
- When using `isDropdown`, project the panel content via `[slot=dropdown]` and manage the open/close toggle state yourself. Wire `aria-expanded` on the dropdown button and `aria-controls` pointing to the panel until the component exposes these bindings natively.

### Menu item vs. other controls

Use `MenuItemComponent` for navigation and menu actions that live within a navigation container. For standalone call-to-action buttons use `ButtonComponent`. For icon-only round actions use `RoundedButtonComponent`. For inline text-level actions use `TextButtonComponent`.

## Content guidelines

Menu item labels should be concise, self-explanatory, and consistent in style across a navigation group.

- Use short nouns or noun phrases ("Flights", "Your booking", "Discover") — avoid gerunds or verb phrases ("Go to flights", "Checking in").
- Keep all labels at a comparable length within the same navigation container to maintain visual balance.
- Legend text should complement the label without repeating it — use it for route codes, subtitles, or short descriptors that add relevant context.
- Translate any string projected as an icon `aria-label` (see Accessibility section). Never leave hardcoded English strings in multilingual applications.
- Avoid punctuation at the end of labels; navigation items are not sentences.

## Related components

- **corp-menu** — horizontal navigation container that gives `MenuItemComponent` its default horizontal bar styling.
- **corp-menu-tab** — tab-style navigation container; projects `MenuItemComponent` styled as tabs.
- **corp-menu-segment** — segment control container that groups `MenuItemComponent` instances as segments.
- **corp-icon** — projected into the default icon slot to display an icon alongside the label.

## Accessibility

The component sets `role="menuitem"` on the host. This role is only valid when the host is an owned child of an element with `role="menu"` or `role="menubar"`. Verify that the parent container (`corp-menu`, `corp-menu-tab`, `corp-menu-segment`) exposes the required parent role before using this component.

`isDisabled` applies CSS only (`pointer-events: none; opacity: 0.5`). Until the component binds `aria-disabled` automatically, add `aria-disabled="true"` to the host element when the item is disabled so screen readers can announce the state.

`isSelected` applies the `is-active` CSS class but does not set any ARIA attribute. For navigation contexts, add `aria-current="page"` to the host when the item represents the currently active page. For selection contexts (e.g. a segment control), add `aria-selected` as appropriate.

The dropdown toggle button (`isDropdown="true"`) has no `aria-expanded` or `aria-controls`. Until these bindings are added to the component, manage them on the host: set `aria-expanded` on the host element and add an `id` to the projected dropdown panel, referencing it with `aria-controls` on the trigger.

The dropdown toggle button has a hardcoded English `aria-label` ("Open/close menu"). Until this is exposed as an input, override it from the consumer side when deploying in a non-English context.

Decorative icons projected via `ng-content` that duplicate the adjacent text label should carry `aria-hidden="true"` to avoid redundant announcements by screen readers.

When a group of `MenuItemComponent` instances forms a set of options (as in a segment control), add `aria-label` or `aria-labelledby` to the parent container to give the group an accessible name.

## Usage examples

### Menu

```html
<nav corp-menu>
	<button corp-menu-item>
		<i corp-icon icon="seat"></i>
		Vuelos
	</button>
</nav>
```

### MenuTab

```html
<nav corp-menu-tab>
	<button corp-menu-item>
		<i corp-icon icon="seat"></i>
		Vuelos
	</button>
</nav>
```

### MenuTabLight

```html
<nav corp-menu-tab variant="light">
	<button corp-menu-item>
		<i corp-icon icon="seat"></i>
		Vuelos
	</button>
</nav>
```
