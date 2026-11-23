# eleuthia-ng-spa Checklist

Quality and determinism checklist for `eleuthia-ng-spa` outputs.

---

## A. Skill Bundle Integrity
- [ ] Companion artifacts exist inside the owning skill root:
  - `SKILL.md`
  - `assets/eleuthia-ng-spa.tpl.md`
  - `assets/eleuthia-ng-spa.login.tpl.md`
  - `assets/eleuthia-ng-spa.checklist.md`
- [ ] `SKILL.md` declares only skill-owned companions in `## Governance Inputs`
- [ ] No `.github/agents/*.md` file is required for normal execution of the skill

---

## B. Execution Flow Preservation
- [ ] The active profile must resolve to `spa`
- [ ] `assets/eleuthia-ng-spa.tpl.md` is loaded for every `spa` run
- [ ] The login template is loaded only when login generation is requested
- [ ] Integrated Angular setup rules and SPA-specific shell rules both remain attributable to `assets/eleuthia-ng-spa.tpl.md`
- [ ] Validation runs against the owned checklist plus the owned templates used for the run

---

## C. Shared Angular Standards Coverage
- [ ] Angular 21+ for new work, Node.js `^22.12.0 || >=24.0.0`, npm default, SCSS default, no-routing shell behavior, and standalone-component default are preserved
- [ ] Angular 20+ is preserved only when explicit repository evidence requires extending an existing Angular 20 bundle
- [ ] Angular framework, builder, CLI, and compiler packages are pinned to the `21.1.x` line when `@corp/ui-components@~1.0.0` is used
- [ ] Dependency allowlist and unapproved-package prohibition are preserved
- [ ] Generated npm scripts keep clean install in a dedicated setup flow and do not hide `npm ci` inside normal build hooks
- [ ] Required design patterns, architecture preferences, and coding standards are preserved
- [ ] Configuration, environment, and HTTP-interceptor guidance are preserved
- [ ] Corporate Design System guidance is preserved
- [ ] Governed component, mockup-layout, and global-style references remain the default UI implementation source
- [ ] Covered corporate patterns are used before improvised generic layouts, and uncovered or ambiguous UI requirements trigger clarification
- [ ] Real API keys or secrets are not present in committed examples

---

## D. SPA Profile Coverage
- [ ] SPA shell structure, wrapper-component guidance, and no-routing behavior remain attributable to `assets/eleuthia-ng-spa.tpl.md`
- [ ] Login-specific generation remains attributable to `assets/eleuthia-ng-spa.login.tpl.md`
- [ ] The skill keeps UI and structure guidance aligned with the integrated Angular setup rules in `assets/eleuthia-ng-spa.tpl.md` without depending on agent artifacts

---

## E. Final Validation
- [ ] The skill remains structurally compliant with the governed six-section skill format
- [ ] Owned companions resolve deterministically from `## Governance Inputs`
- [ ] Output remains deterministic and reproducible for identical inputs and repository state