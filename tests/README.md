# GAIA Framework — Local Test Battery

This directory contains the automated test suites for the G.A.I.A. (Governance through Autonomous Infrastructure Agents) framework.

## Structure

```
tests/
├── run-all.sh                     # Master test suite runner
├── harness/                       # Integration & architecture tests
│   ├── test-governance.sh         # Validates CI governance rules (agents, skills, assets)
│   ├── test-agents.sh             # Validates 10 governed agent definitions & YAML frontmatter
│   ├── test-skills.sh             # Validates 41 skill definitions & frontmatter
│   ├── test-symlinks.sh           # Validates multi-platform bridge symlinks (.agents, .mcp.json)
│   ├── test-mcp-config.sh         # Validates MCP server configuration syntax & servers
│   ├── test-package.sh            # Validates package.json manifest for GitHub Packages
│   ├── test-changelog.sh          # Validates CHANGELOG.md version entries
│   ├── test-root-files.sh         # Validates existence of core documentation and architecture files
│   ├── test-encoding.sh           # Verifies no UTF-8 BOM characters exist in tracked files
│   └── test-no-secrets.sh         # Scans for leaked keys, passwords, and tokens
├── agents/                        # Unit tests for agent definitions
│   └── test-agent-definitions.sh  # Dual validation: Copilot bundles vs Antigravity subagents
└── skills/                        # Unit tests for critical skills
    └── test-skill-validation.sh   # Validates knowledge-ingest files and apollo git hooks
```

## Running the Tests

To run the entire suite:

```bash
bash tests/run-all.sh
```

Or via npm:

```bash
npm test
```

To run an individual suite:

```bash
bash tests/harness/test-governance.sh
bash tests/agents/test-agent-definitions.sh
```
