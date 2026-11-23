# 📝 Operational Learnings Store

This directory captures architectural decisions, user feedback, organizational rules, and lessons learned from past agent interactions.

---

## Ingestion Workflow
1. When a user states a rule, correction, or architectural preference (e.g., *"We always use Poetry instead of pip"*, *"Deployments must target eu-west-1"*):
2. The agent triggers the learning loop.
3. The entry is recorded in `conventions.md` under the appropriate subsystem category.
4. Future executions consult `conventions.md` to guarantee alignment.
