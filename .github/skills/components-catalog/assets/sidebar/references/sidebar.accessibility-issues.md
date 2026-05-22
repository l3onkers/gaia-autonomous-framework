# Sidebar — Accessibility Issues

These are known accessibility issues pending resolution. Once fixed, this page will be removed and the fixes documented in the main Accessibility section.

## Issue 1 — Incorrect ARIA role: `toolbar` used instead of `navigation`

**File:** `sidebar.ts`, `host` metadata, line 16
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

The host element is assigned `role="toolbar"`. The `toolbar` role is semantically reserved for a container of controls that operate on document content (e.g. a text-formatting toolbar). A vertical navigation panel should carry `role="navigation"` so that assistive technologies expose it as a navigation landmark and allow users to jump to it directly.

**Recommendation:** Change `role: 'toolbar'` to `role: 'navigation'` in the component's `host` metadata. Alternatively, guide consumers to use a `<nav>` element as the host via the `[corp-sidebar]` attribute selector, which provides the `navigation` landmark natively without requiring an explicit role.

---

## Issue 2 — Navigation landmark has no accessible label

**File:** `sidebar.ts`, `sidebar.html`
**WCAG criterion:** 2.4.6 Headings and Labels (Level AA) / 1.3.1 Info and Relationships (Level A)

When a page contains more than one navigation landmark, each must have a distinguishing label so screen reader users can tell them apart from the landmarks list. The component currently provides no mechanism for the consumer to supply an `aria-label` or `aria-labelledby` for the landmark.

**Recommendation:** Add an `ariaLabel = input<string>()` input and bind it to the host: `'[attr.aria-label]': 'ariaLabel()'`. Document that the consumer must supply a meaningful, translated label (e.g. `"Main navigation"`).

---

## Issue 3 — No mobile-accessible alternative documented for `display: none` at small viewports

**File:** `sidebar.scss`, lines 3–7
**WCAG criterion:** 2.1.1 Keyboard (Level A)

Below the `$bp-md` breakpoint the sidebar is hidden with `display: none`, which correctly removes it from both the visual layout and the accessibility tree. However, because the sidebar is the sole navigation structure for the component, mobile users (keyboard and screen reader alike) lose access to navigation entirely unless the consuming page provides an alternative. This architectural gap is not documented, making it easy for consumers to ship an inaccessible mobile experience.

**Recommendation:** Document in the MDX and in JSDoc that `SidebarComponent` is a desktop-only element. The consumer is responsible for providing an equivalent navigation for mobile viewports (e.g. `MobileMenuComponent` or `DrawerComponent`).

---

## Issue 4 — `logo` and `title` inputs are declared but never used in the template

**File:** `sidebar.ts`, lines 27–28
**WCAG criterion:** 4.1.2 Name, Role, Value (Level A)

The `logo` and `title` inputs exist on the class but are not referenced anywhere in the template. The template relies exclusively on `ng-content` slots to project the icon and title. Consumers reading the API surface may pass these inputs expecting rendered output that never appears, resulting in a confusing and potentially broken experience.

**Recommendation:** Remove the unused `logo` and `title` inputs from the component class. If they are intended for future use, they should remain undocumented until implemented. If they were meant to provide default content, the template must be updated to render them.
