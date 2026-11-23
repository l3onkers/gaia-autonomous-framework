# Triage Coordination Checklist

## A. Catalogue Resolution
- [ ] Agents were discovered only from `.github/agents/*.agent.md`
- [ ] Skills were discovered only from `.github/skills/*/SKILL.md` with `user-invocable: true`
- [ ] `.github/agents/gaia.agent.md` was excluded from direct routing
- [ ] No bundle-local companions or non-user-invocable skills were included as direct candidates

## B. Routing Decision
- [ ] Exact callable designations were resolved before manifest-comparison routing
- [ ] A top-level agent was preferred whenever it explicitly owned the matched domain or downstream orchestration
- [ ] A user-invocable skill was selected directly only when it was explicitly designated or the unique strongest manifest match
- [ ] A multi-step chain was created only when no single callable fully owned the explicit request
- [ ] The step order followed the caller's explicit valid order or the fixed precedence declared in `.github/agents/gaia.agent.md`

## C. User Approval Gate
- [ ] The resolved plan was presented to the user before execution started
- [ ] The user explicitly approved the plan, or approval was correctly skipped because the user explicitly designated a single callable
- [ ] If the user rejected or modified the plan, the updated plan was re-presented for approval
- [ ] Phase 3 execution did not start without recorded user approval (or valid approval-skip condition)

## D. Plan Traceability
- [ ] The plan followed `.github/agents/gaia/gaia.tpl.md`
- [ ] Every step recorded callable kind, callable name, manifest path, invocation prompt, carried inputs, expected output, execution protocol, and stop condition
- [ ] Caller-provided YAML front matter was preserved verbatim when a persisted plan was requested
- [ ] `TRIAGE_PLAN.md` was used only when file output was requested and no explicit path was provided

## E. Execution Discipline
- [ ] Phase 3 executed only from the resolved and user-approved Phase 1 plan or one existing validated triage plan artifact
- [ ] `execution-from-existing-plan` used one exact readable `.md` path
- [ ] Only one selected bundle was loaded at a time during execution
- [ ] Later steps consumed only explicit caller inputs or outputs produced by earlier executed steps
- [ ] Any ambiguity or missing governed input stopped the run with clarification instead of an invented fallback flow

## F. Final Sanity Check
- [ ] No invented bundles, prompts, or unsupported steps remained in the final result
- [ ] No direct routing to non-user-invocable skills occurred
- [ ] The final result remained attributable to the triage bundle and the selected downstream bundles