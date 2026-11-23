# Net Build Checklist

Quality and determinism checklist for `eleuthia` outputs.

---

## A. Bundle Integrity
- [ ] Companion artifacts exist with matching basename:
  - `eleuthia.agent.md`
  - `eleuthia-net.tpl.md`
  - `eleuthia-net.checklist.md`
- [ ] `eleuthia.agent.md` references `eleuthia-net.tpl.md` and `eleuthia-net.checklist.md` as authoritative governed inputs
- [ ] `eleuthia.agent.md` remains supervisory and keeps detailed shared setup rules in `eleuthia-net.tpl.md`
- [ ] Supported profile skills exist under `.github/skills/`:
  - `.github/skills/eleuthia-net-job/SKILL.md`
  - `.github/skills/eleuthia-net-worker/SKILL.md`
  - `.github/skills/eleuthia-net-api/SKILL.md`
  - `.github/skills/eleuthia-net-api-cqrs/SKILL.md`
  - `.github/skills/eleuthia-net-api-modular/SKILL.md`
- [ ] Each supported profile skill owns the matching profile template asset:
  - `.github/skills/eleuthia-net-job/assets/eleuthia-net-job.tpl.md`
  - `.github/skills/eleuthia-net-worker/assets/eleuthia-net-worker.tpl.md`
  - `.github/skills/eleuthia-net-api/assets/eleuthia-net-api.tpl.md`
  - `.github/skills/eleuthia-net-api-cqrs/assets/eleuthia-net-api-cqrs.tpl.md`
  - `.github/skills/eleuthia-net-api-modular/assets/eleuthia-net-api-modular.tpl.md`

---

## B. Agent Governance Structure
- [ ] YAML front matter exists with required keys: `name`, `target`, `description`
- [ ] Exactly seven core sections exist in order:
  1. Objective
  2. Output Contract
  3. Evidence & Inference Usage Rules
  4. Determinism Requirement
  5. Applicability Rules
  6. Process Definition
  7. Validation Layer
- [ ] Section 4 starts with `Determinism Strategy: <Strict|Inference|Hybrid>`
- [ ] `eleuthia.agent.md` declares the shared template and checklist companions explicitly

---

## C. Bounded Routing Contract
- [ ] The run is resolved as one bounded `eleuthia` request before companion or skill loading begins
- [ ] Exactly one supported profile token is resolved per run: `job`, `worker`, `api`, `api-cqrs`, or `api-modular`
- [ ] Deterministic profile-skill mapping is explicit and bounded to the supported scope
- [ ] `api-cqrs` and `api-modular` take precedence over the generic `api` mapping when their more specific tokens match
- [ ] Requests that still imply multiple plausible profiles trigger clarification instead of a guessed hybrid route
- [ ] Exactly one profile skill is resolved for the bounded run

---

## D. Loading and Ownership Discipline
- [ ] `.github/agents/eleuthia/eleuthia-net.tpl.md` and `.github/agents/eleuthia/eleuthia-net.checklist.md` are loaded before any profile skill content is used
- [ ] Only the selected profile skill manifest is loaded for the bounded run
- [ ] Only the selected profile skill's explicitly declared owned assets are loaded after its manifest
- [ ] Shared setup rules, dependency allowlists, structure standards, configuration rules, proxy rules, Result-pattern rules, and base quality rules remain attributable to `eleuthia-net.tpl.md`
- [ ] Profile-specific structure, generation rules, and profile QA detail remain attributable to the selected profile skill and its owned asset
- [ ] When the governed Result pattern applies, generated code uses shared `Result` / `Result<T>` types from `ResultNet` and `MyOrg.Core.Results` directly rather than app-local wrapper abstractions such as `ServiceResult`
- [ ] For `api-modular` outputs, the `.sln` contains the governed logical solution folders and the generated projects are nested under them through `NestedProjects` without moving physical project paths only to satisfy that logical organization
- [ ] The wrapper does not duplicate detailed drafting rules already owned by `eleuthia-net.tpl.md` or the selected profile skill
- [ ] Incomplete profile skills or missing skill-owned assets trigger clarification instead of invented rules
- [ ] Shared `eleuthia` governance wins over conflicting profile-skill rules unless the user explicitly overrides it

---

## D1. Database Clarification Discipline
- [ ] If the selected setup scope requires persistence, database engine/provider is treated as a required input
- [ ] The agent does not infer SQL Server, PostgreSQL, or another engine from the illustrative `ConnectionStrings.config` sample
- [ ] Provider-specific packages and infrastructure code are selected only after explicit user input or repository evidence identifies the engine/provider

---

## D2. API Bootstrap Discipline
- [ ] For API profiles using `builder.AddV7(...)`, the agent does not add redundant configuration-loading code in `Program.cs`
- [ ] For API profiles using `builder.AddV7(...)`, the agent does not add `AddApplicationConfiguration()` because `AddV7(...)` already owns configuration loading
- [ ] For API profiles using `builder.AddV7(...)`, the agent does not add duplicate API versioning, controller, logging, NLog, or swagger bootstrap already owned by `AddV7(...)`

---

## D2.1 CQRS Controller Discipline
- [ ] For `api-cqrs` and `api-modular` outputs, CQRS controllers inject `MyOrg.Core.Cqrs.Services.Api.ISender` instead of `MediatR.ISender`
- [ ] For `api-cqrs` and `api-modular` outputs, CQRS controller actions return `Task<IActionResult>` and call `sender.Send(commandOrQuery, ResponseModel.From..., cancellationToken: cancellationToken)` instead of the overloads that return `Result` or `Result<T>`
- [ ] For `api-cqrs` and `api-modular` outputs, the generated CQRS controller flow does not rely on app-local `ToActionResult` or `ControllerResultExtensions` helpers to convert `Result` or `Result<T>` after sending commands or queries
- [ ] API-facing projects in `api-cqrs` and `api-modular` outputs, including module `Application` projects, enable `GenerateDocumentationFile`

---

## D3. Repository Persistence Discipline
- [ ] When repository-based persistence is generated or modified, Unit of Work is generated or reused in the same bounded setup scope
- [ ] Generated or modified repositories do not call `SaveChanges` or `SaveChangesAsync` directly
- [ ] Commit logic is implemented in Unit of Work rather than in repository methods
- [ ] Services or handlers that coordinate writes depend on the required repository or repositories plus Unit of Work
- [ ] Unit of Work does not hold direct references to repositories
- [ ] Generated or modified Unit of Work contracts and implementations expose only `SaveChanges()` and `SaveChangesAsync(CancellationToken cancellationToken = default)` as commit methods
- [ ] Generated or modified Unit of Work contracts and implementations do not expose repository properties, repository getters, or repository members

---

## E. Setup-Owned QA and Safety
- [ ] Setup-owned QA remains integrated into `eleuthia` and no separate `net-qa` handoff is required for the selected scope
- [ ] NUnit + Moq expectations for the selected setup-owned scope are preserved
- [ ] Existing repository test and coverage tooling is reused before new QA dependencies are proposed
- [ ] Coverage expectations remain attributable to `eleuthia-net.tpl.md`, the selected profile skill, and repository evidence
- [ ] Default scaffold placeholders such as `UnitTest1.cs` and `Class1.cs` are removed from the generated or modified setup-owned scope
- [ ] If coverage cannot be demonstrated inside the approved scope, the result records `Unknown` or a gap analysis instead of guessed compliance
- [ ] Production-code refactors for coverage are not performed without explicit approval
- [ ] No secrets or credentials are introduced in agent or checklist content
- [ ] Dependency rules do not allow unapproved packages without explicit user permission

---

## F. Final Validation
- [ ] Validation runs against `eleuthia-net.checklist.md` together with Section 7 of `eleuthia.agent.md`
- [ ] The final result uses only the minimum governed working set: the canonical companions plus one selected profile skill bundle
- [ ] Routing, loading, ownership, and QA decisions remain deterministic for identical inputs and repository state
- [ ] The final result remains attributable to the canonical `eleuthia` companions plus the selected routed profile skill
