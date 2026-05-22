# HeaderComponent documentation

HeaderComponent is the top-level page header for Company's web application. It provides a sticky or static navigation bar with named content slots for the logo, left action button, main navigation menu, page title, and right-side options.

## Best practices

- Always use a native `<header>` element as the host (e.g. `<header corp-header>`). This ensures the correct `banner` landmark role is applied and improves page structure for screen readers.
- Use the `size="sm"` variant for booking-flow pages where vertical space is limited. This reduces the header height and hides the strapline title.
- Project the Company logo via `<a corp-logo>` into the default slot. Wrap it in an anchor so it functions as a home navigation link.
- Use `[slot=leftButton]` only for a single icon-only control (typically a back button or hamburger menu trigger on mobile). Always provide an `aria-label` on the projected button.
- Use `[slot=mainMenu]` for the primary navigation component — either `corp-menu-tab` for the full marketing header or `company-breadcrumb` for the booking flow.
- Use `[slot=rightOption]` for secondary controls such as search, login, or sign-up. Multiple elements can be projected into this slot; they are spaced automatically.
- Use `[slot=title]` together with `corp-title` to show a contextual page title on mobile (e.g. the current booking step). This slot is hidden on desktop and should only contain short, single-line text.
- Set `[fluidWrapper]="true"` only when the header must span the full viewport width, ignoring the standard grid container constraints.

### HeaderComponent vs. other page layout controls

The `HeaderComponent` is intended for the main page-level navigation bar. It is not a card header, section header, or dialog title bar. For those use cases, use typography components (`corp-title`, `corp-subtitle`) directly.

## Content guidelines

Content projected into the header must be concise and action-oriented. Users rely on the header to orient themselves and navigate efficiently.

- Keep navigation labels short: one or two words per menu item. Avoid full sentences.
- The `[slot=title]` text appears only on mobile; keep it to a single line. Use uppercase or sentence case consistently across all pages.
- Do not project decorative or informational copy into the header. All projected content should be interactive or provide structural orientation.
- Right-side option labels (login, sign-up) must be consistent with the rest of the application in terms of terminology and capitalisation.
- Image `alt` attributes on any logo or icon content projected from the consumer must be meaningful or empty (`alt=""`) if the surrounding link already provides an accessible label.

## Related components

- **corp-logo** — projected into the default slot to render the Company wordmark and optional strapline.
- **corp-title** — projected into `[slot=title]` to display the current page title on mobile.

## Accessibility

Use a native `<header>` element as the host. The `<header>` element carries the implicit `banner` landmark role, which allows screen reader users to navigate directly to the page header.

The `<nav>` element wrapping `[slot=mainMenu]` currently has no `aria-label`. If the page contains more than one navigation landmark (e.g. breadcrumb, footer nav), each must have a distinct label. A `mainMenuAriaLabel` input is the recommended fix.

Add `aria-label` to every icon-only control projected into `[slot=leftButton]` and `[slot=rightOption]`. An icon alone provides no accessible name. Examples: `aria-label="Open menu"` for a hamburger button, `aria-label="Search"` for a search icon, `aria-label="Log in"` for a user icon.

On mobile, the logo (and its home navigation link) is hidden via `display: none` by the component's CSS. This removes the home link from the accessibility tree on small screens. Ensure the `[slot=leftButton]` or another always-visible element provides equivalent navigation to the home page.

The main navigation menu (`[slot=mainMenu]`) is hidden on small screens with `display: none`. Ensure the mobile navigation (typically triggered by the `[slot=leftButton]` control) is fully accessible and provides equivalent navigation options.

When projecting `<corp-icon>` elements as purely decorative content inside controls, add `aria-hidden="true"` to each icon so screen readers do not announce icon names.

## Usage examples

### Default

```html
<header corp-header>
	<button
		slot="leftButton"
		type="button"
		aria-label="Open menu"
	>
		<corp-icon icon="menu-bold" size="sm"></corp-icon>
	</button>

	<a corp-logo>
		<p app-subtitle>
			YOUR AWESOME TAGLINE HERE
		</p>
	</a>

	<nav corp-menu-tab slot="mainMenu">
		<a corp-menu-item routerLink="#1" [isSelected]="true">
			Vuelos
		</a>
		<a corp-menu-item routerLink="#2">
			Tu reserva
		</a>
	</nav>

	<corp-text-button
		slot="rightOption"
		iconAlignment="right"
		aria-label="Search"
	>
		<i corp-icon icon="search-bold"></i>
	</corp-text-button>

	<corp-text-button
		slot="rightOption"
		iconAlignment="right"
		aria-label="Log in"
	>
		<i corp-icon icon="user-bold"></i>
		Log in
	</corp-text-button>
</header>
```

### BookingFlow

```html
<header corp-header [size]="'sm'">
	<button
		slot="leftButton"
		type="button"
		aria-label="Go back"
	>
		<corp-icon icon="arrow-left-bold" size="sm"></corp-icon>
	</button>

	<a corp-logo></a>

	<p corp-title size="sm" slot="title">
		OUTBOUND · FIGARI SUD CORSE
	</p>

	<company-breadcrumb
		slot="mainMenu"
		[hasSearchIcon]="false"
	>
		<company-breadcrumb-item role="menuitem" [isDone]="true">
			<a routerLink="#1" itemprop="url item">
				<span itemprop="title">Flights</span>
			</a>
		</company-breadcrumb-item>
		<company-breadcrumb-item role="menuitem" [isDone]="true">
			<a routerLink="#2" itemprop="url item">
				<span itemprop="title">Passengers</span>
			</a>
		</company-breadcrumb-item>
		<company-breadcrumb-item role="menuitem" [isActive]="true">
			<a routerLink="#3" itemprop="url item">
				<span itemprop="title">Travel extras</span>
			</a>
		</company-breadcrumb-item>
		<company-breadcrumb-item role="menuitem" [isDisabled]="true">
			<a routerLink="#4" itemprop="url item">
				<span itemprop="title">Payments</span>
			</a>
		</company-breadcrumb-item>
	</company-breadcrumb>

	<corp-text-button
		slot="rightOption"
		iconAlignment="right"
		aria-label="Search"
	>
		<i corp-icon icon="search-bold"></i>
	</corp-text-button>

	<corp-text-button
		slot="rightOption"
		iconAlignment="right"
		aria-label="Log in"
	>
		<i corp-icon icon="user-bold"></i>
		Log in
	</corp-text-button>

	<corp-button
		slot="rightOption"
		class="u-show-md"
		size="sm"
		[variant]="'tertiary'"
	>
		Sign up
	</corp-button>
</header>
```

### CustomIcon

```html
<header corp-header [size]="'sm'">
	<a corp-logo></a>

	<p corp-title size="sm" slot="title">
		OUTBOUND · FIGARI SUD CORSE
	</p>

	<div class="u-flex" slot="logo">
		<i corp-icon icon="logo-diamond" class="u-mr-16"></i>
		<p corp-title size="sm">APP VERSIONS</p>
	</div>

	<button corp-text-button
		slot="rightOption"
		size="sm"
		aria-label="Search"
	>
		<i corp-icon icon="search-bold"></i>
	</button>
</header>
```
