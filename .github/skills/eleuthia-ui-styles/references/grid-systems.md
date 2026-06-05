# Grid systems

Two independent systems — do not mix them in the same layout block.

| System | Prefix | Mechanism | Requires wrapper |
|--------|--------|-----------|-----------------|
| CSS Grid | `l-grid-*` | Native `display: grid` | `l-grid-wrapper` only |
| Flexbox Grid | `g-col-*` | `display: flex; flex-wrap: wrap` | `g-wrapper` + `g-row` + `g-col-*` |

---

## CSS Grid — `l-grid-*`

### Container

| Class | Effect |
|-------|--------|
| `l-grid-wrapper` | `display: grid; grid-template-columns: repeat(12, 1fr); width: 100%; margin: 0 auto` |
| `l-grid-wrapper.is-max-content` | Same but `width: max-content` — shrinks to fit content |

The gap between columns is applied automatically per breakpoint. Do not add `u-gap-*` for inter-column gap.

### Automatic gutters

| Breakpoint | Min-width | Gap |
|------------|-----------|-----|
| `xs` | 0px | `1.6rem` |
| `sm` | 768px | `1.6rem` |
| `md` | 992px | `2rem` |
| `lg` | 1224px | `2.4rem` |

### Column span classes

Syntax: `l-grid-col-{breakpoint}-{span}`

- `{breakpoint}` — `xs`, `sm`, `md`, or `lg`
- `{span}` — integer from `1` to `12`

Each class sets `grid-column: span N` and applies from the named breakpoint upwards (min-width). Combine classes for multiple breakpoints on the same element.

| Breakpoint | Min-width | Available classes |
|------------|-----------|-------------------|
| `xs` | 0px | `l-grid-col-xs-1` … `l-grid-col-xs-12` |
| `sm` | 768px | `l-grid-col-sm-1` … `l-grid-col-sm-12` |
| `md` | 992px | `l-grid-col-md-1` … `l-grid-col-md-12` |
| `lg` | 1224px | `l-grid-col-lg-1` … `l-grid-col-lg-12` |

### Examples

```html
<!-- Two equal columns at all sizes -->
<div class="l-grid-wrapper">
  <div class="l-grid-col-xs-6"><company-price-card></company-price-card></div>
  <div class="l-grid-col-xs-6"><company-price-card></company-price-card></div>
</div>

<!-- Full width on mobile, side-by-side on desktop -->
<div class="l-grid-wrapper">
  <div class="l-grid-col-xs-12 l-grid-col-md-6">
    <company-feedback-box></company-feedback-box>
  </div>
  <div class="l-grid-col-xs-12 l-grid-col-md-6">
    <company-feedback-box></company-feedback-box>
  </div>
</div>

<!-- Sidebar (3 cols) + main content (9 cols) -->
<div class="l-grid-wrapper">
  <aside class="l-grid-col-xs-12 l-grid-col-lg-3"><!-- filters --></aside>
  <main class="l-grid-col-xs-12 l-grid-col-lg-9"><!-- content --></main>
</div>

<!-- Four-column card grid -->
<div class="l-grid-wrapper">
  <div class="l-grid-col-xs-12 l-grid-col-sm-6 l-grid-col-lg-3">
    <corp-badge>Economy</corp-badge>
  </div>
  <div class="l-grid-col-xs-12 l-grid-col-sm-6 l-grid-col-lg-3">
    <corp-badge>Basic</corp-badge>
  </div>
  <div class="l-grid-col-xs-12 l-grid-col-sm-6 l-grid-col-lg-3">
    <corp-badge>Comfort</corp-badge>
  </div>
  <div class="l-grid-col-xs-12 l-grid-col-sm-6 l-grid-col-lg-3">
    <corp-badge>Premium</corp-badge>
  </div>
</div>

<!-- Shrink wrapper to content width -->
<div class="l-grid-wrapper is-max-content">
  <div class="l-grid-col-xs-12">
    <corp-input-text label="Promo code"></corp-input-text>
  </div>
</div>
```

---

## Flexbox Grid — `g-col-*`

Three-level structure required: `g-wrapper` > `g-row` > `g-col-{breakpoint}-{span}`.

### Wrapper

| Class | Effect |
|-------|--------|
| `g-wrapper` | `display: block; margin: 0 auto; max-width: 122.4rem` |
| `g-wrapper--fluid` | Same but `max-width: 100%` — full viewport width |
| `g-wrapper--{breakpoint}` | Forces `width: 100%` below that breakpoint |

The wrapper adjusts its width per breakpoint to account for the gutter on both sides:

| Breakpoint | Min-width | Wrapper width |
|------------|-----------|---------------|
| `xs` | 0px | `calc(100% - 3.2rem)` |
| `sm` | 768px | `calc(100% - 3.2rem)` |
| `md` | 992px | `calc(100% - 4rem)` |
| `lg` | 1224px | `calc(100% - 4.8rem)` |

### Row

| Class | Effect |
|-------|--------|
| `g-row` | `display: flex; flex-wrap: wrap` with negative margins compensating for column padding |

Row negative margins per breakpoint:

| Breakpoint | Negative margin (each side) |
|------------|----------------------------|
| `xs` | `-0.8rem` |
| `sm` | `-0.8rem` |
| `md` | `-1rem` |
| `lg` | `-1.2rem` |

### Column classes

Every `g-col-*` element is `display: block; width: 100%` by default.

#### Auto-grow column

| Class | Effect |
|-------|--------|
| `g-col` | `flex: 1 1 0; max-width: 100%` — grows to fill remaining space |

#### Sized columns

Syntax: `g-col-{breakpoint}-{span}`

- `{breakpoint}` — `xs`, `sm`, `md`, or `lg`
- `{span}` — integer from `1` to `12`

Applies from the named breakpoint upwards. Combine classes for responsive layouts.

| Breakpoint | Min-width | Available classes |
|------------|-----------|-------------------|
| `xs` | 0px | `g-col-xs-1` … `g-col-xs-12` |
| `sm` | 768px | `g-col-sm-1` … `g-col-sm-12` |
| `md` | 992px | `g-col-md-1` … `g-col-md-12` |
| `lg` | 1224px | `g-col-lg-1` … `g-col-lg-12` |

#### Half-step columns

Fractional widths using `_5` notation (represents `.5`):

Syntax: `g-col-{breakpoint}-{n}_5` — width equals `(n - 0.5) / 12 * 100%`.

Examples: `g-col-xs-0_5` (4.17%), `g-col-md-1_5` (12.5%), `g-col-lg-2_5` (20.83%).

#### Column gutters (horizontal padding per side)

| Breakpoint | Padding (each side) |
|------------|---------------------|
| `xs` | `0.8rem` |
| `sm` | `0.8rem` |
| `md` | `1rem` |
| `lg` | `1.2rem` |

#### Offset classes

Push a column right by adding a left margin equal to N column widths.

Syntax: `g-col-{breakpoint}-offset-{n}` — also `g-col-{breakpoint}-offset-0` to reset.

Half-step offsets: `g-col-{breakpoint}-offset-{n}_5`.

#### Push classes

Visually reposition a column without affecting document order.

Syntax: `g-col-{breakpoint}-push-{n}` — adds `left: N / 12 * 100%`.

Reset: `g-col-{breakpoint}-push-0`.

#### Float helpers (for non-flex environments)

| Class | Effect |
|-------|--------|
| `g-col-{breakpoint}-left` | `float: left` |
| `g-col-{breakpoint}-right` | `float: right` |

### Examples

```html
<!-- Two equal columns at all sizes -->
<div class="g-wrapper">
  <div class="g-row">
    <div class="g-col-xs-6"><company-price-card></company-price-card></div>
    <div class="g-col-xs-6"><company-price-card></company-price-card></div>
  </div>
</div>

<!-- Full width on mobile, side-by-side on desktop -->
<div class="g-wrapper">
  <div class="g-row">
    <div class="g-col-xs-12 g-col-md-6"><company-feedback-box></company-feedback-box></div>
    <div class="g-col-xs-12 g-col-md-6"><company-feedback-box></company-feedback-box></div>
  </div>
</div>

<!-- Sidebar (3 cols) + main content (9 cols) -->
<div class="g-wrapper">
  <div class="g-row">
    <aside class="g-col-xs-12 g-col-lg-3"><!-- filters --></aside>
    <main class="g-col-xs-12 g-col-lg-9"><!-- content --></main>
  </div>
</div>

<!-- Column with offset — centred form -->
<div class="g-wrapper">
  <div class="g-row">
    <div class="g-col-xs-12 g-col-md-6 g-col-md-offset-3">
      <corp-input-text label="Promo code"></corp-input-text>
    </div>
  </div>
</div>

<!-- Full-bleed banner -->
<div class="g-wrapper g-wrapper--fluid">
  <div class="g-row">
    <div class="g-col-xs-12"><!-- full-bleed content --></div>
  </div>
</div>
```
