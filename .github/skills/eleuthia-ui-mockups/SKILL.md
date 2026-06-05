---
name: eleuthia-ui-mockups
description: Layout patterns and HTML composition guidelines for building views with the corporate component library. Based on analysis of real mockup templates.
---
> These are reference examples extracted from real mockup templates â€” use them as a starting point, not as exact recipes.
> For component APIs and inputs, see: `../eleuthia-ui-components/SKILL.md`
> For utility classes, grid systems, and design tokens, see: `../eleuthia-ui-styles/SKILL.md`

## Common

### Popup

**Structure:**

```html
<!-- Form popup variant: uses <form> as the host element -->
<form corp-popup>
  <header corp-popup-header alignment="left">
    <h1 corp-title>Dialog title</h1>
  </header>
  <section corp-popup-content class="u-flex is-column is-ai-s u-gap-16">
    <fieldset class="u-flex is-column is-ai-s u-gap-8 || u-m-0">
      <p corp-body-text size="sm">Field label</p>
      <corp-input-text>
        <input type="text" name="..." placeholder="...">
      </corp-input-text>
    </fieldset>
    <!-- repeat fieldsets as needed -->
  </section>
  <footer corp-popup-footer class="u-flex u-gap-16">
    <button type="button" corp-button size="sm" variant="secondary">Cancel</button>
    <button type="submit" corp-button size="sm">Primary action</button>
  </footer>
</form>

<!-- Confirmation popup variant: uses <article> as the host element -->
<article corp-popup>
  <header corp-popup-header>
    <corp-icon corp-popup-icon icon="warning" size="xl"></corp-icon>
    <h1 corp-title>Confirmation title</h1>
  </header>
  <section corp-popup-content>
    <p corp-body-text size="sm">Are you sure you want to proceed?</p>
  </section>
  <footer corp-popup-footer class="u-flex u-gap-16">
    <button type="button" corp-button size="sm" variant="secondary">Cancel</button>
    <button corp-button size="sm">Confirm action</button>
  </footer>
</article>

<!-- Info popup variant: uses <article> as the host element -->
<article corp-popup>
  <header corp-popup-header>
    <corp-icon icon="pet" size="xl"></corp-icon>
    <h1 corp-title>Popup title</h1>
  </header>
  <main corp-popup-content>
    <h2 corp-subtitle size="xs">Initial description</h2>
    <ul corp-simple-list>
      <li corp-simple-list-item>
        <p corp-body-text size="sm">List item</p>
      </li>
      <!-- repeat for each item -->
    </ul>
    <p corp-body-text size="sm">Body text paragraph.</p>
    <p corp-body-text size="sm">
      For more information, see the <a>Conditions of Carriage regarding pets</a>.
    </p>
  </main>
  <footer corp-popup-footer>
    <button corp-button size="responsive">Ok, got it!</button>
  </footer>
</article>
```

**Variations:** Form popups use `<form corp-popup>` with `alignment="left"` on the header and no icon. Confirmation popups use `<article corp-popup>` with `corp-icon[corp-popup-icon]` centered in the header. Info popups use `<main corp-popup-content>` and a single close button. Multiple popups can be chained in the same template (one form + one or more confirmation popups triggered sequentially).

---

## Corporate - Kratos

### Main layout

**Structure:**

```html
<main class="g-wrapper g-wrapper--fluid || u-m-0">
  <div class="g-row">
    <div class="g-col || u-flex is-ai-fs u-gap-32 || u-pr-0">
      <aside corp-sidebar>
        <!-- Sidebar â€” see Pattern: Sidebar -->
      </aside>

      <article corp-card variant="no-shadows" class="u-m-block-32 is-flex-1" size="xs">
        <!-- Page card sections: header, filter toolbar, data table -->
      </article>
    </div>
  </div>
</main>
```

**Variations:** The `<article corp-card>` carries `is-flex-1` to fill the remaining width after the sidebar. `g-wrapper--fluid` removes the max-width constraint.

---

### Sidebar

**Structure:**

```html
<aside corp-sidebar>
  <i corp-icon size="sm" icon="logo-diamond"></i>
  <p corp-title size="2xs" class="u-flex is-column u-gap-4">
    <span>SECTION NAME</span>
    <span>DASHBOARD</span>
  </p>
  <corp-menu variant="vertical">
    <button corp-menu-item>
      <i corp-icon icon="home"></i>
      Nav item label
    </button>
    <!-- repeat for each nav item -->
  </corp-menu>
</aside>
```

---

### Page card header with title and optional view-mode toggle

**Structure:**

```html
<header corp-card-content class="u-flex">
  <section>
    <h1 corp-title size="sm">Page title</h1>
    <p corp-body-text class="u-mt-4" size="sm">Subtitle or timestamp</p>
  </section>
  <!-- present only on pages with a graph toggle -->
  <section class="u-flex__right">
    <corp-input-checkbox variant="switch">
      <input type="checkbox" id="..." name="..." />
      <p>Change view mode</p>
    </corp-input-checkbox>
  </section>
</header>
```

**Variations:** The right `<section class="u-flex__right">` is omitted on pages that do not have a graph/table toggle.

---

### Filter toolbar: search input + action buttons

**Structure:**

```html
<section corp-card-content class="l-grid-wrapper u-gap-16">
  <div class="l-grid-col-xs-4 l-grid-col-md-6 l-grid-col-lg-7 l-grid-col-xl-8 || u-flex u-gap-16 || u-zi-sm">
    <corp-input-text>
      <input type="text" id="search" name="search">
    </corp-input-text>
    <!-- optional: company-input-calendar for date range -->
  </div>
  <div class="l-grid-col-xs-8 l-grid-col-md-6 l-grid-col-lg-5 l-grid-col-xl-4">
    <div class="u-flex u-gap-16 is-flex-1">
      <button corp-button variant="tertiary" size="sm">Action button 1</button>
      <button corp-button variant="tertiary" size="sm">Action button 2</button>
    </div>
  </div>
</section>
```

**Variations:** The left column can include a `company-input-calendar` alongside the search input for date range filtering. Button labels vary by page (e.g. "Export", "Customize columns", "Add exception").

---

### Data table with inline column-filter dropdowns and paginator

**Structure:**

```html
<section corp-card-content>
  <div corp-card variant="no-shadows">
    <corp-table>
      <corp-table-row slot="head">
        <th>
          <div class="u-flex u-gap-8">
            <button corp-text-button size="xs" variant="quaternary">
              <i corp-icon icon="arrow-large-up" size="xs"></i>
            </button>
            <p app-subtitle>Column label</p>
            <!-- optional: filter trigger button -->
            <button corp-text-button icon="filters-lined-bold" size="xs"></button>

            <!-- optional: inline floating filter dropdown -->
            <article corp-table-filter-list>
              <corp-input-text>
                <i corp-icon icon="search-bold"></i>
                <input type="text" placeholder="Search..." autocomplete="off" />
                <button corp-text-button>
                  <i corp-icon icon="clear"></i>
                </button>
              </corp-input-text>

              <corp-input-checkbox>
                <input type="checkbox" value="1" id="option1" name="option1" />
                <div class="u-flex u-gap-4 is-wrap">
                  <corp-badge></corp-badge>
                  <p corp-body-text size="xs" class="u-ellipsis">Option label</p>
                  <p corp-body-text size="2xs" class="u-flex__right">1</p>
                </div>
              </corp-input-checkbox>
              <!-- repeat for each filter option -->

              <button corp-text-button>
                <i corp-icon icon="clear"></i> Clear filters
              </button>
            </article>
          </div>
        </th>
        <!-- repeat for each column -->
      </corp-table-row>

      <corp-table-row slot="body">
        <td corp-tooltip-wrapper>
          <p class="u-ellipsis">Cell content</p>
          <corp-tooltip size="sm" variant="dark">Tooltip text</corp-tooltip>
        </td>
        <!-- repeat for each cell -->
      </corp-table-row>
      <!-- repeat for each row -->

      <p corp-body-text size="sm" slot="totalLabel">Showing 12 of 120</p>
      <corp-paginator variant="simple"></corp-paginator>
    </corp-table>
  </div>
</section>
```

**Variations:** `corp-table-filter-list` accepts a `position` attribute to control dropdown anchor alignment. Columns without filters omit the trigger button and `corp-table-filter-list` entirely. The paginator can be omitted for tables that render all rows without paging.
