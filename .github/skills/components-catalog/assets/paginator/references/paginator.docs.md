# Paginator documentation

The Paginator component allows users to navigate through a set of paged content. It supports two display modes: a numbered layout that shows individual page items with ellipsis truncation for long page ranges, and a simple layout with previous/next navigation buttons and an optional page counter text.

## Best practices

- Always provide a `pagination` object with accurate `currentPage`, `itemsPerPage`, and `totalItems` values. The component derives `totalPages` from these values and will not render correctly if they are inconsistent.
- Use the `simple` variant for contexts where vertical space is limited or where an exact page number is less relevant (e.g. a mobile card feed). Use the default numbered variant when users need to jump to a specific page.
- In the `simple` variant, always supply `texts.prevString` and `texts.nextString` in the `pagination.texts` object. Without them the navigation buttons render only an icon, which has no accessible name for screen readers.
- In the `simple` variant, also supply `texts.pageString` and `texts.ofString` to show the "Page X of Y" counter. Omitting `texts` entirely hides the counter but still shows the navigation buttons.
- Keep `currentPage` within the valid range `[1, totalPages]`. Values outside this range will produce incorrect visual states.
- The component does not navigate on its own. Listen to `onPaginatorClicked` (numbered variant) and `onSimpleNavClicked` (simple variant) to update your data source and reflect the new page in the `pagination` input.

### Paginator vs. infinite scroll

Use the Paginator when the total number of items is known and users may need to reach a specific page. Prefer infinite scroll for exploratory browsing where the total count is either unknown or irrelevant.

## Content guidelines

Labels displayed inside the paginator come from the consumer via the `pagination.texts` object. Apply the following rules when writing them:

- Keep `prevString` and `nextString` short — one word is ideal ("Previous", "Next", "Prev", "Next").
- Write `pageString` and `ofString` as lowercase function words matching the application language (e.g. "Page" and "of" in English; "Página" and "de" in Spanish).
- Translate all strings to match the application language. The component does not provide any default strings — all label text is the consumer's responsibility.
- Do not use punctuation at the end of `prevString` or `nextString`.

## Related components

- **corp-paginator-item** — the individual page item rendered inside the default (numbered) paginator. It can also be used independently as a standalone element or attribute directive.

## Accessibility

The component does not add a `role="navigation"` or `aria-label` to the host element. Wrap `<corp-paginator>` inside a `<nav aria-label="Pagination">` element so screen reader users can identify and navigate to the pagination region.

In the `simple` variant, always provide `texts.prevString` and `texts.nextString`. Without visible text the navigation buttons have no accessible name. If text labels are not desired visually, the consumer must add `aria-label` directly on the host or on the projected button.

The `is-disabled` CSS class on `corp-paginator-item` suppresses pointer events but does not remove keyboard focus or communicate the disabled state to assistive technologies. Add `aria-disabled="true"` on the host element when `isDisabled` is true.

The `is-selected` CSS class on `corp-paginator-item` changes only visual styling. Add `aria-current="page"` on the host element of the active page item so screen readers announce which page is current.

Ellipsis items (`...`) are rendered as focusable buttons. They carry no meaningful action and should not receive keyboard focus. Add `aria-hidden="true"` and `tabindex="-1"` on the host when using `corp-paginator-item` as an ellipsis separator.

## Usage examples

### Simple

```html
<corp-paginator
	variant="simple"
	[pagination]="{
		currentPage: 1,
		itemsPerPage: 2,
		totalItems: 10
	}">
</corp-paginator>
```

### Short

```html
<corp-paginator
	[pagination]="{
		currentPage: 3,
		itemsPerPage: 2,
		totalItems: 10
	}">
</corp-paginator>
```

### Long

```html
<corp-paginator
	[pagination]="{
		currentPage: 7,
		itemsPerPage: 2,
		totalItems: 30
	}">
</corp-paginator>
```
