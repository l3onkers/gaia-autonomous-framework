# Sidebar documentation

`SidebarComponent` is a vertical navigation panel intended for desktop layouts. It groups a header area (logo and title) with a primary navigation menu, providing a persistent landmark that lets users move between sections of a dashboard or admin interface.

## Best practices

- Use `SidebarComponent` for persistent, desktop-only navigation in dashboard or back-office layouts where a dedicated vertical rail is appropriate.
- Always project a `corp-menu` with `variant="vertical"` into the default slot so menu items receive the correct sidebar styling.
- Project the logo and application title through the `corp-icon` and `corp-title` ng-content slots — the `logo` and `title` inputs are not currently wired to the template.
- Use the `[corp-sidebar]` attribute selector on a `<nav>` element rather than the element selector when possible, so the host carries the `navigation` landmark natively.
- Always pair `SidebarComponent` with a mobile navigation alternative (e.g. `MobileMenuComponent`) because the sidebar is hidden via `display: none` on viewports below `$bp-md`. Failing to do so leaves mobile users without access to navigation.
- Limit the sidebar to a single level of navigation. Deeply nested structures belong in a secondary menu layer, not inside the sidebar itself.

### Sidebar vs. other navigation controls

Use `SidebarComponent` when the navigation is persistent and vertically oriented alongside page content on desktop. For horizontal navigation at the top of the page, use `MenuComponent` with a horizontal variant. For mobile or overlay navigation, use `MobileMenuComponent` or a `DrawerComponent` pattern instead.

## Content guidelines

Keep sidebar content concise and scannable. Each menu item label should describe its destination clearly so users can navigate without reading surrounding context.

- Use short, action-neutral nouns or noun phrases for menu item labels (e.g. "Flights", "Your booking", "Discover") — avoid verbs like "Go to flights".
- The application name projected into the header should match the name used in the page `<title>` and other navigational landmarks.
- Icons paired with menu items should reinforce the label's meaning, not substitute it — always include a visible text label alongside each icon.
- Avoid truncating menu item labels. If a label is too long, shorten the text rather than clipping it with ellipsis.

## Related components

- **Menu** — projected into the sidebar body to render the vertical list of navigation items.
- **Menu Item** — individual navigable items inside the projected menu.
- **Icon** — projected into the sidebar header to display the application logo.
- **Title** — projected into the sidebar header to display the application name.

## Accessibility

This component has known accessibility issues. See the Accessibility Issues page before using in production.

- The component sets `role="toolbar"` on the host, which is semantically incorrect for a navigation panel. Until this is fixed, use the `[corp-sidebar]` attribute selector on a native `<nav>` element to provide the correct `navigation` landmark without an explicit ARIA role.
- The navigation landmark has no label. When more than one navigation landmark exists on a page, add `aria-label` directly to the host element (e.g. `<nav corp-sidebar aria-label="Main navigation">`). Translate this label to match the application's language.
- The sidebar is hidden with `display: none` on viewports narrower than `$bp-md`. `display: none` correctly removes it from the accessibility tree, but you must provide an equivalent navigation for mobile users (keyboard and screen reader alike). Use `MobileMenuComponent` or a comparable pattern on small viewports.
- Decorative icons projected via `ng-content` that duplicate the adjacent text label should receive `aria-hidden="true"` to avoid redundant announcements by screen readers.
- When a menu item represents the currently active page, add `aria-current="page"` to that `corp-menu-item` host element. The component itself does not set this attribute.
