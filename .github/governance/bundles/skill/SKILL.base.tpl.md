---
name: <skill-name>
description: 'Use when: <caller-or-workflow> must <owned-skill-behavior>.'
---

# <Skill Title>

## Purpose
- This skill owns <workflow-or-capability>.
- This skill is used by <owning-agent-or-caller>.
- This skill stays within <scope-boundary>.

## Output Contract
- <describe the exact output file(s) or output scope owned by this skill, such as a specific document artifact, a set of files in a directory, or a defined area of responsibility in the repository>
- <owned-output-file-or-output-scope>

If <blocking-condition>, stop and do not modify files.


## Governance Inputs
- Skill manifest: `./SKILL.md`
- Owned `*.tpl.md` assets: `Not applicable.`
- Owned `*.checklist.md` assets: `Not applicable.`
- Additional governed inputs: `Not applicable.`

## When to Use
- <describe general conditions or trigger scenarios for using this skill, such as specific user requests, workflow contexts, or repository states>

## Procedure
1. <step-1>
2. <step-2>
3. ...

## Validation and Compliance Decision Rules
- Validate that the required skill headings remain present and ordered exactly as defined by the governing supervisor skill.
- Validate that any owned template or checklist paths declared in `## Governance Inputs` are skill-relative and exist for the current run.
- Use `Unknown`, `Not applicable.`, and `To be defined.` exactly when the skill contract and available evidence require them.
- If the skill cannot satisfy its declared contract without guessing, stop and request clarification.

<!-- Add optional sections only after the six required headings. Use ./SKILL.block-catalog.md to choose the smallest canonical block set that fits the skill type.

Optional canonical sections when the skill needs more structure:
## Asset Resolution
## Template Asset Resolution
## Canonical Terminology
## Evidence Rules
## Determinism Rules
## Target Bundle Resolution
## Primary Artifact Validation
## Validation
## Constraints
## Skill-Specific Constraints
## Compliance Decision and Report Binding
-->