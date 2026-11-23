# 📜 Changelog

All notable changes to the **GAIA Autonomous Framework** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2026-11-23

### 🚀 Added
- **Multi-Platform Support:** Canonical root `AGENTS.md` and `.agents/skills.json` configuration for seamless native discovery in **Antigravity 2.0 App** and **Antigravity CLI (`agy`)**, as well as Cursor and Claude Code.
- **Active Ensamble-Harness (MCP):** Configured unified Model Context Protocol (`mcp_config.json`, `.agents/mcp_config.json`, and `.mcp.json`) exposing GitHub, PostgreSQL, Docker, and Filesystem tools to autonomous subroutines.
- **Executable Subagent Definitions:** Added `.agents/agents/*.md` definitions for all 10 core subroutines (`gaia`, `hephaestus`, `minerva`, `eleuthia`, `apollo`, `demeter`, `aether`, `hades`, `poseidon`, `artemis`) with dedicated tool grants and Zero Trust boundaries.
- **Knowledge & Continuous Feedback System:**
  - `knowledge/examples/`: Battle-tested, placeholder-free few-shot implementation guides for FastAPI, AWS Terraform, Zero Trust security patching, and CI/CD pipelines.
  - `knowledge/learnings/`: Persistent memory store for operational rules and architecture preferences (`conventions.md`).
  - `gaia-knowledge-ingest`: New governed skill (`.github/skills/gaia-knowledge-ingest/`) allowing APOLLO and HEPHAESTUS to ingest feedback and forge new skills/rules.
- **Multi-Platform Deployment Guide:** Comprehensive documentation in [docs/PLATFORMS.md](docs/PLATFORMS.md) covering setup and operation in Antigravity App, `agy`, Copilot, and Cursor.
- **Release & Package Automation:** Added root `package.json` for GitHub Packages distribution and `.github/workflows/release.yml` for automated SemVer tagging and GitHub Release generation.

### 🧹 Changed & Optimized
- **Root Directory Cleanup:** Removed empty placeholder directories (`src/`, `connectors/`, `environment/`, `logger/`, `tests/`) from the root, preserving a clean platform engineering framework architecture.
- **Encoding Normalization:** Stripped hidden UTF-8 BOM (`\xef\xbb\xbf`) across 120+ markdown and YAML manifests to guarantee 100% universal parsing compliance across all OS platforms and LLM tools.
- **Documentation Refresh:** Updated `README.md` and `QUICKSTART.md` with multi-platform quickstart instructions and platform compatibility matrix.

---

## [1.0.0] - 2026-09-19

### 🚀 Added
- **Initial Release:** 10 core autonomous platform engineering sub-routines (GAIA Core, HEPHAESTUS, MINERVA, ELEUTHIA, APOLLO, DEMETER, AETHER, HADES, POSEIDON, ARTEMIS).
- **Governed Skills Layer:** 40 specialized skills covering .NET, Python, Angular, Terraform, Istio, Flyway, Chaos Mesh, and k6 testing.
- **Zero Trust Governance:** Deterministic templates, checklists, and CI governance validation workflow (`.github/workflows/validate-gaia-structure.yml`).
