# Icon documentation

Icons are visual representations of actions, objects, or concepts. They enhance the user experience by providing visual cues that complement or reinforce meaning.

## Best practices

- Convey meaning clearly and consistently across the interface for the same actions or concepts.
- Accompany an icon with a text label when its meaning is not immediately obvious to all users.
- Use `isRotate` to animate a rotation, useful for loading indicators or toggle states.
- Use `dynamicAxe` when the icon has a non-square aspect ratio and needs to scale proportionally on a specific axis. Set it to `width` when the icon is wider than tall, and to `height` when it is taller than wide.
- Prefer `font-size` (or a size variant) on the host to control the icon size — the SVG scales with `1em`.
- Avoid nesting interactive elements inside an icon. The icon is presentational; interactivity belongs to its parent.

### Icon vs. icon button

`corp-icon` is a presentational component. When an icon must be interactive, wrap it in a `<button corp-rounded-button>` or `<button corp-text-button>` rather than adding click handlers directly to the icon host.

## Content guidelines

Icons should communicate a single concept at a glance. Follow these rules when selecting or requesting icons:

- Use icons from the existing sprite. Do not introduce one-off inline SVGs.
- Choose an icon whose visual metaphor matches the action or concept it represents — avoid repurposing icons for unrelated meanings.
- When an icon is the sole indicator of an action (no accompanying label), confirm that its meaning is unambiguous to all users, including those unfamiliar with the product.
- Keep the icon label (if any) short — a single word or very short phrase. Icons paired with long strings lose their visual efficiency.

## Related components

- **Badge** — can be projected into the icon via `ng-content` to display a numeric indicator on top of the icon.

## Accessibility

This component has known accessibility problems. See the accessibility issues page before using in production.

- Decorative icons must have `aria-hidden="true"` applied to the host element so screen readers skip them entirely.
- When an icon conveys meaning without accompanying visible text, add `aria-label` to the host element to provide an accessible name for assistive technology.
- When the icon is the only content inside an interactive element (e.g. a button), add the accessible name on the interactive parent, not on the icon host.
- Color contrast between the icon and its background is the consumer's responsibility. Use color tokens and verify that the combination meets at least WCAG AA (3:1 for graphical objects, 4.5:1 for text-sized icons).
- The `iconColor` input overrides the inherited color. When using it, verify that the resulting contrast against the background still meets WCAG AA.
- When used inside interactive elements (buttons, links), focus management is handled by the parent — ensure the parent has a visible focus style.

## Usage examples

### Default

```html
<i corp-icon [(icon)]="'logo'" [iconColor]="'#E10E49'">
	<p corp-badge>2</p>
</i>
```

### Size variants

```html
<!-- Extra small -->
<i corp-icon [(icon)]="'arrow-down'" variant="xs"></i>

<!-- Small -->
<i corp-icon [(icon)]="'arrow-down'" variant="sm"></i>

<!-- Large -->
<i corp-icon [(icon)]="'arrow-down'" variant="lg"></i>

<!-- Extra large -->
<i corp-icon [(icon)]="'arrow-down'" variant="xl"></i>

<!-- 2XL -->
<i corp-icon [(icon)]="'arrow-down'" variant="2xl"></i>
```

### Rotation animation

```html
<i corp-icon [(icon)]="'spinner'" [isRotate]="true"></i>
```

### Dynamic aspect ratio

```html
<!-- Icon wider than tall: scale width proportionally, maintain height -->
<i corp-icon [(icon)]="'eurowings'" dynamicAxe="width"></i>

<!-- Icon taller than wide: maintain width, scale height proportionally -->
<i corp-icon [(icon)]="'arrow-long'" dynamicAxe="height"></i>
```

### With vertical alignment

```html
<span>
	<i corp-icon [(icon)]="'check'" variant="vmiddle"></i>
	Icon is aligned to middle of text
</span>
```

### Decorative icon (accessibility)

```html
<!-- Icon is purely decorative; screen readers skip it -->
<i corp-icon [(icon)]="'decorative-pattern'" aria-hidden="true"></i>
```

### Meaningful icon (accessibility)

```html
<!-- Icon conveys meaning; provide accessible name -->
<i corp-icon [(icon)]="'checkmark'" aria-label="Payment successful"></i>
```

### Icon with circle background

```html
<!-- Icon scaled to 50% with circle background styling -->
<i corp-icon [(icon)]="'airplane'" variant="circle"></i>
```
