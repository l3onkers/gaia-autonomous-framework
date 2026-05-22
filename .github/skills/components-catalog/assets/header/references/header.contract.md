# Header contract

**Selector:** `corp-header, [corp-header]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `fluidWrapper` | `boolean` | `false` | When `true`, the inner grid wrapper expands to full width using the `g-wrapper--fluid` modifier. |
| `size` | `Sizes` | (none) | Sets the header to compact layout. Use `size="sm"` for booking-flow pages with limited vertical space. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `[slot=leftButton]` | A single icon-only control for mobile navigation (e.g. back button or hamburger menu). Must include `aria-label`. |
| `[slot=title]` | Contextual page title displayed only on mobile (e.g. current booking step). Use `corp-title`. Hidden on desktop. |
| `[slot=mainMenu]` | Primary navigation component; use either `corp-menu-tab` for marketing pages or `company-breadcrumb` for booking flows. |
| `[slot=rightOption]` | Secondary controls such as search, login, or sign-up buttons. Multiple elements are spaced automatically. |

## Variants and states

**Size variants:**

- `size="sm"`: Compact header for booking flows. Reduces height to 6.4rem (desktop) and hides the strapline title. Default header is 9rem on mobile, 15.1rem on desktop.

**Wrapper modes:**

- Default: Content respects grid container width constraints.
- `fluidWrapper="true"`: Content spans full viewport width.

## CSS tokens

| Token | Default | sm | Purpose |
|-------|---------|----|---------|
| `--z-index-md` | `5` | — | Header stacking context on mobile (sticky positioning). |
| `--z-index-lg` | `10` | — | Header stacking context when login menu is hovered on desktop. |
| `--color-light` | `#FFFFFF` | — | Header background color. |
| `--color-secondary-15` | `#E3DEDE` | — | Border-bottom color on mobile. |
| `--color-secondary-40` | `#B5A7A8` | — | Right-side options text color. |
| `--color-tertiary` | `#9C850C` | — | Left button (icon) color. |
| `--color-secondary-10` | `#ECE9E9` | — | Menu item border color in user tooltip. |
| `--color-primary` | `#DD0D47` | — | Logout icon hover color. |
