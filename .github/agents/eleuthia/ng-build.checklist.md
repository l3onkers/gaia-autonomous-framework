# ng-build Checklist

Quality and determinism checklist for `ng-build` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist with matching basename:
  - `ng-build.agent.md`
  - `ng-build.tpl.md`
  - `ng-build.checklist.md`
- [ ] `ng-build.agent.md` references `ng-build.tpl.md` and `ng-build.checklist.md` as authoritative governed inputs
- [ ] `ng-build.agent.md` remains supervisory and keeps detailed shared Angular rules in `ng-build.tpl.md`
- [ ] At least one supported profile skill exists under `.github/skills/`:
  - `.github/skills/ng-setup-spa/SKILL.md`
- [ ] The supported profile skill owns the matching companion assets:
  - `.github/skills/ng-setup-spa/assets/ng-setup-spa.tpl.md`
  - `.github/skills/ng-setup-spa/assets/ng-setup-spa.login.tpl.md`
  - `.github/skills/ng-setup-spa/assets/ng-setup-spa.checklist.md`

---

## B. Agent Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `target`, `description`
- [ ] Exactly seven core sections exist in order:
  1. Objective
  2. Output Contract
  3. Evidence & Inference Usage Rules
  4. Determinism Requirement
  5. Applicability Rules
  6. Process Definition
  7. Validation Layer
- [ ] Section 4 starts with `Determinism Strategy: Hybrid`
- [ ] `ng-build.agent.md` declares the shared template and checklist companions explicitly

---

## C. Shared Angular Standards Coverage
- [ ] Required variables `application-name` and `sso-login` are preserved
- [ ] Angular 21+ is preserved as the effective default for new work
- [ ] Legacy Angular 20+ wording is preserved as historical shared-template precedent
- [ ] Node.js `^22.12.0 || >=24.0.0`, npm default, SCSS default, and standalone-component default are preserved
- [ ] The no-routing SPA output rule is preserved for the current supported profile
- [ ] Dependency allowlist is preserved for Angular packages, i18n packages, corporate components, tooling, and optional exceptions
- [ ] Angular framework, builder, CLI, and compiler packages are pinned to the `21.1.x` line when `@corp/ui-components@~1.0.0` is used
- [ ] Private `@corp/ui-components` installs prefer `~1.0.0` from the package registry and fall back to `file:../.github/governance/modules/angular/ui-components-stub-1.0.0.tgz` only when that connection is unavailable
- [ ] Generated npm scripts keep clean install in a dedicated setup flow and do not hide `npm ci` inside normal build hooks
- [ ] The prohibition on unapproved dependencies is preserved
- [ ] Required design patterns are preserved
- [ ] Architecture preferences are preserved
- [ ] Coding standards are preserved
- [ ] Header-wrapper and SSO login wrapper constraints are preserved
- [ ] Folder and project structure guidance is preserved
- [ ] Required configuration files, engine constraints, path aliases, asset rules, and lint configuration are preserved
- [ ] Environment configuration and Angular file-replacement guidance are preserved
- [ ] HTTP interceptor rules are preserved
- [ ] Corporate Design System guidance is preserved
- [ ] Governed component, mockup-layout, and global-style references remain the default UI implementation source rather than optional inspiration
- [ ] Covered corporate patterns are used before improvised generic layouts, and uncovered or ambiguous UI requirements trigger clarification
- [ ] Quality restrictions and expected outputs are preserved
- [ ] Jasmine and Karma unit-test guidance is preserved
- [ ] Local validation expectations for `npm run setup`, `npm run check:env`, `npm run verify:deps`, `ng serve`, `ng build`, `ng test`, and `ng lint` are preserved
- [ ] Real API keys or secrets are not present in committed examples
- [ ] The CI configuration snippet is preserved without being silently rewritten during this bundle refactor

---

## D. Profile Skill Routing
- [ ] Profile-skill resolution uses the deterministic skill rule declared in `ng-build.agent.md`
- [ ] The supported-profile catalog is declared explicitly in `ng-build.agent.md`
- [ ] Each declared supported profile token has exactly one deterministic skill mapping
- [ ] Exactly one profile skill is resolved per run
- [ ] The selected profile skill is loaded before any skill-owned assets are used
- [ ] Login-specific behavior is delegated to the selected profile skill's owned login asset when requested
- [ ] Incomplete profile skills or missing skill-owned assets trigger clarification instead of invented rules
- [ ] Canonical shared template rules win over conflicting profile skill rules unless the user explicitly overrides them

---

## E. Safety and Ownership
- [ ] The coordinator owns shared Angular governance and validation only
- [ ] The selected SPA skill owns profile-specific structure, login-specific behavior, and generation rules through skill-owned assets
- [ ] Configuration guidance explicitly forbids committing live API keys and recommends placeholders or deployment-time injection instead
- [ ] Dependency rules do not allow unapproved packages without explicit user permission
- [ ] No secrets or credentials are introduced in the agent, template, checklist, or selected skill-owned assets

---

## F. Final Validation
- [ ] Validation runs against `ng-build.checklist.md` together with Section 7 of `ng-build.agent.md`
- [ ] Shared setup rules from `ng-build.tpl.md` remain authoritative without loss
- [ ] Login-form generation rules resolve from the selected profile skill's owned login asset when requested
- [ ] Output remains deterministic and reproducible for identical inputs and repository state