# Triage Plan Report

If the caller provides YAML front matter for a persisted plan artifact, place that YAML block above this title verbatim.

## 1. Request Envelope
- Operating mode: `planning` | `planning+approval+execution` | `execution-from-existing-plan`
- Source prompt: TBD
- Requested plan artifact: TBD
- Caller-provided YAML front matter: `present` | `Not applicable.`
- Exact callable designations: TBD

## 2. Candidate Catalogue Snapshot

| Rank | Callable Kind | Callable Name | Manifest Path | Match Basis | Outcome |
|------|---------------|---------------|---------------|-------------|---------|
| 1 | TBD | TBD | TBD | TBD | selected |

## 3. Selected Route
- Resolution rationale: TBD
- Single callable owner: `Yes` | `No`
- Step count: TBD
- Loading discipline: Load only the selected bundle for each step. Do not preload downstream companions or owned assets.

## 4. Invocation Plan

Repeat the following block once for every selected step.

### Step N
- Callable kind: `agent` | `skill`
- Callable name: TBD
- Manifest path: TBD
- Invocation prompt: TBD
- Inputs carried in: TBD
- Expected output: TBD
- Execution protocol: `single-pass` | `delegate-to-bundle` | `bounded-retry<=N when explicitly owned by the downstream bundle`
- Stop condition: TBD

## 5. User Approval

- Approval status: `Pending` | `Approved` | `Rejected with feedback: <feedback>`
- Approval was skipped (explicit callable designation): `Yes` | `No`
- User-requested modifications: TBD

## 6. Clarifications And Risks
- TBD

## 7. Execution Log
- Use `Not applicable.` for planning-only runs.
- For execution runs, record one flat bullet per step with status, produced output, and next-step carry-forward.