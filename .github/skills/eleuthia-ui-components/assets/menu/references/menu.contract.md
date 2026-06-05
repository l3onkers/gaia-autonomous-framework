# Menu contract

**Selector:** `corp-menu, [corp-menu]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isFullwidth` | `boolean \| undefined` | `undefined` | Whether all menu items should stretch to fill the available width equally. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `clicked` | `MenuItemComponent` | Emitted when any projected `MenuItemComponent` is clicked. The clicked item is passed as the event payload. |

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| (default) | Container for `corp-menu-item` elements that form the navigation menu. |

## Variants and states

| Variant | Purpose |
|---------|---------|
| `vertical` | Stacks menu items vertically for side menus or mobile drawers. |
| `contextual` | Displays the menu as a floating panel with padding, border, and shadow for dropdown-style layouts. |

## CSS tokens

| Token | Default | contextual | Purpose |
|-------|---------|-----------|---------|
| `--color-quaternary` | `var(--color-khaki-500)` | — | Text color on hover state for menu items. |
| `--color-light` | `#FFFFFF` | `#FFFFFF` | Background color for contextual variant. |
| `--color-secondary-15` | `var(--color-brown-200)` | `var(--color-brown-200)` | Border color for contextual variant. |
| `--shadow-light` | `0px 2px 6px rgba(69, 35, 37, 0.15)` | `0px 2px 6px rgba(69, 35, 37, 0.15)` | Shadow for contextual variant. |
| `--border-radius` | `0.4rem` | `0.4rem` | Border radius for contextual variant. |
