# Table Filter List accessibility issues

The following issues were identified during a WCAG 2.2 audit of this component. They remain unresolved and must be addressed before using this component in production.

---

## 1. Two unnamed `<section>` elements inside the template

**File:** `table-filter-list.component.html`, lines 3 and 7
**WCAG:** 1.3.6 Identify Purpose (Level AAA) / 4.1.2 Name, Role, Value (Level A)

The component template renders two `<section corp-card-content>` elements. A `<section>` carries an implicit `region` landmark role. When multiple unnamed `region` landmarks appear on the page, screen readers cannot distinguish between them, violating the requirement that landmarks with the same role be uniquely named.

The consumer cannot add `aria-label` to these sections because they live inside the component's own template, not in the consumer's markup.

**Recommendation:** Add `aria-label` attributes directly in the template to differentiate the two sections (e.g. `aria-label="Filter search"` and `aria-label="Filter actions"`). Alternatively, replace `<section>` with `<div>` if the content does not semantically constitute a named landmark region.

---

## 2. No `id` on the host element — `aria-controls` cannot be wired up

**File:** `table-filter-list.component.ts`
**WCAG:** 4.1.2 Name, Role, Value (Level A)

The trigger button that opens and closes the panel (rendered by the consumer in the parent template) must use `aria-controls` to reference this panel. Because the component's host element has no `id` and the component does not expose one as an input or output, the consumer has no reliable way to form this association.

**Recommendation:** Expose a `panelId` input (`input<string>()`) and bind it as `[attr.id]="panelId()"` on the host (or on a wrapper element). Document that consumers must pass a unique ID and use the same value as the `aria-controls` attribute on their trigger button.

---

## 3. Trigger button has no programmatic connection for `aria-expanded`

**File:** `table-filter-list.component.ts` — `isOpen` model
**WCAG:** 4.1.2 Name, Role, Value (Level A)

The component manages its own open/closed state via the `isOpen` model, but it does not expose any signal or event that the consumer can use to keep `aria-expanded` on the trigger button in sync automatically. The consumer must manually bind `[attr.aria-expanded]="isOpen()"` on their button, and this is not documented.

**Recommendation:** Document clearly that the consumer's trigger button must set `[attr.aria-expanded]="isOpen()"` (using the same `isOpen` model reference passed to the component). Consider whether the component should provide a helper or a dedicated trigger directive in the future.

---

## 4. No focus management when the panel opens

**File:** `table-filter-list.component.ts`, `table-filter-list.component.scss`
**WCAG:** 2.4.3 Focus Order (Level A)

When `isOpen` changes from `false` to `true`, the panel becomes visible by switching from `display: none` to `display: block`. Focus remains on the trigger button. Keyboard users must Tab through the page to reach the filter panel content, which may traverse many intervening elements depending on the DOM order.

**Recommendation:** After `isOpen` becomes `true`, programmatically move focus to the first focusable element inside the panel (the projected `<input>` inside `corp-input-text`, if present, or the first checkbox). This can be done in the component by watching the `isOpen` model and calling `.focus()` on the first focusable descendant inside `elementRef.nativeElement`.

---

## 5. `<article>` landmark used for a filter dropdown panel

**File:** `table-filter-list.component.html`, line 2
**WCAG:** 1.3.1 Info and Relationships (Level A)

The template renders `<article corp-card>`. An `<article>` element carries an implicit landmark role of `article`, which semantically represents self-contained, independently distributable content (such as a blog post or news item). A transient filter panel is not an article. Screen readers will announce the landmark type to users, creating a misleading structural signal.

**Recommendation:** Change the host element of `CardComponent` used inside this template from `<article>` to `<div>`, or pass a variant/attribute that renders it without the `<article>` wrapper. If the card component cannot be changed, wrap the projected content in a `<div role="group" aria-label="Filters">` instead.
