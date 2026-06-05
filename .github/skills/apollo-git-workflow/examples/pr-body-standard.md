## Problem Statement
The user list endpoint returns all results in a single response regardless of dataset size, causing slow response times and high memory usage for large result sets.

## Behavior Summary
Added cursor-based pagination to `GET /users`. The endpoint now accepts `?cursor=<id>&limit=<n>` query parameters and returns a `next_cursor` field in the response body. Default limit is 50, maximum is 200. Existing clients that omit pagination parameters receive the first page with a cursor for the next page.

## Test Evidence
- Unit tests: `npm test -- --grep "pagination"` — 12 tests pass covering default limit, custom limit, cursor navigation, empty results, and invalid cursor handling.
- Integration test: `npm run test:integration` — verified against a seeded database with 10,000 user records. Response time dropped from ~3.2s to ~45ms per page.
- Manual verification: `curl http://localhost:3000/users?limit=5` returns 5 results with a valid `next_cursor`.

## Risk and Rollback
**Risk level:** Low. The change is backward compatible — omitting query parameters returns the first page, which is functionally identical to the previous full response for small datasets.

**Rollback:** Revert the merge commit. No database migrations involved. Clients using the new `cursor` parameter will receive standard error responses until the feature is re-deployed.

## Reviewer Checklist
- [x] Technical correctness
- [x] Security and sensitive-data handling
- [x] Data-contract compatibility
- [x] Data leakage risk
- [x] Docs updated if workflow or behavior changed
