---
name: gaia-knowledge-ingest
description: 'Use when: capturing user feedback, ingesting few-shot examples, or recording lessons learned into the GAIA knowledge base.'
user-invocable: true
---

# GAIA Knowledge Ingest Skill

## Purpose
- This skill owns capturing user feedback, verified execution examples, and operational conventions into the `knowledge/` store.
- This skill is used by APOLLO, HEPHAESTUS, or GAIA to systematically expand the framework's knowledge base.
- This skill stays within knowledge ingestion, few-shot examples, and learning records; it does not directly modify production infrastructure.

## Output Contract
- One updated knowledge record in `knowledge/learnings/conventions.md`, or
- One new few-shot example in `knowledge/examples/<topic>.md`, or
- One compliance review report from `./assets/gaia-knowledge-ingest.checklist.md`.

If the feedback lacks actionable detail or contradicts established Zero Trust policies, stop and request clarification.

## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned template asset: `./assets/gaia-knowledge-ingest.tpl.md`
- Owned checklist asset: `./assets/gaia-knowledge-ingest.checklist.md`
- Additional governed inputs:
  - `knowledge/README.md`
  - `knowledge/learnings/conventions.md`

## When to Use
- The user provides feedback, corrective rules, or architectural preferences during a conversation.
- A complex platform engineering task is successfully solved and should be saved as a reusable few-shot reference.
- An agent learns a new deployment convention that should persist across future sessions.

## Procedure
1. Identify the knowledge category: **Few-Shot Example** (code/infra solution) or **Convention** (architectural rule/preference).
2. Load `./assets/gaia-knowledge-ingest.tpl.md` and `./assets/gaia-knowledge-ingest.checklist.md`.
3. If the knowledge is an operational rule, record it under the appropriate section in `knowledge/learnings/conventions.md`.
4. If the knowledge is a multi-step execution solution, create or update the markdown artifact in `knowledge/examples/<topic>.md` with realistic code and zero placeholders.
5. If the knowledge warrants a new reusable skill, invoke HEPHAESTUS via `hephaestus-build-skill`.
6. Self-validate against `./assets/gaia-knowledge-ingest.checklist.md`.

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that all code examples are fully realized with no `TODO` placeholders.
- Never record plaintext secrets or credentials in the knowledge base.
- If the knowledge item cannot be categorized without ambiguity, stop and request user guidance.
