---
name: security-review
description: 'Use when: a security workflow must perform evidence-based code-level vulnerability discovery on new or changed files, producing structured findings without modifying code.'
---

# Security Review

## Purpose
- This skill owns code-level vulnerability discovery on specified files, producing structured, evidence-based findings with CWE categorization.
- This skill is used by the `minerva` coordinator agent or invoked directly for scoped code review requests.
- This skill stays within the declared file scope â€” never analyzes files outside the request boundary.

## Output Contract
- Create or update exactly one report file: `SECURITY_REVIEW.md` (repository root), or PR review comments (depending on invocation context).
- When producing `SECURITY_REVIEW.md`, copy the structure verbatim from `./assets/security-review.tpl.md`.

Findings format (per finding):

| Column | Description |
|--------|-------------|
| ID | Sequential identifier (`SR-001`, `SR-002`, â€¦) |
| Severity | `Critical`, `High`, `Medium`, `Low`, or `Info` |
| CWE Category | CWE identifier and short name (e.g., `CWE-89: SQL Injection`) |
| File:Line | Exact file path and line range (`<path>:<line_start>-<line_end>`) |
| Code Snippet | Verbatim excerpt from the analyzed file |
| Description | What the vulnerability is and why the code is vulnerable |
| Remediation | Specific, actionable guidance to resolve the finding |

Generation constraints:
- `SECURITY_REVIEW.md` headings, numbering, and section order MUST NOT change from the template.
- Sections MUST NOT be removed.
- `TBD` placeholders may be replaced only with evidence-based content or `Unknown`.
- If no findings exist, include exactly one `Info` row with finding text: `No security vulnerabilities found in the analyzed files from static code evidence`.
- Task completion requires persisting `SECURITY_REVIEW.md` when operating in report mode; a read-only assessment alone is insufficient.

If no files are specified in the request, stop and request clarification.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `./assets/security-review.tpl.md`
- Owned `*.checklist.md` assets: `./assets/security-review.checklist.md`
- Additional governed inputs: `Not applicable.`

## When to Use
- The request specifies one or more files for code-level security review.
- The request identifies changed files in a pull request for pre-merge security analysis.
- The request asks for code-level vulnerability discovery on a defined file scope.
- The `minerva` coordinator routes a code review request.

## Procedure
1. **Scope resolution:** receive and validate the file list from the request. If files are referenced by PR, resolve to concrete file paths. Reject any file outside the declared scope.
2. **File scanning:** for each in-scope file, scan for security-relevant patterns:
   - Input handling and validation (user input, HTTP parameters, form data, headers).
   - Authentication and authorization checks (session handling, token validation, role checks).
   - Cryptographic usage (algorithm selection, key management, random number generation).
   - SQL and query construction (string concatenation, parameterization).
   - Output encoding (HTML output, response headers, content-type handling).
   - File operations (path construction, file uploads, directory traversal guards).
   - Network calls (SSRF vectors, URL construction, redirect handling).
   - Deserialization (untrusted input deserialization, type confusion).
   - Secrets and credentials (hardcoded values, configuration leaks).
3. **Finding verification:** for each potential finding:
   - Extract verbatim code snippet with exact line range.
   - Verify the vulnerability pattern is present in the code evidence.
   - Categorize by the most specific applicable CWE.
   - Assess severity using the deterministic calibration rules.
   - Draft specific remediation guidance.
4. **Report compilation:** compile all verified findings into `SECURITY_REVIEW.md` using `./assets/security-review.tpl.md` structure, or format as PR review comments. Assign finding IDs in file order, then line order.
5. **Validation gate:** validate the compiled output against `./assets/security-review.checklist.md`. Correct any failed checklist items before finalizing.
6. **Finalization:** verify that `SECURITY_REVIEW.md` exists as the persisted report artifact (when in report mode) before summarizing the result.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Every finding MUST have explicit evidence with a line anchor in `<path>:<line_start>-<line_end>` format.
- Every finding MUST include a verbatim code snippet, CWE category, and specific remediation guidance.
- Finding IDs MUST be sequential and assigned in file order, then line order.
- Severity MUST be justified by static evidence and follow the deterministic calibration.
- No CVE identifiers generated or suggested.
- No runtime exploitability claims without static evidence.
- Missing-evidence fields use only canonical tokens: `TBD` or `Unknown`.
- If no findings exist, exactly one `Info` row MUST be present.
- If the skill cannot satisfy its declared contract without guessing, stop and request clarification.

## Evidence Rules
- Every finding MUST include exact file path and line anchor (`<path>:<line_start>-<line_end>`).
- Code snippets MUST be verbatim from the analyzed file.
- Severity MUST be based on: exploitability from static evidence Ã— impact scope.
- If a vulnerability is ambiguous, use `Medium` with an explicit caveat in the description.
- If explicit evidence is unavailable for a required field, preserve `TBD` or use `Unknown`.
- Fabricated evidence is strictly forbidden.
- Custom missing-evidence variants such as `TBD (no explicit evidence found)` are forbidden.
- Absence claims require explicit evidence and MUST NOT be inferred.
- If a pattern is suspicious but cannot be confirmed as vulnerable from static evidence alone, note it as an observation at `Info` severity with an explicit caveat, not as a confirmed finding.
- No speculation about runtime behavior, deployment context, or environmental variables not visible in the analyzed code.

## Determinism Rules
- Given identical file set and repository state, output MUST be functionally identical.
- Finding IDs MUST be assigned in file order, then line order within each file.
- Severity MUST be evidence-backed and reproducible.
- If severity cannot be justified by static evidence, downgrade conservatively.

Allowed severities: `Critical`, `High`, `Medium`, `Low`, `Info`.

Deterministic severity calibration:
- `Critical`: clear, evidence-backed exploitable vulnerability with high impact (e.g., unauthenticated SQL injection in a request handler, hardcoded credentials in source).
- `High`: evidence-backed vulnerability with significant impact or straightforward exploitability (e.g., missing input validation on user-controlled data flowing to sensitive operations).
- `Medium`: partial vulnerability or ambiguous exploitability with mitigating factors visible in code (e.g., parameterized query with one unparameterized branch).
- `Low`: minor security hygiene issue with limited direct impact (e.g., overly broad exception handling that may leak stack traces).
- `Info`: observation or best-practice recommendation without a confirmed vulnerability.

If no findings exist, include exactly one `Info` finding with:
`No security vulnerabilities found in the analyzed files from static code evidence`

## Constraints
- MUST NOT modify any code.
- MUST NOT invent vulnerabilities not supported by code evidence.
- MUST NOT claim runtime exploitability without static evidence.
- MUST NOT analyze files outside the specified scope.
- MUST NOT generate or suggest CVE identifiers.
- MUST NOT treat a chat-only review or summary as task completion when the report file can be written.
- Repository-wide security posture audits are out of scope (use the `minerva` agent).
- Dependency and supply-chain triage is out of scope (use the `security-triage` skill).
- Automated code patching is out of scope (use the `security-patch` skill).
