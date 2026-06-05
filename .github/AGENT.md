# Repository Agent Guide

## Purpose

Use this file as the first routing guide when an LLM is asked to work in this repository.

The repository's callable coordinators live under `.github/agents/`. Reusable delegated behavior lives under `.github/skills/`. Start by identifying the right top-level agent, then load only the files that agent resolves for the current run.

## Required lookup order

1. If the user does not know which agent to use, start with `.github/agents/gaia.agent.md` â€” it will route the request to the strongest matching agent or skill.
2. Inspect `.github/agents/` to identify the available top-level coordinators.
3. Read the matching `.github/agents/{name}.agent.md` entrypoint for the requested outcome.
4. Load only the skills, templates, checklists, and governance assets declared by that entrypoint.
5. Keep routing thin: do not invent new entrypoints, new skills, or extra workflow steps unless the governed files explicitly require them.

## Current agent index

The current callable agent entrypoints under `.github/agents/` are:

| Agent | Path | Use when |
|-------|------|----------|
| `gaia` | `.github/agents/gaia.agent.md` | General-purpose routing when the user does not know which agent to use |
| `hephaestus` | `.github/agents/hephaestus.agent.md` | Authoring or updating one bounded governed bundle or governance artifact |
| `apollo` | `.github/agents/apollo.agent.md` | Generating or refreshing governed documentation such as `README.md` |
| `eleuthia` | `.github/agents/eleuthia.agent.md` | Routing one `.NET`, Angular, or Python build request to the correct governed profile or layer skills |
| `minerva` | `.github/agents/minerva.agent.md` | Routing security requests to specialized skills, or generating the repository security audit |

Agent-local companion assets may also exist under `.github/agents/<agent>/`. Those directories support the matching entrypoint and are not separate callable agents.

## Git workflow rule

Any git branch, commit-message, or pull-request action in this repository must use `.github/skills/apollo-git-workflow/SKILL.md`.

## Frontend policy

Any frontend request in this repository must route through the matching governed coordinator before implementation.

- Angular frontend work must route through `.github/agents/eleuthia.agent.md` and use the governed Angular profile assets.
- Governed corporate components, mockup layouts, and global-style references are the default implementation source for Angular UI work, not optional inspiration.
- Do not improvise generic headers, dashboards, sidebars, menus, tables, or card grids when a governed corporate pattern already covers the request.
- If the governed frontend assets do not clearly cover the requested UI, stop and ask for clarification or call out the gap instead of free-designing the screen.

## Working conventions

- Prefer the smallest compatible path for the request.
- Keep agents thin and let skills own detailed behavior, templates, checklists, and validation.
- Use `.github/governance/` only when the selected agent or skill points to neutral governance assets.
- If documentation or inventories mention available agents, verify them against the current contents of `.github/agents/` before finalizing output.
