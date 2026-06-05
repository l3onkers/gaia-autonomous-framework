# Popup contract

**Selector:** `corp-popup, [corp-popup]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `hasCloseButton` | `boolean` | `true` | Whether to render the built-in close button in the top-right corner. |
| `disableScroll` | `boolean` | `false` | When `true`, the inner panel does not scroll independently — the page (or parent) is responsible for scrolling. Use when the popup content must fill the full viewport height without an internal scrollbar. |

### Outputs

| Name | Payload | Description |
|------|---------|-------------|
| `popupClosed` | `void` | Emitted after the popup has been closed, whether by the close button or by calling `close()`. |

### Models

| Name | Type | Description |
|------|------|-------------|
| `isVisible` | `boolean` | Controls the popup visibility. Supports two-way binding: `[(isVisible)]="showPopup"`. Default is `false`. |

## Slots

| Selector | Purpose |
|----------|---------|
| `company-feedback-bar, [company-feedback-bar]` | Optional feedback bar projected above the popup inner panel for displaying contextual alerts. |
| (default `ng-content`) | Main scrollable content area inside the popup. |
| `corp-popup-header, [corp-popup-header]` | Header section for title, icon, and descriptive text. |
| `corp-popup-content, [corp-popup-content]` | Content area container for the main scrollable content. |
| `corp-popup-footer, [corp-popup-footer]` | Sticky footer area for action buttons and secondary controls. |

## Variants and states

- **Size:** `sm` (60rem width on desktop) — default is full width (80.8rem).
- **Visibility:** Controlled via `isVisible` model. When `true`, displays the popup; when `false`, hides it off-screen.
- **Scroll behavior:** Controlled via `disableScroll` input. When `false` (default), the inner panel scrolls independently. When `true`, scrolling is disabled on the inner panel.

## CSS tokens

| Token | Default Value | Purpose |
|-------|---|---------|
| `--color-secondary` | `var(--color-brown-500)` | Overlay backdrop color. |
| `--color-light` | `#FFFFFF` | Background color of the popup panel and inner sections. |
| `--color-primary` | `var(--color-red-500)` | Icon color inside `corp-popup-header`. |
| `--color-secondary-60` | `var(--color-brown-400)` | Close button icon color. |
| `--z-index-xl` | `15` | Z-index for visible popup overlay. |
| `--z-index-sm` | `1` | Z-index for sticky close bar and footer. |
| `--border-radius` | `0.4rem` | Border radius of the popup panel (desktop only). |

## Programmatic control

The component exposes two public methods:

- `open()` — Opens the popup (equivalent to setting `isVisible` to `true`).
- `close()` — Closes the popup and emits `popupClosed` (equivalent to setting `isVisible` to `false`).

## Content projection with close triggers

Any element inside the popup can be marked with the template reference `#popupClose` to automatically close the popup when clicked.
