# Feedback Box contract

**Selector:** `company-feedback-box, [company-feedback-box]`

## API

### Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `variant` | `'success' \| 'info' \| 'alert' \| 'section'` | `undefined` | Visual style variant to convey message type or context. |
| `size` | `'lg'` | `undefined` | Optional size variant for the feedback box. |

### Outputs

None.

### Models

None.

## Slots

| Selector | Purpose |
|----------|---------|
| `corp-icon, [corp-icon]` | Icon projected at the start of the feedback box to provide visual context for the message. |
| (unnamed) | Main content area where text, links, and other elements are projected. |

## Variants and states

**Variants:** `success`, `info`, `alert`, `section` (set via `variant` input)

**Sizes:** `lg` (set via `size` input; default is implicit smaller size)

- `success` — Green-tinted feedback box for confirmations and positive messages.
- `info` — Dark blue background with light text for informational messages.
- `alert` — Red-tinted feedback box for warnings or error messages.
- `section` — White card-style box with border and light shadow for standalone contextual blocks.

## CSS tokens

| Token | Default | lg | variant override | Purpose |
|-------|---------|-----|------------------|---------|
| `--gap` | `0.8rem` | `1.6rem` | — | Spacing between icon and content. |
| `--border-radius` | `0.4rem` | — | — | Corner radius for the feedback box. |
| `--color-secondary-10` | (theme variable) | — | — | Default background color (light brown). |
| `--color-secondary-60` | (theme variable) | — | — | Default text color (medium brown). |
| `--color-tertiary-5` | (theme variable) | — | `success` | Background for success variant (light mustard). |
| `--color-tertiary` | (theme variable) | — | `success` | Text color for success variant (mustard). |
| `--color-secondary` | (theme variable) | — | `info` | Background for info variant (dark brown). |
| `--color-light` | `#FFFFFF` | — | `info` | Text color for info variant (white). |
| `--color-primary-5` | (theme variable) | — | `alert` | Background for alert variant (light red). |
| `--color-primary` | (theme variable) | — | `alert` | Text color for alert variant (red). |
| `--color-light` | `#FFFFFF` | — | `section` | Background for section variant (white). |
| `--shadow-light` | `0px 2px 6px rgba(69, 35, 37, 0.15)` | — | `section` | Shadow for section variant. |
| `--color-secondary-15` | (theme variable) | — | `section` | Border color for section variant (light brown). |
| `--color-quaternary` | (theme variable) | — | link hover | Link hover color in section and light variants. |
