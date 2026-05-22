# Paginator contract

**Selector:** `corp-paginator`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `pagination` | `Pagination \| undefined` | `undefined` | Pagination state: current page, items per page, total items, and optional display strings. |
| `variant` | `string` | `''` | Visual variant; use `'simple'` for previous/next navigation with optional page counter, or leave empty for default numbered pagination. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `onPaginatorClicked` | `number` | Emitted when the user clicks a numbered page item. The payload is the target page number. |
| `onSimpleNavClicked` | `number` | Emitted when the user clicks the previous or next navigation button. The payload is the target page number. |

### Models

None.

## Slots

None.

## Variants and states

| Variant | Purpose |
|---------|---------|
| (default) | Numbered pagination layout showing individual page items with ellipsis truncation for long page ranges. |
| `simple` | Simplified layout with previous/next navigation buttons and optional page counter text. |

## CSS tokens

| Token | Default | simple | Purpose |
|-------|---------|--------|---------|
| `gap` (flexbox gap) | `0.8rem` | `1.6rem` | Space between pagination items (or between buttons and text in simple variant). |
