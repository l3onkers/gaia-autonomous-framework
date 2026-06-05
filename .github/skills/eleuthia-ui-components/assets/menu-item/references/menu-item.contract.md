# Menu Item contract

**Selector:** `[corp-menu-item]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isDropdown` | `boolean` | `false` | Whether the item renders a dropdown toggle arrow button. When `true`, project the dropdown panel via `[slot=dropdown]`. |
| `iconPosition` | `'left' \| 'right'` | `'left'` | Position of the projected icon relative to the label text. |
| `legend` | `string \| undefined` | `undefined` | Optional secondary label rendered below the main item content. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `clicked` | `MenuItemComponent` | Emitted when the item is clicked. The payload is the component instance itself. |

### Models

| Name | Type | Description |
|------|------|-------------|
| `isDisabled` | `boolean` | Whether the item is disabled. Adds `is-disabled` (CSS only). Also add `aria-disabled="true"` on the host until the component binds this attribute automatically. |
| `isSelected` | `boolean` | Whether the item is currently selected or active. Adds `is-active` (CSS only). Add `aria-current="page"` on the host for navigation contexts, or `aria-selected`/`aria-checked` for selection contexts. |

## Slots

| Selector | Purpose |
|----------|---------|
| (default) | Label text and icon for the menu item. |
| `corp-icon, [corp-icon]` | Icon component projected alongside the label. |
| `[slot=dropdown]` | Dropdown panel content projected when `isDropdown` is `true`. |

## Variants and states

No explicit variants. The component adapts its styling based on the parent container (`corp-menu`, `corp-menu-tab`, `corp-menu-segment`) and the following state classes:
- `is-active` — applied when `isSelected` is `true`
- `is-disabled` — applied when `isDisabled` is `true`
- `is-icon-right` — applied when `iconPosition` is `'right'`

## CSS tokens

| Token | Default value | Purpose |
|-------|--------|---------|
| `--menu-item-padding` | `0rem 1rem` | Padding of the item's inner container. |
| `--gap` | `0.8rem` | Gap between icon and label in the inner container. |
| `--color-secondary-60` | `#8F7B7C` | Text color of the item label. |
| `--color-primary` | `#DD0D47` | Border color when item is selected. |
| `--color-secondary` | `#452325` | Text color when item is selected. |
| `--color-secondary-40` | `#B5A7A8` | Text color of the legend. |
| `--color-secondary-15` | `#E3DEDE` | Border color of the arrow layer tooltip. |
| `--color-light` | `#FFFFFF` | Background color of the arrow layer tooltip. |
| `--z-index-sm` | `1` | Z-index for dropdown panel and arrow layer. |
| `--border-radius` | `0.4rem` | Border radius of the arrow layer tooltip. |
| `--font-main` | `"Company-Sans", Helvetica, Arial, sans-serif` | Font family for the legend text. |
