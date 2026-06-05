# Create Or Update README Checklist

## Template Resolution
- [ ] Exactly one output path was resolved for the run
- [ ] The resolved output path stays inside the repository and has basename `README.md`
- [ ] Repository-root `README.md` was used only when the caller did not designate a different in-repository `README.md` target
- [ ] Exactly one active template was selected for the run
- [ ] When no caller-provided template was supplied, bundled template resolution used exact designation, deterministic best-fit evaluation, user clarification for ambiguity, or final generic fallback
- [ ] If best-fit evaluation remained ambiguous and user input was available, the current valid bundled template assets from the `apollo-readme` skill were shown before asking the user to choose
- [ ] `README.generic.tpl.md` existed in the discovered asset set before final generic fallback was used

## Structural Validation
- [ ] The output file is the resolved in-repository `README.md`
- [ ] All sections defined in the active template are present
- [ ] Section order matches the active template
- [ ] Canonical section headings from the active template are preserved
- [ ] Optional sections defined by the active template remain present even when their body is exactly `Not applicable.`
- [ ] No extra sections were added
- [ ] If a template other than `README.generic.tpl.md` was selected, no generic-only sections or headings were injected

## Content Validation
- [ ] No active-template instructions appear in the output
- [ ] No speculative or inferred content
- [ ] Final generic fallback was used only after no caller-provided template, no exact bundled designation, and no single best-fit candidate or user-selected alternative was available for the run
- [ ] Required fields are either filled or left as `To be defined.` / `Unknown`
- [ ] Optional sections defined by the active template are either evidence-based or exactly `Not applicable.`
- [ ] Applicability markers use only `Not applicable.` and never `NA`, `N/A`, or `Not Apply`

## Tables & Formatting
- [ ] Tables required by the active template are syntactically valid
- [ ] Active-template internal links and anchors point to existing headings or anchors
- [ ] Code blocks contain only concrete commands or examples
- [ ] No broken or partial placeholders remain

## Final Sanity Check
- [ ] The resolved `README.md` reads as the documentation artifact owned by the selected `apollo-readme` skill
- [ ] Focus is on intent, technical impact, and execution
- [ ] Optional sections marked `Not applicable.` are genuinely unsupported by explicit evidence
- [ ] The final output follows the selected template rather than assuming a fixed bundled default structure
- [ ] No functional or product-level documentation included
- [ ] No speculative future work or unconfirmed details
- [ ] No secrets, credentials, or sensitive information included