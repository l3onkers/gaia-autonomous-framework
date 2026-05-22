## Dependency Security Review

### Summary
<!-- One-line summary: number of findings, or confirmation that dependency changes are clean. -->

### Changed Manifests
<!-- List each manifest file that was modified in this PR. -->

| Manifest File | Dependencies Added | Dependencies Changed |
|---|---|---|
<!-- | `path/to/manifest` | count | count | -->

### Findings

<!-- Repeat this block for each vulnerable or concerning dependency. Remove this section entirely if no findings. -->

#### Finding: `<dependency-name>` (`<version>`)
| Field | Value |
|---|---|
| **Manifest** | `<file-path>:<line-number>` |
| **Concern** | <!-- One of: outdated major version, known-vulnerable package, unpinned version, or specific CVE/advisory reference --> |
| **Severity** | <!-- One of: Critical, High, Medium, Low, Unknown --> |
| **Evidence** | <!-- Static evidence: version pattern, known advisory, unpinned range --> |
| **Remediation** | <!-- Recommended action: pin version, upgrade to X.Y.Z, replace with alternative --> |

### Severity Summary

| Severity | Count |
|---|---|
| Critical | <!-- count or 0 --> |
| High | <!-- count or 0 --> |
| Medium | <!-- count or 0 --> |
| Low | <!-- count or 0 --> |
| Unknown | <!-- count or 0 --> |

### Remediation Recommendations
<!-- Prioritized list of recommended actions. Remove this section if no findings. -->
1. <!-- Highest-severity remediation first -->

### Clean Summary
<!-- Include this section ONLY when no vulnerable dependencies were found. Remove the Findings, Severity Summary, and Remediation Recommendations sections above when using this section. -->
<!-- ✅ All dependency changes in this PR have been reviewed. No known vulnerabilities or concerning version patterns were identified. -->
