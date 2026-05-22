# PR Security Review Checklist

## Scope Checks
- [ ] Only files in the PR's changed file set were reviewed.
- [ ] No files outside the PR diff were referenced or analyzed.
- [ ] Non-security-relevant files (docs, images, etc.) were excluded from review.

## Finding Quality Checks
- [ ] Every finding references a specific line number in the PR diff.
- [ ] Every finding includes a code snippet from the PR's changed content only.
- [ ] Every finding includes a severity level justified by the code change context.
- [ ] Every finding includes a valid CWE category identifier and name.
- [ ] Every finding includes a concrete remediation suggestion.
- [ ] Every finding uses the `./assets/pr-review-comment.tpl.md` template.

## Ordering Checks
- [ ] Findings are ordered by severity (descending), then file path (ascending), then line number (ascending).

## Summary Comment Checks
- [ ] If findings with severity ≥ High exist, a summary comment recommends merge block.
- [ ] If no findings exist, a summary comment confirms no issues found.
- [ ] If no security-relevant files were changed, summary states: `No security-relevant changes detected in this PR.`

## Constraint Compliance Checks
- [ ] The skill did not approve or merge the PR.
- [ ] The skill did not modify the PR's code.
- [ ] The skill did not create or close issues.
- [ ] No business intent or undocumented security requirements were inferred.
