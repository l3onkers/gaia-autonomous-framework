# Documentator Coordination Checklist

## Skill Resolution
- [ ] Exactly one documentation skill was selected for the run
- [ ] The selected skill exists under `.github/skills/<skill-name>/SKILL.md`
- [ ] The selected skill was discovered from the documentation skill catalogue using the agreed candidate rule
- [ ] If multiple documentation skills existed and no exact designation resolved them, the current valid skill catalogue was shown before generation began
- [ ] The selected skill was loaded before any skill-owned assets, references, or validation artifacts were used

## Scope & Ownership
- [ ] The selected skill explicitly owned the output scope for the run
- [ ] Only the selected skill's assets, references, and validation artifacts were used
- [ ] No files outside the selected skill's declared output scope were modified
- [ ] No second documentation skill was loaded or blended into the same run

## Content & Governance
- [ ] Document-specific structure, fill, and asset-selection rules came from the selected skill, not the coordinator agent
- [ ] No speculative or inferred content was introduced beyond the selected skill's declared policy
- [ ] The selected skill's declared validation artifacts were completed before finalization

## Final Sanity Check
- [ ] The coordinator remained skill-agnostic and did not hard-code a specific document type
- [ ] The final result is attributable to one selected documentation skill
- [ ] No cross-skill leakage, fallback, or mixed ownership remains
