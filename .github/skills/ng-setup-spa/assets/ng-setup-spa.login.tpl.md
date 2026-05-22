# Angular SSO Login Generator Template

Generate an SSO/OAuth login feature with:
- Sign-In button
- OAuth flow using MSAL (or equivalent SSO library)
- Token management and session handling

Architecture rules:
- Use Angular standalone components.
- Component MUST import `UiComponentsModule` in the imports array.
- Use your preferred SSO library (e.g., `@azure/msal-angular`, `angular-oauth2-oidc`, or equivalent).
- Use `HttpClient` with the SSO interceptor for authenticated requests.
- Keep authentication logic in a dedicated service.
- Use strong typing.
- Follow the governed no-routing shell structure used by the `spa` profile.
- Prefer existing shared UI and design-system components if available.
- Keep code production-ready and maintainable.
- Login component is placed in `shared/components/sso-login/`.
- Do not define `styleUrls`, `styles`, or custom CSS classes.
- Use only corporate components such as `corp-card`, `corp-button`, and `corp-title`.

Functional requirements:
- Create an SSO login component with a sign-in button, authentication-status display, and sign-out action.
- Read `clientId`, `authority`, `redirectUri`, and `postLogoutRedirectUri` from environment configuration.
- On initial load, check if the user is already authenticated.
- When authenticated:
  - Display user information from the SSO account.
  - Hide the sign-in button.
  - Expose a sign-out action.
- When not authenticated:
  - Show the sign-in button.
  - Hide authenticated user details.
- Automatically retrieve and cache access tokens using the SSO library.
- Handle authentication failures gracefully with user-friendly messaging.

Behavior:
- On sign-in, initiate the configured SSO popup flow by default.
- Use redirect flow only when explicit hosting constraints require it, and return to the application shell root rather than a routed feature page.
- On successful login, retrieve user account information and restore the application shell state.
- On logout, call the SSO logout flow and clear session state.
- Expose tokens for HTTP interceptors when authenticated API requests require them.

UI requirements:
- Center the login component within the available page area.
- Use `corp-card`, `corp-card-content`, and `corp-button` for layout.
- Center all text content.
- Keep readable spacing between lines and actions.
- When authenticated, render display name, email address, and sign-out action on separate centered lines.
- Show centered authentication-error messaging when login fails.
- Follow the corporate color palette and identity provider sign-in-brand guidance.
- Ensure responsive behavior on desktop and mobile.

Files to generate:
- `sso-login.component.ts`
- `sso-login.component.html`
- `auth.service.ts`
- `auth.models.ts` if needed
- `sso-config.factory.ts`

Implementation notes:
- Use `ChangeDetectionStrategy.OnPush`.
- Add `CUSTOM_ELEMENTS_SCHEMA`.
- Configure the SSO library with `InteractionType.Popup` by default for the current no-routing shell profile.
- Use `InteractionType.Redirect` only when explicit hosting constraints require it and keep the redirect target at the application shell root.
- Use the SSO library's broadcast service to listen to authentication events when the implementation needs it.
- Use the SSO interceptor to automatically add access tokens to HTTP requests.
- Do not put authentication logic in the component.
- Keep code simple, readable, and reusable.
- Handle SSO errors and display user-friendly messages.
- Ensure proper cleanup of subscriptions in component destroy logic.

SSO configuration template:

```json
{
  "auth": {
    "clientId": "environment.clientId",
    "authority": "environment.authority",
    "redirectUri": "environment.redirectUri",
    "postLogoutRedirectUri": "environment.postLogoutRedirectUri"
  },
  "cache": {
    "cacheLocation": "sessionStorage",
    "storeAuthStateInCookie": false
  }
}
```

Output rules:
- Return the full content of each file when the user asks for generated file output.
- Place files in the appropriate Angular folders when project structure is known.
- Include installation instructions for the SSO library packages.