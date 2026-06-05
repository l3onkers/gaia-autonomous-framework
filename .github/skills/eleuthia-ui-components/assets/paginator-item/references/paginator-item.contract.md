# Paginator Item contract

**Selector:** `corp-paginator-item, [corp-paginator-item]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `page` | `number` | `1` | Page number this item represents. Emitted via `clicked` when the item is activated. |
| `label` | `string` | `''` | Text label displayed inside the item. When empty and `isPrev` or `isNext` is true, the item renders only the arrow icon — the consumer must supply an accessible label via `aria-label` on the host. |
| `routerLink` | `string` | `''` | When provided, the item renders as an `<a>` element with this value set as the `routerLink` attribute. Otherwise renders as a `<button>`. |
| `isNext` | `boolean` | `false` | When true, renders a right-arrow icon indicating the "next" navigation action. |
| `isPrev` | `boolean` | `false` | When true, renders a left-arrow icon indicating the "previous" navigation action. |
| `isDisabled` | `boolean` | `false` | Whether the item is disabled. Applies `is-disabled` CSS class and suppresses pointer events. Also add `aria-disabled="true"` on the host so screen readers are informed. |
| `isSelected` | `boolean` | `false` | Whether this item represents the currently active page. Applies `is-selected` CSS class. Also add `aria-current="page"` on the host so screen readers announce the current page. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `clicked` | `number` | Emitted with the page number when the item is clicked. |

### Models

None.

## Slots

None.

## Variants and states

No variants defined for this component. It inherits the variant system from `BaseUIComponent` but does not define specific variant values in `defaults.ts`.

## CSS tokens

| Token | Default | Purpose |
|-------|---------|---------|
| `--color-secondary-40` | `#B5A7A8` | Text color for normal state. |
| `--color-secondary` | `#452325` | Text color for hover and selected states. |
| `--color-primary-90` | `#FF0E51` | Border color for selected state. |
