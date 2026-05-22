# Dependency Security Check Checklist

## Manifest Identification
- [ ] All changed dependency manifest files in the PR diff were identified (e.g., `package.json`, `requirements.txt`, `Gemfile`, `pom.xml`, `*.csproj`, `go.mod`).
- [ ] Only manifests with actual dependency additions or version changes were analyzed.
- [ ] Unchanged manifests were excluded from the review.

## Evidence References
- [ ] Every finding references a specific manifest file and line number.
- [ ] Version ranges cited are exact (not approximate).
- [ ] Evidence is based on static analysis (version patterns, known-vulnerable names, unpinned ranges).
- [ ] If asserting absence of vulnerability, proof-of-absence is documented or claim is downgraded to `Unknown`.
- [ ] Inferred findings are labeled clearly.

## Severity Classification
- [ ] Each finding has a severity assigned: Critical, High, Medium, Low, or Unknown.
- [ ] Severity is based on stated evidence, not guessed.
- [ ] The severity summary table counts match the individual findings.

## Template Compliance
- [ ] Output follows `./assets/dependency-report.tpl.md` structure.
- [ ] All HTML comment placeholders have been replaced with concrete content.
- [ ] The Findings section is present when vulnerabilities were found, or the Clean Summary section is present when none were found.
- [ ] The Severity Summary table is present and accurate when findings exist.

## Constraint Compliance
- [ ] No dependency manifests were modified.
- [ ] No dependencies were auto-upgraded.
- [ ] No unchanged dependencies were analyzed.
- [ ] No issues were created or alerts closed.
