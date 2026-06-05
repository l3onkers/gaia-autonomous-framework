# ng-build Template

Shared Angular build, setup, configuration, layout, and quality rules for the `eleuthia` coordinator.

## Purpose

- Keep shared Angular governance in one place while leaving profile-specific behavior inside the routed profile skill selected for the run.
- Preserve the full legacy `ng-setup` contract in a governed shared companion instead of embedding it in the top-level agent.
- Make required inputs, dependency policy, wrapper constraints, configuration rules, and quality expectations explicit.

## Required Inputs and Shared Defaults

Required variables:
- `application-name`
  - If missing, ask the user: `What is the name of the application?`
- `sso-login`
  - If missing, ask the user: `This application includes a login feature integrated with an SSO/OAuth provider?`

Shared defaults:
- Language: TypeScript
- Angular CLI is required for project generation and scaffolding.
- Effective minimum Angular version for new work: 21+
- Repository-precedent Angular baseline inherited from the legacy shared template: 20+
- Governed Angular package line for new scaffolds that use `@corp/ui-components@~1.0.0`: `21.1.x`
- Node.js runtime baseline: `^22.12.0 || >=24.0.0`
- Package manager: `npm` by default
- CSS preprocessor: `scss` by default
- Current supported `spa` profile output: no application routing and a single-page view
- Historical routing-enabled guidance belongs only to legacy generic Angular setup precedent and MUST NOT override the active `spa` profile contract.
- Standalone components: enabled by default
- Custom libraries: `Pending` when the user has not specified them

Default-handling rules:
- If Node.js 22.12 or a 24+ runtime is not available, instruct the user to install or activate a supported Node version before continuing.
- If information is missing, propose clear options instead of inventing values.
- Use Angular 21+ for new scaffolds unless explicit repository evidence proves the request is an update to an Angular 20 bundle that must remain on that baseline.
- Pin generated Angular framework, builder, CLI, and compiler packages to the `21.1.x` line when the scaffold uses `@corp/ui-components@~1.0.0`.
- Treat the legacy Angular 20+ wording as precedent evidence, not as permission to lower the default for new work.

## Supported Profile Scope and UI Guardrails

Current supported Angular application profile catalog for this bundle revision:
- `spa`: a single-page Angular application with a shared header wrapper and optional SSO login wrapper.

Catalog note:
- Future Angular structures may extend this catalog through additional profile skills without changing the role of this shared template.
- The shared template stays profile-neutral where possible and the selected profile skill owns the structural specialization for the active run.

Scope rules:
- Use Angular CLI for project generation and scaffolding.
- Do not add application routing to the current `spa` profile.
- Set the application base href to `/application-name/` in `angular.json`.
- The application main page must remain a single-page composition rather than a routed feature shell.
- UI must comply with the Corporate Design System.
- All component templates must use only components defined in `.github/skills/eleuthia-ui-components/assets`.
- User-facing composition must default to the governed Company references under `.github/skills/eleuthia-ui-components/`, `.github/skills/eleuthia-ui-mockups/`, and `.github/skills/eleuthia-ui-styles/`.
- Treat the governed component and layout references as the default composition system, not as an optional palette of allowed tags.
- When a governed corporate pattern already covers the requested view, reproduce that pattern before inventing a new layout.
- If the correct governed pattern is unclear or no governed pattern covers the request, stop and ask for clarification instead of improvising a generic screen.
- Custom markup or CSS is allowed only for minimal shell glue needed to compose governed components and must not redefine the corporate visual language.
- Components must not define their own `styles`, `styleUrls`, or inline `style` attributes.
- Templates must not use custom CSS classes except the governed semantic shell hook `app-main` when the shell layout needs one stable top-level main-container selector.
- All styling must come from corporate components and global app-shell styles.
- `styles.scss` must contain only app-shell styles and no component-specific styling.
- App-shell styles should prefer semantic selectors such as `body`, `app-root`, and `main`; use `.app-main` only for the governed top-level shell container when needed.

Application shell requirements:
- `app.component.html` must include the header wrapper and the SSO login wrapper when `sso-login` is true.

```html
<app-header></app-header>
<main class="app-main">
  <app-sso-login></app-sso-login>
</main>
```

- `app.component.ts` must import the wrapper components it uses.
- `app.component` must not define `styleUrls` or `styles`.
- Background color must remain `rgb(234, 232, 232)`.
- White cards and panels should remain visually distinct against the grey app-shell background.

Wrapper-component requirements:
- Header wrapper component:
  - Selector: `app-header`
  - Location: `src/app/shared/components/header/header.component.ts`
  - Template: `src/app/shared/components/header/header.component.html`
  - Must import `UiComponentsModule`
  - Must use only Company header components
  - Must follow the documented corporate header composition from the governed header references instead of a custom logo block or ad hoc header layout
  - Must add `CUSTOM_ELEMENTS_SCHEMA`
  - Must not define custom styles or custom CSS classes
- SSO login wrapper component when `sso-login` is true:
  - Selector: `app-sso-login`
  - Location: `src/app/shared/components/sso-login/sso-login.component.ts`
  - Template: `src/app/shared/components/sso-login/sso-login.component.html`
  - Must import `UiComponentsModule`
  - Must add `CUSTOM_ELEMENTS_SCHEMA`
  - Must use only corporate components
  - Must not define custom styles or custom CSS classes
  - Must follow `.github/skills/eleuthia-ng-spa/assets/eleuthia-ng-spa.login.tpl.md`

Look and feel:
- Strictly follow the Corporate Design System for colors, typography, icons, grid, spacing, corner radius, shadows, and standard component patterns.
- Prefer documented corporate compositions from the governed frontend references instead of generic one-off card stacks when both can satisfy the request.

## Dependency and Library Policy

Approved runtime dependencies:
- `@angular/*`
- `rxjs` in a version compatible with Angular 21
- `typescript` in a version compatible with Angular 21
- `tslib` in a version compatible with Angular 21
- `@ngx-translate/core@16.0.4`
- `@ngx-translate/http-loader@16.0.1`
- `@corp/ui-components@~1.0.0` from the configured package registry, with fallback to `file:../.github/governance/modules/angular/ui-components-stub-1.0.0.tgz` when the registry connection is unavailable
- `@azure/msal-angular@^3.0.16` when `sso-login` is true (or equivalent SSO library)
- `@azure/msal-browser@^3.11.1` when `sso-login` is true (or equivalent SSO library)

Approved development and framework package versions from the legacy contract:
- `@angular/animations: ~21.1.2`
- `@angular/common: ~21.1.2`
- `@angular/compiler: ~21.1.2`
- `@angular/core: ~21.1.2`
- `@angular/forms: ~21.1.2`
- `@angular/platform-browser: ~21.1.2`
- `@angular/router: ~21.1.2`
- `@angular/build: ~21.1.5`
- `@angular/cli: ~21.1.5`
- `@angular/cdk: ~21.1.6`
- `@angular/material: ~21.1.6`
- `@angular/compiler-cli: ~21.1.2`
- `@angular-eslint/builder >= 18.0.0`
- `@angular-eslint/eslint-plugin >= 18.0.0`
- `@angular-eslint/eslint-plugin-template >= 18.0.0`
- `@angular-eslint/schematics >= 18.0.0`
- `@angular-eslint/template-parser >= 18.0.0`
- `date-fns ~4.1.0`
- `ngx-skeleton-loader ~10.0.0`
- `swiper ^11.2.5`
- `eslint ^8.57.0`
- `karma ~6.4.0`
- `jasmine-core ~5.9.0`
- `@types/jasmine ~5.1.0`
- `@types/node ^20.0.0`
- `typescript ~5.9.2`
- `ts-node ^10.9.2`
- `zone.js ~0.15.0`
- `typescript-eslint ^8.0.0`
- `prettier ^3.0.0`

Conditional dependencies:
- `@ngrx/*` is allowed only when the user explicitly requests state management.
- Cypress or Playwright are optional only when the user explicitly requests E2E coverage and approves any additional packages.

Prohibitions:
- Do not introduce packages outside this list unless the user explicitly permits them.
- Do not add secrets or live API keys to the repository or configuration files.

Library usage rules:
- Use Angular HTTP client APIs from `@angular/common/http`.
- Use `ReactiveFormsModule` or standalone reactive-form APIs for forms.
- Use Jasmine and Karma for unit tests unless explicit repository evidence requires another approved Angular runner.
- Use SCSS by default.
- Use `@ngx-translate/core@16.0.4` and `@ngx-translate/http-loader@16.0.1` when translation loading is required.
- Install `@corp/ui-components` as `~1.0.0` by default through the configured package registry.
- If the package registry connection is unavailable, fall back to `file:../.github/governance/modules/angular/ui-components-stub-1.0.0.tgz` because it is the governed repository copy of the private package.
- When the governed tarball fallback is used, validate that `../.github/governance/modules/angular/ui-components-stub-1.0.0.tgz` exists before install.

## Architecture, Folder Structure, and Coding Standards

Required design patterns when applicable:
- Smart and dumb component separation
- Services for business logic
- RxJS patterns with Observables and the async pipe
- Angular dependency injection
- Wrapper-component composition through `app.component` for the current no-routing `spa` shell
- Global error handling through HTTP interceptors

Architecture preferences when applicable:
- Shared area for reusable components, directives, pipes, and models
- Core area for singleton services, guards, interceptors, and app initialization
- Clean Architecture principles when they improve separation of concerns
- A thin app shell that coordinates shared wrapper components instead of routed feature areas

Coding standards:
- Enable `strict: true` in `tsconfig.json`.
- Treat null and undefined explicitly.
- Prefer Observables and the async pipe over manual subscription management when practical.
- Use `standalone: true` for new components in Angular 21+ unless the repository already uses a module-first structure.
- Keep methods short and use clear names.
- Recommend observable-returning service methods with a `$` suffix such as `getUser$(): Observable<User>`.
- Clean up subscriptions using the repository standard such as `takeUntil`, `takeUntilDestroyed`, or explicit `unsubscribe` when a subscription cannot be avoided.
- Remove console logging from production code.
- Keep warnings under control. If a warning cannot be resolved immediately, scope any suppression as narrowly as possible.
- Use HTTP interceptors for global error handling, authentication headers, and request or response transformation.
- Use reactive forms by default instead of template-driven forms.
- Apply ESLint and Prettier formatting consistently.
- Use `config.ts` and `config.dev.ts` for environment configuration.

Naming conventions:
- Components: `*.component.ts`
- Services: `*.service.ts`
- Interfaces and models: `*.model.ts` or `*.interface.ts`
- Directives: `*.directive.ts`
- Pipes: `*.pipe.ts`
- Modules when present: `*.module.ts`
- File names: kebab-case
- Class names: PascalCase
- Folder names: lowercase

Folder and project structure:

```text
application-name/
├── src/
│   ├── app/
│   │   ├── core/
│   │   │   ├── services/
│   │   │   │   ├── auth.service.ts
│   │   │   │   ├── token.service.ts
│   │   │   │   └── msal-config.factory.ts
│   │   │   ├── guards/
│   │   │   ├── interceptors/
│   │   ├── shared/
│   │   │   ├── components/
│   │   │   │   ├── header/
│   │   │   │   │   ├── header.component.ts
│   │   │   │   │   └── header.component.html
│   │   │   │   └── sso-login/
│   │   │   │       ├── sso-login.component.ts
│   │   │   │       └── sso-login.component.html
│   │   │   ├── models/
│   │   ├── app.config.ts
│   │   ├── app.component.ts
│   │   └── app.component.html
│   ├── assets/
│   │   ├── ico/
│   │   │   └── favicon.ico
│   │   └── svg/
│   │       └── sprite.svg
│   ├── config/
│   │   ├── config.dev.ts
│   │   └── config.ts
│   ├── styles/
│   ├── main.ts
│   └── styles.scss
├── public/
│   ├── favicon.ico
│   ├── robots.txt
│   └── ...
├── package.json
├── angular.json
├── tsconfig.json
├── ci-config.yml
└── ...
```

Structure notes:
- All Angular project files are contained within the `application-name/` folder at the project root.
- The current supported profile is a single-page view with header and optional SSO login.
- Keep the layout consistent with the repository standard when one already exists.
- Keep UI scaffolding minimal. The shell is composed through `app.component` and the shared wrapper components.
- Do not generate `src/app/modules/feature/`, `app.routes.ts`, or route-specific folders for the current supported `spa` profile.
- Shared logic belongs in `core` or `shared`.
- When generating a login feature, place files in `src/app/shared/components/sso-login/` plus the required `core/services/` support files.

## Required Configuration, Assets, Environment, and HTTP Rules

`package.json` MUST include engine constraints:

```json
{
  "engines": {
    "node": "^22.12.0 || >=24.0.0",
    "npm": ">=10.0.0"
  }
}
```

Generated npm projects should also include `.npmrc` with `engine-strict=true` so unsupported runtimes fail before install.

Required npm scripts from the legacy contract:

```json
{
  "scripts": {
    "start": "ng serve application-name --ssl true -c development",
    "build": "npm run buildscript",
    "buildscript": "node --max_old_space_size=13000 ./node_modules/@angular/cli/bin/ng build application-name --configuration production --named-chunks",
    "watch": "ng build --watch --configuration development",
    "test": "ng test",
    "test:ci": "ng test --watch=false",
    "lint": "ng lint application-name",
    "lint:dev": "ng lint application-name && npm run lint-spec:dev",
    "lint:fix": "ng lint application-name --fix && npm run lint-spec:fix",
    "lint-spec:fix": "ng lint application-name --fix",
    "lint-spec:dev": "ng lint application-name",
    "prebuild": "npm run check:env && npm run verify:deps && npm run test:ci && npm run lint",
    "purebuild": "npm run buildscript"
  }
}
```

Keep clean reinstall behavior in dedicated setup commands. Do not run `npm ci` from normal build hooks.

Configuration belongs in `src/config/`.

Production configuration example for `src/config/config.ts`:

```typescript
export const environment: any = {
  production: true,
};
```

Development configuration example for `src/config/config.dev.ts`:

```typescript
export const environment: any = {
  allLanguages: ['es-ES', 'de-DE', 'el-GR', 'en-GB', 'fr-FR', 'it-IT', 'pt-PT'],
  apiDomain: 'api.company.com',
  apiPrefix: '/api/spa/app/',
  defaultApiVersion: 'v1',
  defaultLanguage: 'en-GB',
  environmentPrefix: 'https://ci-',
  production: false,
  xApiKey: 'XXXXXXXXXXXXXXXXXXXXX', 
  clientId: 'YOUR_CLIENT_ID', `< include only when sso-login is required >`
  authority: 'https://your-identity-provider.example.com/YOUR_TENANT_ID/', `< include only when sso-login is required >`
  redirectUri: 'https://localhost:4200/application-name/', `< include only when sso-login is required >`
  postLogoutRedirectUri: 'https://localhost:4200/application-name/', `< include only when sso-login is required >`
};
```

Configuration rules:
- Commit only placeholders or empty values for sensitive-looking fields such as `xApiKey`.
- Keep production configuration minimal and rely on deployment-time injection for sensitive values.
- Never hardcode API endpoints inside components.
- Configure path aliases for `@app`, `@core`, `@shared`, and `@config`.

`tsconfig.json` path-alias example:

```json
{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": {
      "@app/*": ["src/app/*"],
      "@core/*": ["src/app/core/*"],
      "@shared/*": ["src/app/shared/*"],
      "@config/*": ["src/config/*"]
    }
  }
}
```

`angular.json` rules:
- Configure build, serve, test, and lint targets.
- Enable production build optimization.
- Set `baseHref` to `/application-name/`.
- Use asset configuration rooted at `src/assets`.
- Provide `src/assets/ico/favicon.ico` from a repository-owned source when one exists; otherwise preserve the Angular CLI default favicon and update the generated project paths accordingly.
- Copy `sprite.svg` from `.github/skills/eleuthia-ui-components/assets/icon/assets/sprite.svg` to `src/assets/svg/sprite.svg`.
- Include corporate component styles plus the app stylesheet.
- Include an ESLint architect target.
If environment-specific configuration is required:
- Define configuration keys in `src/config/config.ts` and `src/config/config.dev.ts`.
- Configure Angular file replacement so development builds replace `config.ts` with `config.dev.ts`.

`angular.json` example fragments:

```json
{
  "build": {
    "options": {
      "baseHref": "/application-name/",
      "assets": [
        {
          "glob": "**/*",
          "input": "src/assets",
          "output": "assets"
        }
      ],
      "styles": [
        "./node_modules/@corp/ui-components/assets/css/styles.css",
        "src/styles.css"
      ]
    }
  },
  "lint": {
    "builder": "@angular-eslint/builder:lint",
    "options": {
      "lintFilePatterns": [
        "src/**/*.ts",
        "src/**/*.html"
      ]
    }
  },
  "configurations": {
    "development": {
      "fileReplacements": [
        {
          "replace": "src/config/config.ts",
          "with": "src/config/config.dev.ts"
        }
      ]
    }
  }
}
```

## Required configuration files


ESLint and formatting rules:
- Use `@angular-eslint/recommended` in `.eslintrc.json` or `.eslintrc.js`.
- A matching `prettier.config.js` may use:

```javascript
module.exports = {
  printWidth: 100,
  singleQuote: true,
  trailingComma: 'es5',
  useTabs: false,
  semi: true,
};
```

## HTTP client setup

HTTP interceptor requirements:
- Create a global error handler interceptor.
- Create an API key interceptor that adds `x-api-key` from `environment.xApiKey`.
- Create an API session interceptor that adds `x-client-session` using a UUID helper.
- Create an API token interceptor that adds `x-session-token` from `sessionStorage` key `token` when required.
- Register required interceptors in `app.config.ts` providers.

API key interceptor example:

```typescript
import { HttpInterceptorFn } from '@angular/common/http';
import { environment } from '@config/config';

export const apiKeyInterceptor: HttpInterceptorFn = (request, next) => {
  const modifiedRequest = request.clone({
    setHeaders: {
      'x-api-key': environment.xApiKey,
    },
  });

  return next(modifiedRequest);
};
```

Session helper example:

```typescript
export const generateUUID = (): string => {
  return crypto.randomUUID();
};
```

Error-handling rules:
- Handle HTTP errors globally using an interceptor.
- Return meaningful user-facing error messages.
- Log to a monitoring service such as Sentry only when the repository or user explicitly requires it.
- Register required interceptors in `app.config.ts` providers when using a standalone Angular app.

## Quality, Restrictions, and Expected Outputs

Base quality rules:
- Add or adjust `.editorconfig` and `.prettierrc` only if the repository already uses them.
- Ensure the project can run without obvious configuration errors for `npm run setup`, `ng serve`, `ng build`, and `ng test`.
- Ensure the scaffold does not contain real secrets or API keys.
- Remove unnecessary code, dependencies, configuration, and files.
- Remove unused imports and declarations.
- Keep the code clean and well organized.

Restrictions:
- Do not customize CI/CD beyond the governed CI configuration snippet.
- Do not write extensive tests beyond the setup-owned unit-test scope unless the user asks.
- Do not modify existing files unless necessary for the requested setup change.

Expected outputs:
- List files and folders created or changed.
- List npm packages and versions used.
- Include `package.json` engine constraints.
- Include application initialization and app-shell configuration.
- Configure `httpErrorInterceptor`, `apiKeyInterceptor`, `sessionInterceptor`, and `tokenInterceptor` in `app.config.ts` providers when required by the selected scope.
- Provide local run instructions:
  - `npm run setup`
  - `npm start` or `ng serve`
  - Open `https://localhost:4200` in a browser.
- Provide production build instructions:
  - `npm run build`
  - `npm run purebuild`
- Provide testing and linting instructions:
  - `npm run check:env`
  - `npm run verify:deps`
  - `npm run validate:workspace`
  - `npm test`
  - `npm run test:ci`
  - `npm run lint`
  - `npm run lint:fix`

Completion checklist:
- [ ] Project created with Angular CLI
- [ ] Asset folders created (`src/assets/ico`, `src/assets/svg`)
- [ ] Favicon configured from a valid repository-owned source or preserved from the Angular CLI default scaffold
- [ ] `sprite.svg` copied from `.github/skills/eleuthia-ui-components/assets/icon/assets/sprite.svg` to `src/assets/svg/sprite.svg`
- [ ] Favicon configured in `index.html`
- [ ] Assets configured in `angular.json`
- [ ] Only components from `skills/eleuthia-ui-components/assets` are used
- [ ] No custom styles are defined in Angular components
- [ ] No custom CSS classes are used in Angular templates beyond the governed `app-main` shell hook when needed
- [ ] All component styling comes from corporate components and app-shell styles
- [ ] `styles.scss` contains only app-shell styles
- [ ] Header wrapper component created in `shared/components/header/`
- [ ] Header wrapper imports `UiComponentsModule`
- [ ] Header wrapper uses only corporate components
- [ ] Header wrapper has no custom styles or CSS classes
- [ ] SSO login wrapper component created in `shared/components/sso-login/` when `sso-login` is true
- [ ] SSO login wrapper imports `UiComponentsModule` when `sso-login` is true
- [ ] SSO login wrapper uses only corporate components when `sso-login` is true
- [ ] SSO authentication follows `.github/skills/eleuthia-ng-spa/assets/eleuthia-ng-spa.login.tpl.md` when `sso-login` is true
- [ ] SSO/MSAL packages are installed when `sso-login` is true
- [ ] SSO configuration factory is created with environment values when `sso-login` is true
- [ ] Authentication service is created with login and logout methods when `sso-login` is true
- [ ] Token service is created for token management when `sso-login` is true
- [ ] SSO providers are configured in `app.config.ts` when `sso-login` is true
- [ ] App component includes the governed header and login composition
- [ ] Layout follows the standard header plus main-content structure
- [ ] No routing is added for the current `spa` profile
- [ ] Base href is set to `/application-name/` in `angular.json`
- [ ] Fresh setup succeeds (`npm run setup`)
- [ ] Runs without errors (`ng serve`)
- [ ] Builds without errors (`npm run build`)
- [ ] Tests run without errors (`ng test`)
- [ ] Lint runs without errors (`npm run lint`)
- [ ] CI configuration file exists at project root
- [ ] Configuration is defined and no secrets are exposed
- [ ] Structure is consistent with the standard
- [ ] Code is consistent with the coding standards
- [ ] Dependencies are consistent with the standards
- [ ] Patterns are consistent with the standards
- [ ] Architecture is consistent with the standards
- [ ] Configuration files are consistent with the standards
- [ ] All npm scripts are properly configured
- [ ] Unused imports and declarations are removed
- [ ] Code is clean and well organized