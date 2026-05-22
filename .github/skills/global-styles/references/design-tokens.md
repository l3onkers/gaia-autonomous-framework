# Design tokens

Use inside `:host { }` in component SCSS. Never in HTML templates.

> **rem rule:** base font-size is 62.5%, so 1rem = 10px. All sizing values use rem. Exception: `@media` breakpoints always use px (SCSS variables only).

---

## Colors

Semantic tokens only. Never reference primitive tokens (`--color-red-500`, `--color-brown-500`, etc.) directly in component SCSS or templates.

### Primary — Red

| Token | Maps to | Usage |
|-------|---------|-------|
| `--color-primary` | `--color-red-500` | Active state of primary/secondary buttons, selected UI elements, error validation |
| `--color-primary-90` | `--color-red-520` | Hover state on primary buttons only |
| `--color-primary-120` | `--color-red-600` | Hover state on secondary buttons only |
| `--color-primary-30` | `--color-pink-500` | Active/selected state (pink variant) |
| `--color-primary-10` | `--color-red-100` | Border in error validations and informational dialogues |
| `--color-primary-5` | `--color-red-50` | Background for error validations and informational dialogues |

### Secondary — Brown

| Token | Maps to | Usage |
|-------|---------|-------|
| `--color-secondary` | `--color-brown-500` | Headlines, standalone names or phrases |
| `--color-secondary-80` | `--color-brown-475` | — |
| `--color-secondary-70` | `--color-brown-450` | Body text, paragraphs, all legal texts |
| `--color-secondary-60` | `--color-brown-400` | — |
| `--color-secondary-40` | `--color-brown-300` | Disabled text and graphics |
| `--color-secondary-15` | `--color-brown-200` | Component borders, dividers |
| `--color-secondary-10` | `--color-brown-100` | Hover state on primary buttons |
| `--color-secondary-5` | `--color-brown-50` | Deep backgrounds |

### Tertiary — Mustard

| Token | Maps to | Usage |
|-------|---------|-------|
| `--color-tertiary` | `--color-mustard-600` | Feedback text, links, tertiary buttons |
| `--color-tertiary-10` | `--color-mustard-100` | Borders on positive validation cards and informational dialogues |
| `--color-tertiary-5` | `--color-mustard-50` | Background for positive validations and informational dialogues |

### Quaternary — Khaki

| Token | Maps to | Usage |
|-------|---------|-------|
| `--color-quaternary` | `--color-khaki-500` | Hover state on tertiary text, icons, links and buttons |
| `--color-quaternary-70` | `--color-khaki-400` | Pending state |
| `--color-quaternary-10` | `--color-khaki-100` | Borders on positive validation cards |
| `--color-quaternary-5` | `--color-khaki-50` | Surface of positive validation cards |

### Brand

| Token | Maps to | Usage |
|-------|---------|-------|
| `--color-brand-red` | `--color-red-500` | Brand red |
| `--color-brand-brown` | `--color-brown-500` | Brand brown |
| `--color-brand-khaki` | `--color-khaki-500` | Brand khaki |
| `--color-brand-mustard` | `--color-mustard-500` | Brand mustard |
| `--color-brand-pink` | `--color-pink-500` | Brand pink |
| `--color-brand-green` | `--color-khaki-500` | Alias for brand green (maps to khaki) |
| `--color-voloterra` | `#8EB300` | Voloterra sub-brand green |

### Basic

| Token | Value | Usage |
|-------|-------|-------|
| `--color-light` | `#FFFFFF` | White — surfaces, text on dark backgrounds |
| `--selection-color` | `var(--color-secondary)` | Text color for browser text selection |
| `--selection-bg` | `var(--color-secondary-15)` | Background for browser text selection |

### 3rd party

| Token | Value | Usage |
|-------|-------|-------|
| `--color-facebook` | `#1973BB` | Facebook brand |
| `--color-facebook-dark` | `#34589d` | Facebook brand (dark variant) |
| `--color-twitter` | `#65D7FF` | Twitter/X brand |
| `--color-google-plus` | `#D50049` | Google brand |
| `--color-trip-advisor` | `#00b384` | TripAdvisor brand |
| `--color-paypal` | `#009cde` | PayPal brand |
| `--color-paypal-hover` | `#008ac5` | PayPal hover state |
| `--color-instagram` | `#fd1d1d` | Instagram brand |
| `--color-apple` | `#000000` | Apple brand |
| `--color-aegean` | `#213368` | Aegean Airlines brand |

### SCSS usage example

```scss
:host {
  background-color: var(--color-primary);
  color: var(--color-light);

  &:hover {
    background-color: var(--color-primary-90);
  }

  &.is-disabled {
    color: var(--color-secondary-40);
    background-color: var(--color-secondary-10);
  }
}
```

---

## Spacing

CSS custom properties on `:root`. All values are multiples of 4px. Token naming follows `--size-{n}` (not `--space-{n}`). Do not use arbitrary pixel values — always pick the nearest token.

| Token | rem | px |
|-------|-----|----|
| `--size-0` | `0rem` | 0px |
| `--size-4` | `0.4rem` | 4px |
| `--size-8` | `0.8rem` | 8px |
| `--size-12` | `1.2rem` | 12px |
| `--size-16` | `1.6rem` | 16px |
| `--size-20` | `2rem` | 20px |
| `--size-24` | `2.4rem` | 24px |
| `--size-28` | `2.8rem` | 28px |
| `--size-32` | `3.2rem` | 32px |
| `--size-36` | `3.6rem` | 36px |
| `--size-40` | `4rem` | 40px |
| `--size-44` | `4.4rem` | 44px |
| `--size-48` | `4.8rem` | 48px |
| `--size-52` | `5.2rem` | 52px |
| `--size-56` | `5.6rem` | 56px |
| `--size-60` | `6rem` | 60px |
| `--size-64` | `6.4rem` | 64px |
| `--size-68` | `6.8rem` | 68px |
| `--size-72` | `7.2rem` | 72px |
| `--size-76` | `7.6rem` | 76px |
| `--size-80` | `8rem` | 80px |

### SCSS usage example

```scss
@use '../../../assets/scss/variables/breakpoints' as *;

:host {
  padding: var(--size-16);
  gap: var(--size-8);

  @media (min-width: $bp-md) {
    padding: var(--size-24);
  }
}
```

---

## Borders

### Shorthand border tokens

| Token | Resolved value |
|-------|---------------|
| `--border-solid` | `0.1rem solid var(--border-color)` |
| `--border-solid-light` | `0.1rem solid var(--border-color-light)` |
| `--border-solid-dark` | `0.1rem solid var(--border-color-dark)` |

### Border color tokens

| Token | Maps to | Usage |
|-------|---------|-------|
| `--border-color` | `var(--color-secondary-10)` | Default border — cards and containers |
| `--border-color-light` | `var(--color-secondary-5)` | Lightest border — most subtle separators |
| `--border-color-dark` | `var(--color-secondary-15)` | Darkest border — prominent dividers |

### Border radius tokens

| Token | Value | Usage |
|-------|-------|-------|
| `--border-radius-sm` | `0.2rem` (2px) | Tags, small badges |
| `--border-radius` | `0.4rem` (4px) | Default — inputs, cards, buttons |
| `--border-radius-lg` | `0.8rem` (8px) | Modals, panels, image thumbnails |

### SCSS usage example

```scss
:host {
  border: var(--border-solid-dark);
  border-radius: var(--border-radius);

  &.is-selected {
    border-color: var(--color-primary);
  }
}
```

---

## Shadows

| Token | CSS value | When to use |
|-------|-----------|-------------|
| `--shadow-light` | `0px 2px 6px rgba(69, 35, 37, 0.15)` | Default elevation — cards, dropdowns, floating panels at rest |
| `--shadow-light-upwards` | `0px -2px 6px rgba(69, 35, 37, 0.15)` | Panels that emerge from below — sticky footers, bottom sheets |
| `--shadow-dark` | `0px 2px 6px rgba(69, 35, 37, 0.5)` | Strong elevation — active state, modals, elements requiring emphasis |
| `--shadow-hover` | `0px 6px 8px var(--color-secondary-10)` | Interactive cards or buttons on hover — taller lift effect |

### SCSS usage example

```scss
:host {
  box-shadow: var(--shadow-light);
  transition: box-shadow 0.2s ease;

  &.is-clickable {
    @media (hover: hover) {
      &:hover {
        box-shadow: var(--shadow-hover);
      }
    }
  }
}
```

---

## Z-index

| Token | Value | Intended UI layer |
|-------|-------|-------------------|
| `--z-index-xs` | `-1` | Background decorative elements behind normal content |
| `--z-index-sm` | `1` | Slightly elevated elements — focused inputs, selected cards |
| `--z-index-md` | `5` | Floating elements within a component — dropdowns, tooltips, date pickers |
| `--z-index-lg` | `10` | Overlays covering page content — side drawers, full-screen search panels |
| `--z-index-xl` | `15` | Top-level UI layers — modals, notifications, cookie banners |

### SCSS usage example

```scss
:host {
  position: sticky;
  top: 0;
  z-index: var(--z-index-md);
}
```

---

## Typography

CSS custom properties on `:root`. Never hardcode font-family strings.

| Token | Font stack | When to use |
|-------|-----------|-------------|
| `--font-main` | `"Company-Sans", Helvetica, Arial, sans-serif` | All body text, labels, headings, UI copy — default for every component |
| `--font-main-condensed` | `"Company-Sans-Condensed", Helvetica, Arial, sans-serif` | Space-constrained contexts — seat labels, price cells, compact data tables |

Both stacks fall back to system sans-serif fonts if the custom webfonts fail to load.

### SCSS usage example

```scss
:host {
  font-family: var(--font-main);
  font-size: 1.4rem;
}

// Condensed for space-constrained contexts
:host {
  font-family: var(--font-main-condensed);
  font-size: 1rem;
}
```

---

## Breakpoints

These are **SCSS variables**, not CSS custom properties. They cannot be used with `var()` — they are compile-time only, available exclusively inside `@media` queries after importing the partial.

```scss
@use 'path/to/variables/breakpoints' as *;
```

| Variable | Value | Usage |
|----------|-------|-------|
| `$bp-2xs` | `320px` | Smallest supported viewport — very narrow phones |
| `$bp-xs` | `375px` | Standard small phone viewport |
| `$bp-sm` | `768px` | Tablet portrait and above — primary mobile-to-tablet transition |
| `$bp-md` | `992px` | Tablet landscape / small desktop — primary tablet-to-desktop transition |
| `$bp-lg` | `1224px` | Wide desktop — secondary desktop breakpoint |

`$bp-2xs` and `$bp-xs` are not grid tiers — they are available for component-level fine-tuning only. The grid systems (`l-grid-*`, `g-col-*`) use `xs`, `sm`, `md`, and `lg` as their four tiers.

Always use `min-width` (mobile-first) queries. Avoid `max-width` unless there is a documented reason.

### SCSS usage example

```scss
@use '../../../assets/scss/variables/breakpoints' as *;

:host {
  flex-direction: column;

  @media (min-width: $bp-md) {
    flex-direction: row;
  }
}
```
