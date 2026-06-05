# Menu documentation

The Menu component is a navigation container that groups one or more `MenuItemComponent` elements into a cohesive navigation bar or list. It supports horizontal, vertical, and contextual (floating panel) layouts and emits a `clicked` event whenever any projected item is activated.

## Best practices

- Always wrap the `corp-menu` host element in a semantic `<nav>` element, or use `<nav corp-menu>`, so the navigation landmark is properly exposed to assistive technologies.
- Provide an accessible name for the menu via `aria-label` or `aria-labelledby` on the host element. `role="menu"` requires an accessible name to distinguish it from other navigation regions on the page.
- Use the `vertical` variant for stacked navigation lists such as side menus or mobile drawers. Use the `contextual` variant for floating dropdown panels that appear near a trigger button.
- Use `isFullwidth` when the menu must span the full width of its container and items should share the space equally, for example in tab-style navigation bars.
- Limit the number of items to what can be comfortably read and activated. Avoid overloading the menu with more than seven items.
- Do not nest `corp-menu` components directly inside each other. For hierarchical navigation, use a `[slot=dropdown]` projected inside a `MenuItemComponent` with `isDropdown="true"`.

### Menu vs. other navigation controls

Use `corp-menu` when you need a group of navigation or action items that share a visual container and an event bus. For standalone action buttons that do not belong to a navigation group, prefer `corp-button` or `corp-text-button`.

## Content guidelines

Labels projected into each `corp-menu-item` should be short and scannable. Keep the following rules in mind:

- Use concise nouns or short verb phrases (for example, "Flights", "My Booking", "Discover").
- Avoid full sentences or punctuation in labels.
- When using the `legend` input, keep the legend text to a single short sentence of supplementary context — not a repetition of the label.
- Icon-only menus must still project a text label for screen readers; do not rely solely on an icon to communicate an item's purpose.
- All visible text content must be translated to match the application's active language. The component does not perform any translation internally.

## Related components

- **MenuItemComponent** — the direct child item component projected into the menu slot.

## Accessibility

> **Pending accessibility issues.** This component has known accessibility problems. See the **Accessibility Issues** page in the Storybook sidebar before using in production.

- The host element receives `role="menu"` automatically. Add `aria-label` or `aria-labelledby` on the host to provide an accessible name that distinguishes this region from others on the page.
- When using `<nav corp-menu>`, the `<nav>` landmark already provides a region name if `aria-label` is present on the `<nav>` element.
- All direct children must have `role="menuitem"` (set automatically by `MenuItemComponent`). Do not project arbitrary block elements as direct children of the menu.
- `MenuItemComponent` adds an `is-disabled` CSS class when `isDisabled` is `true`, but does not set `aria-disabled` or the native `disabled` attribute. When a `<button corp-menu-item>` is visually disabled, add `aria-disabled="true"` on the host element yourself to communicate the disabled state to assistive technologies.
- `MenuItemComponent` adds an `is-active` CSS class when `isSelected` is `true`, but does not set `aria-current`. For navigation menus where an item represents the current page or section, add `aria-current="page"` (or the appropriate value) on the active item's host element.
- Icons projected via `<i corp-icon>` that are purely decorative should carry `aria-hidden="true"` on the icon element.

## Usage examples

### Text

```html
<nav corp-menu>
	<button corp-menu-item routerLink="#1" [isSelected]="true">
		Vuelos
	</button>
	<button corp-menu-item routerLink="#2">
		Tu reserva
	</button>
	<button corp-menu-item routerLink="#3" [isDisabled]="true">
		Descubre
	</button>
	<button corp-menu-item routerLink="#4">
		Company
	</button>
</nav>
```

### TextIcon

```html
<nav corp-menu>
	<button corp-menu-item routerLink="#1" [isSelected]="true">
		<i corp-icon icon="aircraft"></i>
		Vuelos
	</button>
	<button corp-menu-item routerLink="#2">
		<i corp-icon icon="aircraft"></i>
		Tu reserva
	</button>
	<button corp-menu-item routerLink="#3" [isDisabled]="true">
		<i corp-icon icon="aircraft"></i>
		Descubre
	</button>
	<button corp-menu-item routerLink="#4">
		<i corp-icon icon="aircraft"></i>
		Company
	</button>
</nav>
```

### TextWithLegend

```html
<nav corp-menu>
	<button corp-menu-item routerLink="#1" [legend]="'Legend content'" [isSelected]="true">
		Vuelos
	</button>
	<button corp-menu-item routerLink="#2" [legend]="'Legend content'">
		Tu reserva
	</button>
	<button corp-menu-item routerLink="#3" [legend]="'Legend content'" [isDisabled]="true">
		Descubre
	</button>
	<button corp-menu-item routerLink="#4" [legend]="'Legend content'">
		Company
	</button>
</nav>
```

### TextIconWithLegend

```html
<nav corp-menu>
	<button corp-menu-item routerLink="#1" [legend]="'Legend content'" [isSelected]="true">
		<i corp-icon icon="aircraft"></i>
		Vuelos
	</button>
	<button corp-menu-item routerLink="#2" [legend]="'Legend content'">
		<i corp-icon icon="aircraft"></i>
		Tu reserva
	</button>
	<button corp-menu-item routerLink="#3" [legend]="'Legend content'" [isDisabled]="true">
		<i corp-icon icon="aircraft"></i>
		Descubre
	</button>
	<button corp-menu-item routerLink="#4" [legend]="'Legend content'">
		<i corp-icon icon="aircraft"></i>
		Company
	</button>
</nav>
```

### SingleItem

```html
<nav corp-menu>
	<button corp-menu-item routerLink="#1" [legend]="'Legend content'" [isSelected]="true">
		<i corp-icon icon="aircraft"></i>
		Vuelos
	</button>
</nav>
```
