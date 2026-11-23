# Few-Shot Example: Zero Trust Security Audit & Automated Patch

**Agent:** MINERVA  
**Skills Resolved:** `minerva-secret-scan`, `minerva-dep-check`, `minerva-patch`

## Scenario
A commit is submitted containing a vulnerable dependency and an exposed staging token.

## Execution Pattern
1. **Secret Scanning:** Detect token entropy and pattern. Immediately flag file:
   - File: `src/config/settings.py`
   - Action: Mask token in report, block PR approval, recommend environment variable injection.
2. **Dependency Audit:** Match `package.json` or `requirements.txt` against CVE database.
   - Identified: High CVE in vulnerable parsing library.
3. **Patch Proposition:** Provide surgical diff targeting only the package version bump without changing public APIs:
   ```diff
   - vulnerable-lib==1.2.0
   + vulnerable-lib==1.2.4
   ```
4. **Human Confirmation:** Present triage report and request developer approval before applying modifications.
