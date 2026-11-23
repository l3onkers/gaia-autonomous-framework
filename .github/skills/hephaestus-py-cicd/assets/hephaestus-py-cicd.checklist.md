# Python CI/CD Skill Checklist

Quality and determinism checklist for `hephaestus-py-cicd` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist:
  - `SKILL.md`
  - `./assets/hephaestus-py-cicd.tpl.md`
  - `./assets/hephaestus-py-cicd.checklist.md`
  - `./assets/hephaestus-py-cicd.py.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/hephaestus-py-cicd.tpl.md`
- [ ] `SKILL.md` explicitly references `./assets/hephaestus-py-cicd.checklist.md`
- [ ] `SKILL.md` explicitly references `./assets/hephaestus-py-cicd.py.tpl.md`
- [ ] `SKILL.md` remains concise and does not embed the Python CI/CD template verbatim

---

## B. Skill Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `description`
- [ ] `name` is `hephaestus-py-cicd`
- [ ] The six mandatory skill headings exist in order:
  1. Purpose
  2. Output Contract
  3. Governance Inputs
  4. When to Use
  5. Procedure
  6. Validation and Compliance Decision Rules
- [ ] `SKILL.md` declares the shared template, checklist, and Python template companions explicitly
- [ ] Any additional routing or validation sections use canonical skill-heading names when applicable

---

## C. Shared CI/CD Governance
- [ ] `./assets/hephaestus-py-cicd.tpl.md` is loaded before `./assets/hephaestus-py-cicd.py.tpl.md`
- [ ] The skill allows only `Jenkinsfile`, `Dockerfile`, and unresolved required inputs unless the user explicitly requests more
- [ ] The fixed corporate Jenkins block is preserved exactly across the shared and Python templates
- [ ] The skill does not emit unrelated pipeline artifacts or Jenkins stages by default

---

## D. Python Template Coverage
- [ ] `./assets/hephaestus-py-cicd.py.tpl.md` preserves required inputs for service name, Python version, service type, packaging toolchain, entrypoint, test and coverage command, generated-code exclusions, and containerization need
- [ ] The fixed corporate Jenkins block is preserved exactly
- [ ] Only `coverageFilter` and `simianExclusions` are editable
- [ ] `coveragePercentage` remains `90.0`
- [ ] Default exclusions cover tests and generated Python artifacts
- [ ] Dockerfile rules preserve explicit Python base images, multi-stage dependency installation, API port exposure, and runtime entrypoint handling

---

## E. Safety and Final Validation
- [ ] No secrets or credentials are introduced in the skill, template, or checklist
- [ ] The skill does not instruct business-code modification during normal CI/CD execution
- [ ] The skill does not assume cloud-provider-specific deployment logic unless explicitly requested
- [ ] Validation runs against `hephaestus-py-cicd.checklist.md` together with `SKILL.md`, `hephaestus-py-cicd.tpl.md`, and `hephaestus-py-cicd.py.tpl.md`
- [ ] The Python template is the authoritative source for language-specific rules in each run
- [ ] Missing required inputs are surfaced as `Unknown` or targeted clarification questions
- [ ] Output remains deterministic and reproducible for identical inputs and repository state