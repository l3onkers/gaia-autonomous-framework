# Creating Custom Skills

> Step-by-step guide to creating your own skill in the Copilot Governance Framework.

## Prerequisites

- Understanding of the [Architecture](ARCHITECTURE.md)
- Familiarity with the existing [Skills Catalog](SKILLS.md)

---

## When to Create a Skill

Create a new skill when:
- âœ… You need **reusable task-specific behavior** that an agent can delegate to
- âœ… The task has **clear inputs and outputs**
- âœ… You want to **own templates, checklists, and validation** for a specific domain
- âœ… The behavior should be **independently testable and evolvable**

Don't create a skill when:
- âŒ An existing skill already covers the use case
- âŒ You need wrapper-level routing across multiple skills (create an agent instead)
- âŒ It's a shared scaffold that belongs in governance (put it in `.github/governance/`)

---

## Step 1: Plan Your Skill

Answer these questions:

| Question | Example |
|----------|---------|
| What specific task does it perform? | "Generate a Terraform module scaffold" |
| Who calls it? | `infra-build` agent, or direct invocation |
| What inputs does it need? | Module name, provider, resource types |
| What files does it produce? | `main.tf`, `variables.tf`, `outputs.tf`, `README.md` |
| What validation criteria apply? | Terraform fmt, plan succeeds, no hardcoded values |

### Frontend Default Policy

If the skill creates a new frontend capability, prefer React first unless the repository or organization explicitly requires a different governed stack.

- React first means React + TypeScript + a documented design-system path by default.
- Angular remains valid for existing governed Angular families.
- Do not silently switch frontend stack choices inside the skill; make the stack explicit in the manifest and output contract.

---

## Step 2: Use the hephaestus agent (Recommended)

The fastest way to create a new skill:

```
@workspace Use build to create a new governed skill bundle for Terraform module scaffolding.
```

The `hephaestus` agent will:
1. Load the canonical scaffold from `.github/governance/bundles/skill/SKILL.base.tpl.md`
2. Reference the block catalog from `.github/governance/bundles/skill/SKILL.block-catalog.md`
3. Generate your skill manifest and companion files
4. Validate the result through `apollo-supervise-skill`

---

## Step 3: Manual Creation

### File Structure

```
.github/skills/{skill-name}/
â”œâ”€â”€ SKILL.md                          # Skill manifest
â”œâ”€â”€ assets/
â”‚   â”œâ”€â”€ {skill-name}.tpl.md           # Generation template
â”‚   â”œâ”€â”€ {skill-name}.checklist.md     # Validation checklist
â”‚   â””â”€â”€ ...                           # Additional templates
â”œâ”€â”€ references/                        # Reference docs (optional)
â”‚   â””â”€â”€ ...
â””â”€â”€ scripts/                           # Helper scripts (optional)
    â””â”€â”€ ...
```

### Skill Manifest Template

Create `.github/skills/{skill-name}/SKILL.md`:

```markdown
# {Skill Name}

## Purpose
- {What this skill does}
- {What it owns}
- {What it does NOT own}

## Output Contract
- {What files/artifacts it produces}
- {What format the output takes}

## Owned Assets
- `assets/{skill-name}.tpl.md` â€” {description}
- `assets/{skill-name}.checklist.md` â€” {description}

## Used By
- `{agent-name}` â€” {how the agent routes to this skill}
- Direct invocation â€” {when and how}

## Applicability
- Applies to: {when this skill should be used}
- Not applicable to: {when this skill should NOT be used}
```

---

## Step 4: Create the Template

The template (`.tpl.md`) contains the actual generation logic:

```markdown
# {Skill Name} Template

## Purpose
{Detailed description of what this template generates}

## Required Inputs
- `{variable-name}`: {description}
  - If missing, ask: `{prompt to show the user}`

## Generation Rules
{Detailed rules for how to generate the output}

## Code Examples
{Actual code templates with placeholders}

## Folder Structure
{Expected output structure}

## Completion Checklist
- [ ] {Check 1}
- [ ] {Check 2}
- [ ] {Check 3}
```

### Tips for Good Templates

1. **Be specific** â€” Include actual code examples, not just descriptions
2. **Use placeholders** â€” `{variable-name}` for user-provided values
3. **Include anti-patterns** â€” Show what NOT to do
4. **Add a completion checklist** â€” Makes validation deterministic

### Frontend Skills Guidance

For frontend-oriented skills, document the stack choice as part of the contract:

- Default to React first for new families.
- Only use Angular when the request or governed stack clearly requires it.
- Include the UI library, routing model, state strategy, and test strategy in the owned template.

---

## Step 5: Create the Checklist

The checklist (`.checklist.md`) defines validation criteria:

```markdown
# {Skill Name} Checklist

## A. Structure
- [ ] Required files exist
- [ ] Folder structure matches the template

## B. Content Quality
- [ ] No hardcoded values
- [ ] Placeholders are replaced with actual values
- [ ] Code follows the governed coding standards

## C. Safety
- [ ] No secrets or credentials in output
- [ ] No unapproved dependencies added

## D. Completeness
- [ ] All required outputs are present
- [ ] Output can be used immediately
```

---

## Step 6: Connect to an Agent (Optional)

If your skill should be routed by an agent:

1. **Edit the agent's `agent.md`** â€” Add the skill to the supported skill catalog
2. **Add routing rules** â€” Define how the agent selects your skill
3. **Update the agent's checklist** â€” Add validation for your skill's outputs

If the skill is standalone (directly invocable):
1. **Document it** in the README
2. **Add it** to `.github/AGENT.md` if it's a common entry point

---

## Step 7: Validate

Run the supervisor to check compliance:

```
@workspace Use supervisor to review .github/skills/{skill-name}/SKILL.md
```

---

## Skill Patterns

### Pattern 1: Profile Skill (routed by a hephaestus agent)

Used by `eleuthia`, `eleuthia` â€” one profile per run.

```
Agent resolves profile â†’ loads one profile skill â†’ skill generates scaffold
```

**Examples:** `eleuthia-net-api`, `eleuthia-ng-spa`

### Pattern 2: Layer Skill (composable, dependency-ordered)

Used by `eleuthia` â€” multiple layers per run in dependency order.

```
Agent resolves layers â†’ expands dependencies â†’ executes skills in order
```

**Examples:** `eleuthia-py-environment`, `eleuthia-py-api`

### Pattern 3: Specialist Skill (single-purpose)

Used by `minerva`, `apollo` â€” one specialized task.

```
Agent routes request type â†’ specialist skill handles one concern
```

**Examples:** `minerva-review`, `apollo-supervise-agent`

### Pattern 4: Reference Skill (provides data, not output)

Used by `eleuthia` for UI composition â€” consulted but doesn't produce files.

```
Agent loads references â†’ skill provides component/layout/style data â†’ agent uses in output
```

**Examples:** `eleuthia-ui-components`, `eleuthia-ui-mockups`, `eleuthia-ui-styles`

---

## Checklist: Before You Submit

- [ ] `SKILL.md` follows the governance structure
- [ ] Template includes complete generation rules
- [ ] Checklist covers structure, quality, and safety
- [ ] Skill has been validated through `apollo-supervise-skill`
- [ ] Documentation is updated (README, AGENTS.md if agent-routed)
