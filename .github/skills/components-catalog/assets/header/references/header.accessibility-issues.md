# Header — Accessibility Issues

This page tracks known accessibility problems in the `HeaderComponent` that require action before this component is used in production.

---

## Issue 1 — Navigation landmark has no accessible name

**File:** `header.component.html`, line 9
**WCAG criterion:** 2.4.1 Bypass Blocks (Level A)

**Problem:** The `<nav>` element wrapping the main menu slot has no `aria-label` or `aria-labelledby`. When a page contains multiple navigation landmarks (e.g. main menu and breadcrumb), screen readers list them by name. Without a label, both landmarks are announced as "navigation" with no way to distinguish them.

**Recommendation:** Expose a `mainMenuAriaLabel` input (e.g. `input<string>('Main navigation')`) and bind it to the `<nav>` element with `[attr.aria-label]="mainMenuAriaLabel()"`. Provide a translatable default value and document that consumers must translate it.

---

## Issue 2 — Logo hidden on mobile removes home navigation from the accessibility tree

**File:** `header.component.scss`, lines 55–58
**WCAG criterion:** 1.3.1 Info and Relationships (Level A), 2.4.1 Bypass Blocks (Level A)

**Problem:** The CSS rule `::ng-deep .c-logo { display: none; }` hides the logo (and its projected home link) on small screens. `display: none` removes the element from the accessibility tree entirely. On mobile viewports, users who rely on assistive technology have no access to the home navigation link that is visible on desktop.

**Recommendation:** Ensure a home navigation link is always reachable, regardless of viewport. Options include: (a) making the logo always visible on mobile with a smaller size, (b) duplicating the home link in the `[slot=leftButton]` area, or (c) providing a visually hidden skip-to-home link. Document which slot the consumer should use for mobile home navigation.

---

## Issue 3 — Icon-only projected controls lack enforced accessible names

**File:** `header.component.html`, slots `[slot=leftButton]` and `[slot=rightOption]`
**WCAG criterion:** 1.1.1 Non-text Content (Level A), 4.1.2 Name, Role, Value (Level A)

**Problem:** Both slots accept arbitrary content including icon-only buttons (as shown in the Default and BookingFlow stories). The component has no mechanism to enforce accessible names. The Default story projects a `<button>` containing only a `<corp-icon>` with no `aria-label`, and two `<corp-text-button>` elements containing only icons with no accessible label text. These controls are announced without a name by screen readers.

**Recommendation:** In the component documentation, explicitly require consumers to add `aria-label` to every icon-only control projected into `[slot=leftButton]` and `[slot=rightOption]`. Update the stories to demonstrate this with concrete `aria-label` values (e.g. `aria-label="Open menu"`, `aria-label="Search"`, `aria-label="Log in"`).
