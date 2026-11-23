# 🧠 GAIA Knowledge & Continuous Feedback System

The GAIA Knowledge System provides persistent memory, few-shot demonstration examples, and a continuous feedback loop for all subroutines in the framework.

---

## Architecture & Components

```
knowledge/
├── README.md               # Architecture and guidelines for knowledge evolution
├── examples/               # Curated few-shot execution examples by domain
│   ├── scaffolding-fastapi-service.md
│   ├── terraform-aws-provisioning.md
│   ├── security-audit-and-patch.md
│   └── ci-cd-pipeline-automation.md
└── learnings/              # Learned operational patterns and user preferences
    ├── README.md
    └── conventions.md
```

### 1. Few-Shot Examples (`knowledge/examples/`)
Complex platform engineering tasks require deterministic output. Rather than generic instructions, agents reference realistic, battle-tested execution examples from this directory.
- **Scaffolding**: Complete FastAPI, .NET CQRS, and Angular service generation recipes.
- **IaC**: Production-ready AWS/Azure Terraform modules with state locking.
- **Security**: Complete CVE triage, secret eradication, and regression-free patches.
- **CI/CD**: Multi-stage GitHub Actions workflows with caching and security gates.

### 2. Operational Learnings & Feedback (`knowledge/learnings/`)
When a developer corrects an agent or establishes an organizational convention (e.g. naming conventions, dependency versions, deployment strategies):
- The learning is ingested via the `gaia-knowledge-ingest` skill.
- The learning is documented in `knowledge/learnings/conventions.md`.
- All subroutines read this directory during intent analysis to prevent repeating past mistakes.

### 3. Evolutionary Loop (APOLLO + HEPHAESTUS)
1. **User Feedback / Success Event**: A complex problem is resolved or corrected.
2. **APOLLO (Documenter)**: Extracts the technical lesson, boundaries, and checklists.
3. **HEPHAESTUS (Builder)**: Generates a new canonical `SKILL.md` bundle or updates an existing one without placeholders.
4. **Validation**: CI verifies repository governance compliance before merging.
