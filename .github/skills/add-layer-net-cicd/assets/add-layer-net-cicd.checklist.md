# .NET CI/CD Skill Checklist

Quality and determinism checklist for `add-layer-net-cicd` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/add-layer-net-cicd.tpl.md`
  - `./assets/add-layer-net-cicd.checklist.md`
  - `./assets/add-layer-net-cicd.net.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-net-cicd.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-net-cicd.checklist.md`
- [ ] `SKILL.md` explicitly references `./assets/add-layer-net-cicd.net.tpl.md`
- [ ] `SKILL.md` remains concise and does not embed the `.NET` CI/CD template verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `add-layer-net-cicd`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, and `.NET` template companions explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Shared CI/CD Governance
- [ ] `./assets/add-layer-net-cicd.tpl.md` is loaded before `./assets/add-layer-net-cicd.net.tpl.md`
- [ ] The skill allows only `Jenkinsfile`, `Dockerfile`, and unresolved required inputs unless the user explicitly requests more
- [ ] The fixed corporate Jenkins block is preserved exactly across the shared and `.NET` templates
- [ ] The skill does not emit unrelated pipeline artifacts or Jenkins stages by default

---

## D. .NET Template Coverage
- [ ] `./assets/add-layer-net-cicd.net.tpl.md` preserves required inputs for project name, artifact type, .NET version, entrypoint, generated-code exclusions, and containerization need
- [ ] The fixed corporate Jenkins block is preserved exactly
- [ ] Only `coverageFilter` and `simianExclusions` are editable
- [ ] `coveragePercentage` remains `90.0`
- [ ] Default exclusions cover tests and auto-generated code
- [ ] Dockerfile rules preserve the `.NET` SDK/runtime base images, multi-stage build, `Release` configuration, API port exposure, and entrypoint handling

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, template, or checklist
- [ ] The skill does not instruct business-code modification during normal CI/CD execution
- [ ] The skill does not assume cloud-provider-specific deployment logic unless explicitly requested
- [ ] Validation runs against `add-layer-net-cicd.checklist.md` together with `SKILL.md`, `add-layer-net-cicd.tpl.md`, and `add-layer-net-cicd.net.tpl.md`
- [ ] The `.NET` template is the authoritative source for language-specific rules in each run
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state