# 🚀 GAIA Multi-Platform Deployment & Configuration Guide

This guide details how to configure, deploy, and operate the **GAIA Autonomous Framework** across different AI developer environments and harnesses.

---

## 🧭 Multi-Platform Compatibility Matrix

| Surface / Tool | Configuration File | Discovery Mechanism | Primary Interaction Style |
| :--- | :--- | :--- | :--- |
| **Antigravity 2.0 App** | `.agents/`, `AGENTS.md`, `mcp_config.json` | Automatic project walk | Visual Chat Canvas + Auxiliary Subagents Pane |
| **Antigravity CLI (`agy`)** | `AGENTS.md`, `.agents/skills.json` | Project root discovery | Terminal TUI, Slash Commands & Headless Tasks |
| **GitHub Copilot** | `.github/AGENT.md`, `.github/agents/` | Native Copilot Chat indexing | `@workspace Use <subroutine>` |
| **Cursor / Claude Code** | `AGENTS.md`, `.mcp.json` | Root markdown & MCP detection | Chat pane & Terminal Agent commands |

---

## 1. Antigravity 2.0 Desktop Application

The **Antigravity 2.0 App** is an AI-first desktop development platform powered by Gemini models, featuring subagent visualization, background task monitors, and interactive artifacts.

### 🛠️ Configuration & Setup
1. **Open Workspace:**
   - Launch Antigravity 2.0 App.
   - Click **Projects > Open Folder** and select the `gaia-autonomous-framework` directory.
2. **Customization Ingestion:**
   - Antigravity immediately discovers `AGENTS.md` at the project root as hierarchical rules.
   - Discovers `.agents/skills.json` which progressively exposes the 40+ governed skills without context exhaustion.
3. **Subagents Verification:**
   - Open the **Auxiliary Pane** on the right side and navigate to the **Subagents** tab.
   - You will see the 10 registered GAIA agents: `gaia`, `hephaestus`, `minerva`, `eleuthia`, `apollo`, `demeter`, `aether`, `hades`, `poseidon`, `artemis`.
4. **Tool Execution Policies:**
   - Navigate to **Settings > Tool Execution Policy**.
   - Recommended development setting: `proceed-in-sandbox` or `request-review` for production operations.

### 💡 Usage in Chat Canvas
- **Orchestration:**  
  Type: `"GAIA, necesitamos crear un microservicio de autenticación en Python con base de datos PostgreSQL y pipeline CI/CD."`  
  *GAIA will analyze intent and spin up ELEUTHIA (FastAPI), POSEIDON (Flyway migrations), and HEPHAESTUS (Docker/Actions) in parallel.*
- **Direct Delegation:**  
  Mention the subagent directly or prompt: `"Minerva, escanea el repositorio en busca de secretos y dependencias vulnerables."`

---

## 2. Antigravity CLI (`agy`)

The **Antigravity CLI (`agy`)** provides a terminal interface for running autonomous workflows, interactive pair programming, and automated background jobs.

### 🛠️ Setup & Launch
1. **Install / Verify CLI:**
   ```bash
   agy --version
   ```
2. **Navigate to Repository:**
   ```bash
   cd gaia-autonomous-framework
   ```
3. **Start Interactive Session:**
   ```bash
   agy
   ```
   *`agy` automatically loads `AGENTS.md` and links `.agents/skills.json`.*

### ⚡ Available Workflows in `agy`
- **Interactive Prompts:**
  ```text
  agy> Demeter, genera los módulos de Terraform para una VPC en AWS eu-west-1 con backend remoto.
  ```
- **Slash Commands:**
  - `/help`: Display active slash commands and available toolsets.
  - `/plan`: Request a step-by-step architectural breakdown before executing code modifications.
  - `/goal`: Launch a long-running, autonomous task where the agent will not stop until the objective is completed.
- **Headless Execution (CI/CD or Background Scripts):**
  You can run GAIA routines non-interactively directly from your shell or pipelines:
  ```bash
  agy -p "Minerva, ejecuta un análisis de vulnerabilidades y emite un reporte markdown en docs/reports/security.md"
  ```

---

## 3. GitHub Copilot (VS Code & JetBrains)

GAIA was initially designed around GitHub Copilot's `@workspace` architecture.

### 🛠️ Setup & Usage
1. Open the repository in Visual Studio Code with the **GitHub Copilot** and **GitHub Copilot Chat** extensions enabled.
2. Copilot Chat automatically reads `.github/AGENT.md` upon initial session startup.
3. **Triggering Sub-routines:**
   - Ambiguous request:
     ```text
     @workspace Use gaia to prepare the architecture for a new .NET microservice with a database.
     ```
   - Direct subroutine call:
     ```text
     @workspace Use minerva to run a security review and secret scan on the latest commits.
     ```
     ```text
     @workspace Use artemis to generate a k6 load test script targeting our API gateway.
     ```

---

## 4. Cursor & Claude Code

GAIA adheres to open agentic standards (`AGENTS.md`, `mcp_config.json`, and standard `SKILL.md` bundles).

### 🛠️ Setup
1. **Cursor:**
   - Cursor automatically discovers project rules in `AGENTS.md`.
   - MCP tools are loaded via `.mcp.json` (symlinked from `mcp_config.json`).
2. **Claude Code:**
   - Claude Code parses root instructions and connects to stdio MCP servers declared in `.mcp.json`.
   - Command:
     ```bash
     claude "Usa Hephaestus para auditar y generar el workflow de CI de este proyecto."
     ```

---

## 5. Model Context Protocol (MCP) Integration

The repository includes a governed `mcp_config.json` at the root and in `.agents/mcp_config.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "${DATABASE_URL}"]
    }
  }
}
```

### Activating Remote Credentials
- Export `GITHUB_TOKEN` in your environment before launching `agy` or the Antigravity App to enable GitHub API tools for **HEPHAESTUS** and **MINERVA**.
- Export `DATABASE_URL` to enable live PostgreSQL schema inspection for **POSEIDON**.
