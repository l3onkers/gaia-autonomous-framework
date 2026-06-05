# Internal Reference — Full Technical Specification

> **Note:** This document contains the complete technical specification for the agent and skill system.
> It was the original repository README, preserved as a reference for maintainers.
> For the public-facing documentation, see the root [README.md](../README.md).

---

## System Summary

GAIA is a governed agent framework for GitHub Copilot that organizes work into top-level agents and reusable skills.

- **Agents** are thin coordinators that route requests, enforce scope, and select the right skill family.
- **Skills** own templates, checklists, and the detailed generation or review behavior.
- **Governance assets** provide canonical templates, block catalogs, and validation rules.

## Current Repository Model

- 10 top-level agent entrypoints live under [`.github/agents/`](../.github/agents/).
- 42 governed skills live under [`.github/skills/`](../.github/skills/).
- Companion assets live inside agent- or skill-specific subdirectories and stay basename-aligned with their owner.

## Canonical Contracts

### Agent contract

New or refactored agents must use the 7-section structure defined in [docs/CREATING_AGENTS.md](CREATING_AGENTS.md).

### Skill contract

New or refactored skills must declare:

- Purpose
- Output Contract
- Governance Inputs
- When to Use
- Procedure
- Validation and Compliance Decision Rules

Optional canonical sections may be added only when they materially improve determinism, evidence handling, or validation.

## Frontend Guidance

New frontend skills should default to React first. Angular remains supported for the existing governed Angular family, but it should not be the default choice for new frontend capabilities.

## Validation Approach

Repository structure should be validated separately from product pipelines.

- Check required docs and entrypoints.
- Check skill manifests and companion assets.
- Check naming conventions and owned directories.
- Keep validation deterministic and fail fast on missing governed artifacts.

## Usage Guidance

The recommended flow is:

1. Start with GAIA for ambiguous requests.
2. Route to the smallest agent that owns the bounded workflow.
3. Let the skill own detailed generation.
4. Use APOLLO for governance review when the output must be refreshed or validated.

