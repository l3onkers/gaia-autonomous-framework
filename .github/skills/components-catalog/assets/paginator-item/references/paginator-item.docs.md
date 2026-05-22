# PaginatorItem documentation

`PaginatorItemComponent` is a single interactive page indicator used inside `PaginatorComponent`. It renders as a circular button or link and supports three states: default, selected (current page), and disabled (ellipsis separators). It can also act as a previous/next navigation arrow.

## Best practices

- Use `PaginatorItemComponent` only as a child of `PaginatorComponent`. Do not instantiate it standalone unless you are building a custom paginator layout.
- Set `isSelected="true"` only on the item that represents the current page. There must be exactly one selected item at a time.
- Set `isDisabled="true"` for ellipsis placeholders (`label="..."`). These items are not interactive and must not emit `clicked`.
- Use `isPrev` / `isNext` together with an empty `label` to render navigation arrows. Always provide an accessible label on the host in this case (see Accessibility section).
- When using the `routerLink` variant, ensure the Angular `RouterModule` is imported in the consuming module so the directive resolves correctly.
- Do not pass both `isPrev` and `isNext` as `true` simultaneously — each item represents a single directional action.

### PaginatorItem vs. simple navigation

The `PaginatorComponent` supports a `variant="simple"` mode that shows only "Previous / Page X of N / Next" controls using `TextButtonComponent`. Use that variant on mobile or when page numbers are not meaningful to the user. Use the item-based layout (default) when users need to jump directly to a specific page.

## Content guidelines

Labels on paginator items should be concise and unambiguous. Follow these rules:

- Use numeric strings (`"1"`, `"2"`) for page number items — no ordinal suffixes.
- Use `"..."` as the label for disabled separator items that indicate skipped page ranges.
- Leave `label` empty when using `isPrev` or `isNext` — the arrow icon conveys the action visually. Always supplement with an accessible text label via `aria-label` on the host.
- Do not use decorative or verbose labels such as "Go to page 3" — the paginator context already establishes the meaning.
- Translate all visible label strings (including prev/next text in the simple variant) to match the application's active language.

## Related components

- **Paginator** — the parent container that generates and manages all `PaginatorItemComponent` instances.

## Usage examples

### Paginator item with page number

```html
<corp-paginator-item
	[page]="3"
	[label]="'3'"
	[isSelected]="false"
	(clicked)="onPageClick($event)">
</corp-paginator-item>
```

### Selected page indicator

```html
<corp-paginator-item
	[page]="3"
	[label]="'3'"
	[isSelected]="true"
	aria-current="page"
	(clicked)="onPageClick($event)">
</corp-paginator-item>
```

### Disabled ellipsis separator

```html
<corp-paginator-item
	[label]="'...'"
	[isDisabled]="true"
	aria-disabled="true">
</corp-paginator-item>
```

### Previous navigation arrow

```html
<corp-paginator-item
	[isPrev]="true"
	[label]="''"
	aria-label="Previous page"
	(clicked)="onPageClick($event)">
</corp-paginator-item>
```

### Next navigation arrow

```html
<corp-paginator-item
	[isNext]="true"
	[label]="''"
	aria-label="Next page"
	(clicked)="onPageClick($event)">
</corp-paginator-item>
```

### With RouterLink navigation

```html
<corp-paginator-item
	[page]="2"
	[label]="'2'"
	[routerLink]="'/results/page/2'"
	(clicked)="onPageClick($event)">
</corp-paginator-item>
```
