# Popin contract

**Selector:** `corp-popin, [corp-popin]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `isVisible` | `boolean` | `false` | Whether the popin is visible. When `true`, adds `is-visible` to the host and calls `showModal()` if the host is a `<dialog>`. |
| `isSticky` | `boolean` | `false` | Whether the popin header is sticky on scroll. When `true`, adds `is-sticky` to the host. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `popinClosed` | `Event` | Emitted when the popin is closed, either via the internal close button or by calling `close()` programmatically. |
| `scrolled` | `Event` | Emitted on every scroll event on the popin host. Useful for implementing scroll-aware behaviour (e.g. sticky sub-headers). |

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `[slot=popinBackButton]` | Optional back button for mobile navigation; hidden on medium breakpoints and above. Use with `corp-text-button` element. |
| `corp-logo, [corp-logo]` | Logo component projected into the header; displayed only on desktop within the sticky header. |
| `[slot=popinTitle]` | Title content projected into the sticky header. Expected to receive a heading element. |
| (default) | Main content area below the header. |

## Variants and states

| Variant | Values | Description |
|---------|--------|-------------|
| `gray` | `gray` | Applies gray background to the header (`var(--color-secondary-5)` instead of `var(--color-light)`). |

**State classes:**
- `is-visible` — Applied when `isVisible = true`
- `is-sticky` — Applied when `isSticky = true`

## CSS tokens

| Token | Purpose |
|-------|---------|
| `--color-secondary-5` | Background color of the popin body. |
| `--color-light` | Default background color of the sticky header; overridden by `gray` variant. |
| `--color-secondary-15` | Border color of the header bottom border. |
| `--color-tertiary` | Color of the back button and close button icons. |
| `--z-index-xl` | Z-index when popin is visible (15); stacks above all other content. |
| `--z-index-sm` | Z-index of the sticky header and sticky sub-headers (1). |
| `--z-index-md` | Z-index of the sticky header when `isSticky = true` on desktop (5). |

## Methods (public)

| Name | Parameters | Returns | Description |
|------|-----------|---------|-------------|
| `open()` | — | `void` | Opens the popin programmatically. Calls `showModal()` when the host is a `<dialog>`; otherwise adds `is-popin-open` to `document.body`. |
| `close(event?)` | `event?: Event` | `void` | Closes the popin programmatically and emits `popinClosed`. Calls `close()` on the native `<dialog>` when the host is one; otherwise removes `is-popin-open` from `document.body`. |
| `getElementRef()` | — | `HTMLElement` | Returns the native host element. Useful when the consumer needs to integrate the popin with a third-party focus-trap or animation library. |

## Content children

| Name | Selector | Descendants | Type | Description |
|------|----------|------------|------|-------------|
| `closers` | `popinClose` | `true` | `ElementRef` | Elements marked with the `popinClose` directive. Clicks on these elements automatically trigger `close()`. |
