# Utility classnames

All utility classes are applied on HTML elements in Angular templates. Never use them inside component SCSS.

> **rem rule:** base font-size is 62.5%, so 1rem = 10px. All sizing values use rem. Exception: `@media` breakpoints always use px.

---

## Flex

Apply `u-flex` to a container and combine with modifier classes to control direction, alignment, and item positioning.

### Base classes

| Class | Effect |
|-------|--------|
| `u-flex` | `display: flex; align-items: center` |
| `u-flex-sm` | `display: flex` from 768px upwards |
| `u-flex-md` | `display: flex` from 992px upwards |
| `u-display-contents` | `display: contents` — removes the box, children participate in parent layout |

### Direction modifiers (add to element with `u-flex`)

| Class | Effect |
|-------|--------|
| *(default)* | `flex-direction: row` |
| `is-column` | `flex-direction: column; align-items: flex-start` |
| `is-reverse` | `flex-direction: row-reverse` |
| `is-reverse is-column` | `flex-direction: column-reverse` |
| `is-inline` | `display: inline-flex` |
| `is-wrap` | `flex-wrap: wrap` |

### Align items modifiers

| Class | Value |
|-------|-------|
| *(default)* | `align-items: center` |
| `is-ai-fs` | `align-items: flex-start` |
| `is-ai-fe` | `align-items: flex-end` |
| `is-ai-c` | `align-items: center` |
| `is-ai-s` | `align-items: stretch` |
| `is-ai-n` | `align-items: normal` |

### Justify content modifiers

| Class | Value |
|-------|-------|
| `is-jc-fs` | `justify-content: flex-start` |
| `is-jc-c` | `justify-content: center` |
| `is-jc-fe` | `justify-content: flex-end` |
| `is-jc-sb` | `justify-content: space-between` |

### Flex growth and order

| Class | Effect |
|-------|--------|
| `is-flex-grow` | `flex-grow: 1` |
| `is-flex-1` | `flex: 1` |
| `is-flex-first-el` | `order: -1` — moves element to the beginning |

### Child positioning helpers (apply to a child of `u-flex`)

| Class | Effect |
|-------|--------|
| `u-flex__left` | `margin-right: auto` — pushes siblings to the right |
| `u-flex__right` | `margin-left: auto` — pushes siblings to the left |
| `u-flex__top` | `margin-bottom: auto` — pushes siblings downward |
| `u-flex__bottom` | `margin-top: auto` — pushes siblings upward |
| `u-flex__center` | `margin-inline: auto` — centers horizontally |
| `u-flex__vcenter` | `margin-block: auto` — centers vertically |

### Examples

```html
<!-- Row with space-between and gap -->
<nav class="u-flex is-jc-sb u-gap-24">
  <section class="u-flex u-gap-8">...</section>
  <section class="u-flex__right u-gap-24">...</section>
</nav>

<!-- Column aligned to start -->
<section class="u-flex is-column is-ai-s u-gap-16">
  <header class="u-flex u-gap-16">...</header>
  <p>...</p>
</section>

<!-- Responsive: block on mobile, flex on desktop -->
<div class="u-flex-md is-jc-c u-gap-24">
  <div>...</div>
  <div>...</div>
</div>
```

---

## Spacing

Spacing classes for margin, padding, and gap. All values are multiples of 4px. Each value maps to a CSS custom property (`u-m-16` applies `margin: var(--size-16)`).

### Available values

`0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80`

### Responsive syntax

`u-{property}-{breakpoint}-{value}` applies from that breakpoint upwards.

Example: `u-mt-md-24` applies `margin-top: 2.4rem` from 992px upwards.

Breakpoints: `xs` (0px), `sm` (768px), `md` (992px), `lg` (1224px).

### Margin

| Class | CSS property |
|-------|-------------|
| `u-m-{value}` | `margin` |
| `u-mt-{value}` | `margin-top` |
| `u-mb-{value}` | `margin-bottom` |
| `u-ml-{value}` | `margin-left` |
| `u-mr-{value}` | `margin-right` |
| `u-m-inline-{value}` | `margin-inline` (left + right) |
| `u-m-block-{value}` | `margin-block` (top + bottom) |
| `u-mt-less-1` | `margin-top: -1px` |
| `u-mb-less-1` | `margin-bottom: -1px` |

### Padding

| Class | CSS property |
|-------|-------------|
| `u-p-{value}` | `padding` |
| `u-pt-{value}` | `padding-top` |
| `u-pb-{value}` | `padding-bottom` |
| `u-pl-{value}` | `padding-left` |
| `u-pr-{value}` | `padding-right` |
| `u-p-inline-{value}` | `padding-inline` (left + right) |
| `u-p-block-{value}` | `padding-block` (top + bottom) |

### Gap

| Class | CSS property |
|-------|-------------|
| `u-gap-{value}` | `gap` |
| `u-row-gap-{value}` | `row-gap` |
| `u-col-gap-{value}` | `column-gap` |

### Examples

```html
<!-- No top margin on mobile, 2.4rem from md upwards -->
<section class="u-mt-0 u-mt-md-24">...</section>

<!-- Responsive gap in a flex container -->
<div class="u-flex u-gap-16 u-gap-md-24">
  <company-avatar size="sm"></company-avatar>
  <span>John Doe</span>
</div>

<!-- Responsive padding in a card footer -->
<footer class="u-flex u-gap-16 u-gap-md-24 u-p-16 u-p-md-32">...</footer>
```

---

## Colors

Color utility classes for text and background. All classes reference semantic CSS tokens. Never use primitive tokens (`--color-red-500`) in markup or templates.

> **Note:** `u-color-secondary-20`, `u-color-secondary-50`, and their `u-bgcolor-*` counterparts reference tokens that are not defined in the token file. They will resolve to an empty value at runtime. Use `--color-secondary-15` or `--color-secondary-40` instead.

### Text color classes

| Class | Token |
|-------|-------|
| `u-color-light` | `--color-light` |
| `u-color-primary` | `--color-primary` |
| `u-color-primary-90` | `--color-primary-90` |
| `u-color-primary-10` | `--color-primary-10` |
| `u-color-primary-5` | `--color-primary-5` |
| `u-color-secondary` | `--color-secondary` |
| `u-color-secondary-80` | `--color-secondary-80` |
| `u-color-secondary-70` | `--color-secondary-70` |
| `u-color-secondary-60` | `--color-secondary-60` |
| `u-color-secondary-40` | `--color-secondary-40` |
| `u-color-secondary-15` | `--color-secondary-15` |
| `u-color-secondary-10` | `--color-secondary-10` |
| `u-color-secondary-5` | `--color-secondary-5` |
| `u-color-tertiary` | `--color-tertiary` |
| `u-color-tertiary-5` | `--color-tertiary-5` |
| `u-color-quaternary` | `--color-quaternary` |
| `u-color-quaternary-5` | `--color-quaternary-5` |
| `u-color-brand-green` | `--color-brand-green` |
| `u-color-voloterra` | `--color-voloterra` |
| `u-color-facebook` | `--color-facebook` |
| `u-color-facebook-dark` | `--color-facebook-dark` |
| `u-color-twitter` | `--color-twitter` |
| `u-color-google-plus` | `--color-google-plus` |
| `u-color-instagram` | `--color-instagram` |
| `u-color-trip-advisor` | `--color-trip-advisor` |
| `u-color-paypal` | `--color-paypal` |
| `u-color-apple` | `--color-apple` |
| `u-color-aegean` | `--color-aegean` |

### Background color classes

| Class | Token |
|-------|-------|
| `u-bgcolor-light` | `--color-light` |
| `u-bgcolor-primary` | `--color-primary` |
| `u-bgcolor-primary-5` | `--color-primary-5` |
| `u-bgcolor-secondary` | `--color-secondary` |
| `u-bgcolor-secondary-60` | `--color-secondary-60` |
| `u-bgcolor-secondary-40` | `--color-secondary-40` |
| `u-bgcolor-secondary-15` | `--color-secondary-15` |
| `u-bgcolor-secondary-10` | `--color-secondary-10` |
| `u-bgcolor-secondary-5` | `--color-secondary-5` |
| `u-bgcolor-tertiary` | `--color-tertiary` |
| `u-bgcolor-tertiary-5` | `--color-tertiary-5` |
| `u-bgcolor-quaternary` | `--color-quaternary` |
| `u-bgcolor-quaternary-5` | `--color-quaternary-5` |

### Examples

```html
<!-- Icon with brand color -->
<i corp-icon icon="check-bold" class="u-color-primary"></i>

<!-- Disabled text -->
<p class="u-color-secondary-40">This option is not available</p>

<!-- Error validation -->
<div class="u-bgcolor-primary-5 u-color-primary">
  Please review your selection
</div>
```

---

## Borders

### Border classes

Apply a solid dark border (`0.1rem solid var(--border-color-dark)`) to any element.

| Class | CSS property |
|-------|-------------|
| `u-border` | `border: var(--border-solid-dark)` (all sides) |
| `u-border--dashed` | `border-style: dashed` |
| `u-border-top` | `border-top: var(--border-solid-dark)` |
| `u-border-top--dashed` | `border-top-style: dashed` |
| `u-border-bottom` | `border-bottom: var(--border-solid-dark)` |
| `u-border-bottom--dashed` | `border-bottom-style: dashed` |
| `u-border-left` | `border-left: var(--border-solid-dark)` |
| `u-border-left--dashed` | `border-left-style: dashed` |
| `u-border-right` | `border-right: var(--border-solid-dark)` |
| `u-border-right--dashed` | `border-right-style: dashed` |
| `u-border-block` | Top and bottom borders |
| `u-border-block--dashed` | Both top and bottom `border-style: dashed` |
| `u-border-inline` | Left and right borders |
| `u-border-inline--dashed` | Both left and right `border-style: dashed` |

### Full-width borders

These use a `::before` pseudo-element to stretch a border across the full viewport width. The element must have `position: relative`.

| Class | Effect |
|-------|--------|
| `u-full-border-top` | 1px line spanning full viewport width, placed at top |
| `u-full-border-bottom` | 1px line spanning full viewport width, placed at bottom |

### Border radius

| Class | Token | Value |
|-------|-------|-------|
| `u-bradius` | `--border-radius` | 0.4rem (4px) |
| `u-bradius--sm` | `--border-radius-sm` | 0.2rem (2px) |
| `u-bradius--lg` | `--border-radius-lg` | 0.8rem (8px) |

Directional modifiers (combine with size modifier):

| Class | Effect |
|-------|--------|
| `u-bradius--top` | Rounds top corners only |
| `u-bradius--bottom` | Rounds bottom corners only |

Example: `u-bradius--lg--top` applies `--border-radius-lg` to top corners only.

### Responsive border control

| Class | Behaviour |
|-------|-----------|
| `u-no-border-{bp}` | Removes border from that breakpoint upwards |
| `u-border-{bp}` | Removes border below that breakpoint (shows from `{bp}` upwards) |

Example: `u-border-md` hides the border on mobile and shows it from 992px upwards.

### Examples

```html
<!-- Card with bottom divider -->
<div class="u-border-bottom">...</div>

<!-- Dashed separator -->
<hr class="u-border-top--dashed" />

<!-- Border only on desktop -->
<div class="u-border-md u-border-bottom">...</div>
```

---

## Visibility

### Unconditional hide

| Class | Effect |
|-------|--------|
| `u-hide` | `display: none !important` at all viewports |

### Responsive hide

`u-hide-{breakpoint}` — hides from that breakpoint upwards, visible below it.

| Class | Hides from | Visible below |
|-------|-----------|---------------|
| `u-hide-xs` | 0px (always hidden) | — |
| `u-hide-sm` | 768px | 0 – 767px |
| `u-hide-md` | 992px | 0 – 991px |
| `u-hide-lg` | 1224px | 0 – 1223px |

### Responsive show

`u-show-{breakpoint}` — hidden below that breakpoint, visible from it upwards.

| Class | Hidden below | Visible from |
|-------|-------------|--------------|
| `u-show-xs` | — | 0px |
| `u-show-sm` | 0 – 767px | 768px |
| `u-show-md` | 0 – 991px | 992px |
| `u-show-lg` | 0 – 1223px | 1224px |

### Examples

```html
<!-- Desktop only -->
<aside class="u-show-md">...</aside>

<!-- Mobile only -->
<div class="u-hide-md">...</div>

<!-- Toggle between two layouts at a breakpoint -->
<div class="u-hide-md"><company-avatar size="sm"></company-avatar></div>
<div class="u-show-md"><company-avatar size="lg"></company-avatar></div>
```

---

## Position

### Absolute positioning

Apply `u-abs` to set `position: absolute`. Add state classes to control which edges the element anchors to. Each edge reads a CSS custom property that defaults to `0`.

| Class | CSS property |
|-------|-------------|
| `u-abs` | `position: absolute` |
| `u-abs.is-t` | `top: var(--abs-top)` |
| `u-abs.is-r` | `right: var(--abs-right)` |
| `u-abs.is-b` | `bottom: var(--abs-bottom)` |
| `u-abs.is-l` | `left: var(--abs-left)` |

State classes can be combined freely: `u-abs is-t is-r` pins to top-right corner.

Override offsets inline:

| Property | Default | Controls |
|----------|---------|---------|
| `--abs-top` | `0` | `top` offset |
| `--abs-right` | `0` | `right` offset |
| `--abs-bottom` | `0` | `bottom` offset |
| `--abs-left` | `0` | `left` offset |

```html
<div class="u-abs is-t is-r" style="--abs-top: 0.8rem; --abs-right: 0.8rem;">
  <corp-badge variant="promo">-20%</corp-badge>
</div>
```

### Sticky positioning

| Class | CSS property |
|-------|-------------|
| `u-sticky-top` | `position: sticky; top: var(--sticky-top)` |
| `u-sticky-bottom` | `position: sticky; bottom: var(--sticky-bottom)` |

Override offsets:

| Property | Default | Controls |
|----------|---------|---------|
| `--sticky-top` | `0` | Distance from top of scroll container |
| `--sticky-bottom` | `0` | Distance from bottom of scroll container |

Two syntaxes for overriding the offset:

```html
<!-- Static value -->
<header class="u-sticky-top" style="--sticky-top: 6.4rem;">...</header>

<!-- Angular binding (preferred when value is dynamic) -->
<corp-header
  class="u-sticky-top"
  [style.--sticky-top]="headerOffset()">
</corp-header>
```

---

## Shadows

All shadow classes are responsive — they activate or suppress the shadow from a given breakpoint upwards.

| Class | Effect | Token |
|-------|--------|-------|
| `u-shadow-{bp}` | `box-shadow` from `{bp}` upwards | `--shadow-light` |
| `u-shadow-light-{bp}` | Alias of `u-shadow-{bp}` | `--shadow-light` |
| `u-shadow-dark-{bp}` | `box-shadow` from `{bp}` upwards | `--shadow-dark` |
| `u-no-shadow-{bp}` | `box-shadow: none !important` from `{bp}` upwards | — |

Below the active breakpoint, `u-shadow-{bp}` and `u-shadow-light-{bp}` collapse to `box-shadow: none !important`.

Breakpoints: `xs` (0px), `sm` (768px), `md` (992px), `lg` (1224px).

### Examples

```html
<!-- No shadow on mobile, light shadow from sm upwards -->
<div class="u-shadow-sm">...</div>

<!-- Light on tablet, dark on desktop -->
<div class="u-shadow-sm u-shadow-dark-md">...</div>

<!-- Shadow from all breakpoints -->
<company-avatar class="u-shadow-xs"></company-avatar>

<!-- Suppress component shadow from lg upwards -->
<div class="u-no-shadow-lg">...</div>
```

---

## Image

| Class | CSS properties | Behaviour |
|-------|---------------|-----------|
| `u-img` | `display: block; width: 100%; height: auto` | Fills container width, scales height proportionally |
| `u-img.is-by-height` | `width: auto; height: 100%` | Fills container height, scales width proportionally |

Apply `u-img` directly on the `<img>` element. Add `is-by-height` when the constraining dimension is the height of the parent.

### Examples

```html
<!-- Fluid image inside a card -->
<img class="u-img" src="destination.jpg" alt="Destination" />

<!-- Fixed-height image strip scaled by height -->
<div style="height: 20rem; overflow: hidden;">
  <img class="u-img is-by-height" src="banner.jpg" alt="Banner" />
</div>
```

---

## Typography

| Class | CSS property |
|-------|-------------|
| `u-tal` | `text-align: left` |
| `u-tar` | `text-align: right` |
| `u-tac` | `text-align: center` |
| `u-italic` | `font-style: italic` |
| `u-line-through` | `text-decoration: line-through` |
| `u-ellipsis` | `overflow: hidden; text-overflow: ellipsis; white-space: nowrap` |

`u-ellipsis` requires a constrained width on the element for truncation to take effect.

### Examples

```html
<!-- Centered heading -->
<h2 class="u-tac">Choose your seat</h2>

<!-- Strikethrough original price -->
<span class="u-line-through u-tar">€ 79.99</span>

<!-- Truncated text in a fixed-width cell -->
<td class="u-ellipsis" style="max-width: 12rem;">John Alexander Doe</td>
```
