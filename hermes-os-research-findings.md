# Hermes OS / Hermes Agent Research Findings
**Date:** June 14, 2026  
**Mission:** Research latest Hermes Agent updates, GUI/web dashboard features, and "Hermes OS" ecosystem for building an integrated Hermes+OpenCode web GUI tool.

---

## 1. OFFICIAL HERMES AGENT — VERSION & RELEASE STATUS

### Latest Release: v0.16.0 — "The Surface Release" (June 5, 2026)
- **Tag:** `v2026.6.5`
- **874 commits**, **542 merged PRs**, **1,962 files changed**
- **170 community contributors**, **193K+ GitHub stars**
- **License:** MIT

**Key v0.16.0 features:**
- **Hermes Desktop App** — Native Electron app for macOS/Windows/Linux with one-click install, in-app self-update, drag-and-drop files, clipboard image paste, inline model picker, Simplified Chinese translation, concurrent multi-profile sessions. Built across 100 PRs / 159 commits.
- **Remote Gateway Connectivity** — Desktop can connect to remote Hermes gateway via OAuth or username/password (thin-client mode).
- **Web Dashboard → Full Admin Panel** — Now configures messaging channels, MCP catalog, credentials, webhooks, memory, login methods from browser. No `config.yaml` editing required.
- **`/undo [N]`** — Undo last N turns (CLI, TUI, messaging).
- **Fuzzy Model Picker** — Desktop, web, TUI, CLI. New models: `deepseek-v4-flash`, `MiniMax-M3` (1M context), `qwen3.7-plus`.
- **Leaner Default Skills** — Redundant/niche skills removed; `environments:` relevance gating; NVIDIA/skills added as trusted tap.
- **Quick Setup via Nous Portal** — First-time users choose Quick Setup or Full Setup.

### Previous Notable Releases

**v0.15.0 — "The Velocity Release" (May 28, 2026):**
- 1,302 commits, 747 merged PRs
- Major refactor: `run_agent.py` from 16,083 → 3,821 lines (-76%)
- **Kanban multi-agent platform** — Auto-decomposition, swarm topology, scheduled tasks, per-task model overrides
- **TUI session orchestrator** — Multi-session management
- **Skill bundles** — One slash command loads multiple skills
- **Bitwarden Secrets Manager** integration
- `session_search` rebuilt — 4,500× faster (no LLM, no cost)
- Promptware defense (Brainworm-class attack mitigations)

**v0.14.0 — "The Foundation Release" (May 16, 2026):**
- 808 commits, 633 merged PRs
- xAI Grok via SuperGrok OAuth (1M context)
- OpenAI-compatible local proxy (`hermes proxy`)
- `x_search` — First-class X/Twitter search tool
- Microsoft Teams integration
- Lazy-install for heavy backends; `pip install hermes-agent` works from PyPI
- 180× faster browser CDP (persistent Chrome connection)

**v0.9.0 (April 13, 2026):**
- Initial web dashboard shipped (`hermes dashboard` command)

---

## 2. OFFICIAL GUI / DASHBOARD FEATURES

### 2.1 Hermes Desktop App (Official, Electron-based)
- **URL:** https://hermes-agent.nousresearch.com/desktop
- **Platforms:** macOS 12+, Windows 10/11, Linux
- **Features:**
  - Streaming chat with live tool activity
  - Side-by-side preview rail (web pages, files, tool outputs)
  - File browser in workspace
  - Voice mode (talk to Hermes, hear replies)
  - Settings UI (providers, models, tools, MCP servers, credentials)
  - Drag-and-drop file upload
  - Inline model picker in status bar
  - Per-session YOLO toggle
  - Multi-profile concurrent sessions
  - Remote gateway connectivity (OAuth or username/password)
  - Simplified Chinese (简体中文) translation
- **Shared state:** Sessions, config, API keys, skills, memory all shared with CLI/TUI/web dashboard

### 2.2 Web Dashboard (Official, `hermes dashboard`)
- **URL:** https://hermes-agent.nousresearch.com/docs/user-guide/features/web-dashboard
- **Access:** `http://127.0.0.1:9119` (or via SSH tunnel / reverse proxy)
- **Built with:** React 19, TypeScript, Tailwind CSS v4, shadcn/ui components
- **Backend:** FastAPI + Uvicorn
- **Pages/Tabs:**
  - **Status** — Live overview (version, gateway status, active sessions, recent sessions)
  - **Chat** — xterm.js embedded TUI (WebSocket `/api/pty` spawns `hermes --tui` behind PTY)
  - **Config** — Form editor for 150+ `config.yaml` fields, organized into tabs
  - **API Keys** — Manage `.env` keys grouped by category
  - **Sessions** — Browse/search all sessions (FTS5 search), export, prune, delete
  - **Logs** — View/tail agent logs
  - **Analytics** — Token usage and cost tracking
  - **Cron** — Manage scheduled jobs
  - **Skills** — Enable/disable installed skills
  - **Admin Panel** (v0.16.0) — Messaging channels, MCP catalog, credentials, webhooks, memory, gateway management
  - **System** — Check-for-update flow, one-click Debug Share
- **Auth:** Pluggable username/password, self-hosted OIDC, refresh-token rotation
- **Themes:** 6 built-in (Hermes Teal, Midnight, Ember, Mono, Cyberpunk, Rosé) + user-defined themes
- **Plugin system:** UI plugins (JS bundles), backend plugins (FastAPI routes), all drop-in at runtime

### 2.3 Dashboard Extension System
- **URL:** https://hermes-agent.nousresearch.com/docs/user-guide/features/extending-the-dashboard
- **Three layers:**
  1. **Themes** — YAML files in `~/.hermes/dashboard-themes/`
  2. **UI plugins** — `manifest.json` + JS bundle; register tabs, override pages, inject into shell slots
  3. **Backend plugins** — Python file exposing FastAPI routes at `/api/plugins/<name>/`
- **Layout variants:** `standard`, `cockpit`, `tiled`
- **Example:** `strike-freedom-cockpit` plugin (https://github.com/NousResearch/hermes-example-plugins)

---

## 3. "HERMES OS" CONCEPT — COMMUNITY ECOSYSTEM

### 3.1 What "Hermes OS" Means (Community Definition)
"Hermes OS" is a community-coined term, NOT an official Nous Research product. It refers to a layer **on top of** Hermes Agent that provides:
- A unified Mission Control dashboard
- Multiple AI agents (Claude, Hermes, OpenClaw, etc.) in one sidebar
- Shared memory between agents
- Kanban orchestration
- Workspace preview
- Obsidian-backed memory layer
- Persistent conversation history

The core idea: Hermes Agent alone is one agent. "Hermes OS" is a conductor/orchestration layer.

### 3.2 Community "Hermes OS" Projects

| Project | Type | Stars | Key Features |
|---------|------|-------|-------------|
| **Hermes Agent OS** (agentos.guide) | Guide/System | — | Mission Control dashboard, sidebar of agents, Obsidian memory, Kanban, free |
| **ARB TECH AiOS** (arooba-ai.netlify.app) | Hackathon Project | — | Agentic UI, glassmorphism design, built for Nous Dev Challenge |
| **Memory OS** (github.com/ClaudioDrews/memory-os) | Memory Layer | 1.1k | 7-layer memory OS for Hermes Agent (Qdrant, structured facts, wiki, RAG) |
| **Agent OS Hermes** (Julian Goldie / AI Profit Boardroom) | Commercial Course | — | Paid community ($), "Goldie Mission Stack", Obsidian + OpenRouter + Kanban |

### 3.3 Architecture Deep Dives

**"Hermes Agent: The AI OS with 8 Temporal Loops"** (luonghongthuan.com):
- Technical deep-dive identifying 8 concurrent temporal loops in Hermes Agent source
- Loop 1: Core Agent (ms→minutes) — the main conversation loop
- Loops 2-8: Memory curator, skill improver, context compressor, session search, cron scheduler, user modeler, knowledge nudger
- Argues Hermes Agent IS an operating system for intelligence

**"Hermes Agent Source Code Teardown"** (fluxwise.tech):
- 141K lines Python, 74 built-in skills, 12 platform adapters, closed-loop learning
- 6 execution backends, 202 Python modules

---

## 4. COMMUNITY HERMES DASHBOARDS (Third-Party)

### Comparison of 7 Dashboards (bitdoze.com, June 2026)

| Dashboard | Stars | Language | Best For |
|-----------|-------|----------|----------|
| **Hermes WebUI** (nesquena/hermes-webui) | 14.2k | Python/JS | Full-featured chat, mobile-friendly |
| **Hermes Studio/WebUI** (EKKOLearnAI/hermes-web-ui) | 7.8k | TypeScript/Vue | Chinese platforms, one-command npm install |
| **Hermes Workspace** (outsourc-e/hermes-workspace) | 5.6k | TypeScript/React | IDE-like workspace (terminal + files + memory) |
| **Hermes Desktop** (fathah/hermes-desktop) | 12.1k | TypeScript/Electron | Native GUI, guided install, 14 toolsets |
| **Claw Admin** (itq5/OpenClaw-Admin) | 577 | Vue/TypeScript | Dual gateway (OpenClaw + Hermes), remote desktop |
| **Hermes Control Interface** (xaspx) | — | Vanilla JS | Maximum security, RBAC |
| **Scarf** (awizemann/scarf) | — | Swift/SwiftUI | Native macOS app, multi-server SSH |

**Key community dashboard features (beyond official):**
- Embedded web terminals (xterm.js in Workspace, Hermes Studio)
- File browsers/editors
- Skills marketplaces
- Multi-provider model switching
- Mobile-responsive layouts (Hermes WebUI)
- Conductor orchestrators for multi-agent task decomposition
- Chinese messaging platforms (WeChat, DingTalk, Feishu, QQ)
- Usage analytics charts
- Group-chat rooms with context compression

---

## 5. HERMES + OPENCODE INTEGRATION — EXISTING PROJECTS

### 5.1 Official Bundled Skill: `opencode`
- **Source:** Bundled with Hermes Agent (path: `skills/autonomous-ai-agents/opencode`)
- **Version:** 1.2.0
- **Function:** Delegate coding tasks to OpenCode CLI agent for feature implementation, refactoring, PR review, and long-running autonomous sessions
- **Requires:** opencode CLI installed and authenticated

### 5.2 opencode-hermes-multiagent (1ilkhamov)
- **URL:** https://github.com/1ilkhamov/opencode-hermes-multiagent
- **Stars:** 138
- **Description:** Multi-agent orchestration system for OpenCode AI with 17 specialized agents (research, planning, implementation, quality, infrastructure)
- **Architecture:** Master orchestrator → specialized agent pipelines with mandatory quality gates
- **Status:** Last updated Dec 2025 (may be stale)

### 5.3 hermes-opencode-plugin (zaycruz)
- **URL:** https://github.com/zaycruz/hermes-opencode-plugin
- **Description:** OpenCode integration plugin for Hermes Agent — dispatch coding tasks to OMO's multi-agent harness
- **Architecture:** Hermes → `opencode` tool → OMO meta-subagent → Sisyphus orchestrator → Hephaestus/Oracle/Librarian/Explore agents
- **Requirements:** Hermes Agent, OpenCode CLI ≥1.4.0, oh-my-openagent (OMO)
- **Install:** Clone into `~/.hermes/plugins/opencode`
- **Note:** OMO is optional — falls back to OpenCode's built-in `build` agent

### 5.4 OpenCode + Hermes Workflow Patterns (peterfalkingham.com)
- Pattern: LM Studio (local models) → OpenCode (coding) + Hermes (general-purpose)
- Hermes's OpenCode skill allows Hermes to fire up OpenCode and interact with it
- Use case: Complex projects needing external resources, file management, dependency installation

---

## 6. OFFICIAL HERMES AGENT KEY CAPABILITIES (v0.16.0)

### Core Architecture
- **20+ messaging platforms:** CLI, Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Mattermost, Email, SMS, DingTalk, Feishu, WeCom, Weixin, QQ Bot, Yuanbao, BlueBubbles, Home Assistant, Microsoft Teams, Google Chat, ntfy
- **6 execution backends:** Local, Docker, SSH, Daytona, Singularity, Modal
- **Closed Learning Loop:** Agent-curated memory, periodic nudges, autonomous skill creation, skill self-improvement, FTS5 cross-session recall, Honcho user modeling
- **60+ built-in tools:** web_search, x_search, terminal, patch, read_file, write_file, browser, vision_analyze, cronjob, memory, delegate_task, MCP
- **Skills system:** Open standard (agentskills.io), portable SKILL.md format, 19,932-entry skills.sh catalog (v0.15.1+), community hubs
- **MCP Support:** Connect to any Model Context Protocol server
- **Research-Ready:** Batch processing, trajectory export, RL training with Atropos

### API/Integration Points
- **OpenAI-compatible API server:** `hermes gateway` exposes at `http://127.0.0.1:8642/v1`
- **Open WebUI integration:** Official guide at docs.openwebui.com
- **WebSocket endpoints:** `/api/ws` (chat), `/api/pty` (terminal)
- **REST API:** `/api/status`, `/api/sessions`, `/api/config`, `/api/keys`, `/api/cron`, etc.
- **Plugin API:** `/api/plugins/<name>/` for custom backend routes

---

## 7. GAPS & OPPORTUNITIES (For Building Hermes OS + OpenCode Web GUI)

### What EXISTS Officially:
- ✅ Hermes Desktop (Electron app)
- ✅ Web Dashboard (React SPA, admin-focused)
- ✅ OpenCode skill (bundled, CLI-based delegation)
- ✅ Dashboard plugin system (themes, UI plugins, backend plugins)
- ✅ OpenAI-compatible API server

### What EXISTS in Community:
- ✅ Multiple third-party web UIs (varying quality)
- ✅ OpenCode-Hermes multi-agent orchestrators
- ✅ "Hermes OS" concept (community term, not official)

### What's MISSING / Opportunities:
- ❌ **No official "Hermes OS" product** — purely community-coined
- ❌ **No unified Hermes+OpenCode web GUI** that combines agent orchestration _with_ OpenCode's coding capabilities in a single dashboard
- ❌ **No drag-and-drop agent workflow builder** for visual task pipelines
- ❌ **No real-time collaborative coding surface** merging Hermes's orchestration with OpenCode's AST-level editing
- ❌ **No integrated file diff viewer** in any dashboard (showing Hermes + OpenCode edits side by side)
- ❌ **No multi-agent chat rooms** where Hermes and OpenCode agents converse
- ❌ Limited "agent OS" polish in official dashboard (it's admin-focused, not workspace-focused)
- ❌ Community dashboards focus on chat, not the full OS metaphor (workspace preview, agent orchestra, memory layer)

### Key URLs to Monitor:
- Official docs: https://hermes-agent.nousresearch.com/docs/
- GitHub: https://github.com/NousResearch/hermes-agent
- Releases: https://github.com/NousResearch/hermes-agent/releases
- Desktop download: https://hermes-agent.nousresearch.com/desktop
- Example plugins: https://github.com/NousResearch/hermes-example-plugins
- Community map: https://hermesatlas.com
- OpenCode plugin: https://github.com/zaycruz/hermes-opencode-plugin
- OpenCode multi-agent: https://github.com/1ilkhamov/opencode-hermes-multiagent
- Best dashboards comparison: https://www.bitdoze.com/best-hermes-dashboards/
- Hermes WebUI (14k stars): https://github.com/nesquena/hermes-webui
- Hermes Workspace (5.6k stars): https://github.com/outsourc-e/hermes-workspace
- Hermes Studio (7.8k stars): https://github.com/EKKOLearnAI/hermes-web-ui
- Memory OS: https://github.com/ClaudioDrews/memory-os

---

## 8. SUMMARY: BUILDING A HERMES OS + OPENCODE WEB GUI

### Existing Foundation (What You Can Build On):
1. **Hermes Agent API Server** — OpenAI-compatible endpoint at port 8642 connects to any frontend
2. **Hermes Dashboard Plugin System** — Build as a dashboard UI plugin (JS + optional FastAPI backend)
3. **OpenCode CLI** — Already integrable via Hermes's bundled `opencode` skill or the community `hermes-opencode-plugin`
4. **WebSocket/PTY** — Official dashboard already does xterm.js embedding

### Recommended Approach:
1. **Build as a Hermes Dashboard Plugin** — Leverage the official plugin system (React, Tailwind, shadcn/ui). This gives you:
   - Access to all official dashboard infrastructure (auth, profiles, sessions)
   - Drop-in distribution (users just clone into `~/.hermes/plugins/`)
   - Backend API routes via FastAPI
2. **Add OpenCode Integration** — Use/wrap the existing `hermes-opencode-plugin` or build a WebSocket bridge to OpenCode CLI
3. **Focus on the OS Metaphor** — The gap is in workspace preview, agent orchestra visualization, multi-agent chat, and the "mission control" experience
4. **Add Differentiators** — File diff viewer, agent-to-agent chat, visual pipeline builder, inline workspace preview — things NO existing dashboard has

### Key Differentiator from Existing Dashboards:
The official dashboard is admin-focused. Community dashboards are chat-focused. None provide the full "Agent OS" experience — a unified workspace where Hermes orchestrates, OpenCode codes, and the user sees everything in one place with real-time previews of all agent outputs.
