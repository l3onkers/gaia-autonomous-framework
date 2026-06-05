## Problem Statement
The data cleaning logic in `notebooks/clean-user-events.ipynb` has been validated and is ready for extraction into the shared library so that scheduled jobs can reuse it without running the notebook.

## Behavior Summary
Extracted the event deduplication and timestamp normalization functions from the exploration notebook into `src/etl/event_cleaning.py`. The notebook now imports from the library instead of defining the functions inline. Scheduled jobs can call `deduplicate_events()` and `normalize_timestamps()` directly.

## Test Evidence
- Unit tests: `pytest tests/test_event_cleaning.py` — 8 tests covering deduplication with duplicate keys, empty inputs, timezone edge cases, and malformed timestamps.
- Notebook verification: re-ran all cells in `notebooks/clean-user-events.ipynb` end-to-end — outputs match the pre-extraction baseline.

## Risk and Rollback
**Risk level:** Low. The extracted functions are identical to the notebook implementations. The notebook itself is updated to import from the library, so reverting the PR restores the inline definitions.

**Rollback:** Revert the merge commit. The notebook will fall back to its previous inline function definitions.

## Reviewer Checklist
- [x] Technical correctness
- [x] Security and sensitive-data handling
- [x] Data-contract compatibility
- [x] Data leakage risk
- [x] Docs updated if workflow or behavior changed

---

## Notebook-Driven PR

| Field | Value |
|---|---|
| **Notebook Path** | `notebooks/clean-user-events.ipynb` |
| **Objective** | Validate and finalize event deduplication and timestamp normalization logic for production extraction |
| **Dataset / Input Source** | Event logs from `events.raw_user_events` table (sampled 100k rows) |
| **Extracted Library Code** | `src/etl/event_cleaning.py::deduplicate_events`, `src/etl/event_cleaning.py::normalize_timestamps` |
| **Tests Covering Extraction** | `tests/test_event_cleaning.py::TestDeduplicateEvents`, `tests/test_event_cleaning.py::TestNormalizeTimestamps` |
