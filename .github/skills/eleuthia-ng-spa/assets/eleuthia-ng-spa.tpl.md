# Angular SPA Profile Template

Profile: `spa`
Status: Active

## 1. Objective

Generate a compilable Angular 21+ single-page frontend shell for new work using Angular CLI and SCSS, with the Angular setup defaults and SPA-specific shell rules unified in this template.

Integrated goals:
- Use Angular 21+ as the effective default for new work.
- Preserve Angular 20+ only when explicit repository evidence shows the run is extending an existing Angular 20 bundle that must remain on that baseline.
- Pin generated Angular framework, builder, CLI, and compiler packages to the `21.1.x` line when the scaffold uses `@corp/ui-components@~1.0.0`.
- Treat Node.js `^22.12.0 || >=24.0.0` as the runtime baseline for setup commands.
- Follow the Corporate Design System for look and feel.
- Keep scaffolding minimal by default and ask targeted questions instead of inventing missing product requirements.
- Keep the current `spa` profile as the governed corporate frontend shell with no application routing, one shared header wrapper, one optional SSO login wrapper, and one app-shell layout rooted in `app.component`.

Non-goals:
- Do not assume unsupported Angular application types.
- Do not add unapproved packages by default.
- Do not depend on top-level agent bundles during normal skill execution.
- Do not add SSR, hybrid rendering, or non-SPA behavior.
- Do not generate routed feature modules, `app.routes.ts`, or lazy-loaded feature areas by default.
- Do not introduce unsupported dependencies or architectural layers by default.
- Do not bypass the governed login companion when the requested feature is a login flow.

## 2. Output Contract

The agent MUST generate the following SPA-specific outputs:
- An Angular SPA scaffold or update aligned with the integrated Angular setup defaults and SPA shell rules in this template.
- A single-page `src/app/` shell with `core` and `shared` areas.
- `src/app/shared/components/header/` for the governed `app-header` wrapper.
- `src/app/shared/components/sso-login/` for the governed `app-sso-login` wrapper when login generation is requested.
- `src/app/app.component.ts` and `src/app/app.component.html` implementing the corporate app shell.
- Configuration files under `src/config/`.
- `app.config.ts` providers that register the required HTTP interceptors for the selected scope.
- A login feature implementation aligned with `./eleuthia-ng-spa.login.tpl.md` when the user explicitly requests login generation.

### Shared defaults and scope

Shared defaults:
- Language: TypeScript
- Angular version: 21+ for new work; 20+ only when extending an existing Angular 20 bundle
- Node.js: `^22.12.0 || >=24.0.0`
- Package manager: `npm`
- CSS preprocessor: `scss`
- Routing: disabled for the current `spa` profile
- Standalone components: enabled by default
- Custom libraries: `Pending` when the user has not specified them

Scope rules:
- Use Angular CLI for project generation and scaffolding.
- If Node.js 22.12 or a 24+ runtime is not available, instruct the user to install or activate a supported Node version before continuing.
- Generate only the minimum UI scaffold required by the selected profile. Do not add extra page components unless the user asks.
- If information is missing, propose clear options instead of inventing values.
- Keep user-facing UI aligned with the Corporate Design System.
- When the run includes user-facing screen composition beyond the minimal shell, load and apply the best-fit governed references from `.github/skills/eleuthia-ui-components/`, `.github/skills/eleuthia-ui-mockups/`, and `.github/skills/eleuthia-ui-styles/` before drafting markup.
- Treat those governed references as the default composition system, not optional inspiration.
- When a governed corporate pattern covers the requested view, use it instead of inventing a generic layout.
- If no governed pattern clearly fits, ask targeted clarification instead of improvising the screen.
- Keep custom markup limited to shell glue required to wire governed components together.

### App shell requirements

## 3. Evidence & Inference Usage Rules

Evidence sources:
- User-provided inputs such as app name, output path, login requirement, auth requirements, and i18n needs.
- This template `./eleuthia-ng-spa.tpl.md`.
- `./eleuthia-ng-spa.login.tpl.md` when the request includes login generation.
- Existing repository structure when extending an Angular application.

Handling missing or invalid input:
- If a required value fails validation, re-ask only that value.
- If the repository already has an Angular shell structure, prefer that structure over introducing a second pattern.

Inference:
- Structural inference is allowed only when the determinism strategy permits it and MUST be labeled when used.

## 4. Determinism Requirement

Determinism Strategy: Hybrid

Deterministic defaults and structure rules:
- Use Angular 21+ as the effective default for new work.
- Preserve Angular 20+ only when explicit repository evidence shows the run is extending an existing Angular 20 bundle that must remain on that baseline.
- Pin generated Angular framework, builder, CLI, and compiler packages to the `21.1.x` line when the scaffold uses `@corp/ui-components@~1.0.0`.
- Treat Node.js `^22.12.0 || >=24.0.0` as the runtime baseline for setup commands.
- Use `npm`, `scss`, no application routing, and standalone components enabled when the user has not overridden those defaults.
- Use `src/app/shared/components/header/` as the default header-wrapper root.
- Use `src/app/shared/components/sso-login/` as the default login-wrapper root when login generation is requested.
- Keep custom libraries as `Pending` when the user has not specified them.
- Preserve user-provided names when they are valid and consistent with the existing repository.
- Reuse the repository folder shape if it already contains matching shell, interceptor, or config conventions.

## 5. Applicability Rules

Applies only to Angular single-page frontends using the governed corporate shell and this integrated setup template.

Not applicable to:
- Non-Angular frameworks
- SSR or hybrid rendering
- Routed feature-shell applications
- Multi-profile orchestration
- Login generation without the governed login companion template

## 6. Process Definition

1. Collect inputs in this order when they are needed: app name, output path, login-feature requirement, auth details, i18n needs, custom-library exceptions.
2. Apply the integrated defaults in this template for Angular version, Node.js, package manager, stylesheet, no-routing shell behavior, standalone components, dependency allowlist, architecture rules, configuration rules, and HTTP-interceptor setup.
3. Scaffold the Angular project with Angular CLI or align the existing Angular project with the expected shell structure.
4. Create or update the `core`, `shared`, `config`, and app-shell files required for the selected scope.
5. Configure `app.config.ts` providers for the required HTTP interceptors.
6. If a login feature is requested, load `./eleuthia-ng-spa.login.tpl.md` and generate the login-related files inside `src/app/shared/components/sso-login/` plus required support services.
7. Add or update the minimum unit tests required for the setup-owned scope, replacing any Angular CLI starter assertions that no longer match the generated shell.
8. Run or define the deterministic validation commands for setup, serve, build, test, and lint.
9. Perform the validation checks in Section 7 before finalizing.

## 7. Validation Layer

Self-checks:
- The structure uses the governed shell layout rather than a routed `src/app/modules/` feature scaffold.
- `package.json` contains the required `engines` field for Node.js and npm.
- `app.component.html` contains the governed wrapper-based shell.
- No `app.routes.ts`, feature route file, or router outlet is generated for the current supported `spa` profile.
- `app.config.ts` registers the required HTTP interceptors for the selected scope.
- The scaffold keeps Angular 21+ for new work, Node.js `^22.12.0 || >=24.0.0`, npm default, SCSS default, no-routing shell behavior, and standalone-component default unless the user explicitly overrides them or explicit repository evidence requires preserving Angular 20.
- Angular framework, builder, CLI, and compiler packages stay pinned to the `21.1.x` line when the scaffold uses `@corp/ui-components@~1.0.0`.
- The dependency allowlist and prohibition on unapproved packages are preserved.
- Required design patterns, architecture preferences, coding standards, configuration rules, and HTTP guidance remain present.
- Starter Angular CLI specs are updated or removed when the generated shell replaces the default scaffold.
- The login companion template is applied when login generation is requested.
- No extra routed page components are generated by default.
- No real API keys or secrets are committed in configuration files.
- The final result includes or documents the commands `npm run setup`, `npm run validate:workspace`, `ng serve`, `ng build`, and `ng test`.
- The generated structure and UI guidance remain aligned with the Corporate Design System.
- When governed component, layout, or style references cover the requested UI, the generated screen uses them by default and does not improvise a generic layout.