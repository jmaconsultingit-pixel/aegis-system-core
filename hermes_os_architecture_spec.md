# Hermes Agentic OS — Unified Architecture Specification

*Extracted from 4 Itssssss_Jack YouTube transcripts (zqUdtL5l9yM, 7xuWZ-3lyQE, yaMcm3sQswc, awRQWBvE5eQ)*

---

## 1. TECH STACK

### Frontend
| Component | Technology | Source |
|-----------|-----------|--------|
| **Dashboard UI** | Web-based HTML/CSS/JS dashboard (custom-built) | All 4 transcripts |
| **Desktop shell** | Claude Code operating system wrapper | zqUdtL5l9yM, 7xuWZ-3lyQE |
| **Voice dictation** | Glider (glider.com) — fastest speech-to-text | yaMcm3sQswc, 7xuWZ-3lyQE |
| **Chat interface** | Built-in web chat window + Telegram client | 7xuWZ-3lyQE |
| **Document preview** | HTML renderer inline, filtering by type (code/data/HTML/markdown/text) | zqUdtL5l9yM |
| **Model selection UI** | Ollama desktop app for local models | yaMcm3sQswc |

### Backend / Core Runtime
| Component | Technology | Source |
|-----------|-----------|--------|
| **Primary agent** | Hermes Agent (Nous Research) | All 4 transcripts |
| **Agent runtime** | Runs locally as a CLI/background service | 7xuWZ-3lyQE, yaMcm3sQswc |
| **CLI entry point** | `hermes setup model` for model config; `hermes` commands | 7xuWZ-3lyQE, awRQWBvE5eQ |
| **Local model server** | Ollama (ollama.com) | yaMcm3sQswc |
| **Code graph tool** | Code Graph (separate GitHub repo) for dependency mapping | zqUdtL5l9yM |
| **Telegram bridge** | Telegram Bot API for mobile access | 7xuWZ-3lyQE |
| **Model router** | Open Router (openrouter.ai) | awRQWBvE5eQ |
| **Automation connector** | Zapier MCP server (Model Context Protocol) | 7xuWZ-3lyQE |
| **Knowledge base** | Obsidian vault integration | 7xuWZ-3lyQE |
| **Git backup** | Private GitHub repo mirror for config + personas | 7xuWZ-3lyQE |

### Connection to Hermes Agent
| Detail | Value | Source |
|--------|-------|--------|
| **Protocol** | Direct CLI invocation / API / chat text | 7xuWZ-3lyQE, awRQWBvE5eQ |
| **Mobile bridge** | Telegram Bot (BotFather → token → user ID whitelist) | 7xuWZ-3lyQE |
| **Zapier bridge** | MCP server (substitute "Hermes" for "Open Claw" in config) | 7xuWZ-3lyQE |
| **Local models** | Ollama → Hermes Agent (64K context minimum required) | yaMcm3sQswc |
| **Cloud models** | Open Router API key → `hermes setup model` → provider selection | awRQWBvE5eQ |

### LLM / Model Integration
| Provider | Models | Source |
|----------|--------|--------|
| **Open Router** | Opus 4.7, GPT-5.5, DeepSeek, Meta Llama, Mercury (free tier) | awRQWBvE5eQ, 7xuWZ-3lyQE |
| **Ollama (local)** | Qwen 3 30B, Qwen 3 Coder 64K, Qwen 532B | yaMcm3sQswc |
| **Anthropic (native)** | Claude Code (Opus 4.8 referenced as benchmark) | awRQWBvE5eQ |
| **Direct provider** | DeepSeek API (BYOK via Open Router to avoid rate limits) | awRQWBvE5eQ |

---

## 2. COMPLETE FEATURE LIST

### Core Agent Features
1. **Multi-model orchestration** — Assign different models per persona/task
2. **Persistent memory** — Agent memory file, user profile, soul.md
3. **GitHub backup** — Config, personas, and memory versioned; rollback support
4. **Cron scheduling** — Scheduled tasks (morning briefs, nightly reflection)
5. **Background tasks** — `/background` tasks that run independently
6. **Steer command** — `/steer` redirects agent without interrupting flow
7. **Clarification questions** — Agent confirms understanding before building
8. **Hands-free mode** — Voice input via Glider dictation
9. **Branch conversations** — Fork chats for parallel exploration paths
10. **Token fallback** — If primary model tokens exhausted, fallback to cheaper model

### Pantheon AI Personas
11. **Philosopher** — Deep questioning, surface assumptions, reframe problems
12. **Mercury** — Lightweight/free model for background tasks (cron, autopilot)
13. **Labyrinth** — Deep research persona for multi-source synthesis
14. **Orpheus (Triad)** — Conductor (Opus) → Worker (DeepSeek) → Critic (GPT-5.5) loop
15. **Lab R&D** — Research and development persona
16. **Custom personas** — Create any persona with name, job description, flow, and assigned model

### Document Management System
17. **Document interface** — Visual grid of all created documents (invoices, HTML, etc.)
18. **Filter by type** — Code, Data, HTML, Markdown, Text
19. **Search** — Full-text search across documents
20. **Live sync** — Changes reflected instantly in dashboard
21. **Delete/remove** — Remove documents from the interface
22. **Visual preview** — Click to view HTML/invoice preview inline
23. **Hermes folder** — Desktop folder synced with dashboard

### Knowledge & Memory System
24. **Obsidian vault integration** — Hermes reads and references user's Obsidian notes
25. **Agent memory** — Conversation context, user facts, system state
26. **User profile** — Personal details, preferences
27. **soul.md** — Identity, mission, goals, business info, revenue metrics, voice style
28. **Claude OS Bridge** — Hermes reads Claude Code chat logs for cross-system context
29. **Auto-dreaming** — Nightly cron: proactive reflection on all conversations for improvement suggestions

### Integration Ecosystem
30. **Telegram** — Full mobile access; user ID whitelist for security
31. **GitHub** — Create repos, clone repos, manage code directly
32. **Apollo.io API** — Lead scraping, prospecting briefs, company research
33. **Google Calendar** — Read events, create events, find busy periods
34. **Gmail (via Zapier)** — Draft emails, find emails, add labels (NO send — principle of least access)
35. **Zapier MCP** — Universal connector for any tool with MCP server support
36. **Code Graph** — Pre-build code structure graph (82% token savings)

### Privacy / Deployment Modes
37. **Vault mode** — Fully local, private model for sensitive data
38. **Connected mode** — Cloud models for performance (best quality answer)
39. **Hybrid mode** — Dynamically route to local or cloud per task
40. **Local model hosting** — Ollama for offline, zero-cost, private inference

### Business Use Cases
41. **Prospecting briefs** — Apollo-powered lead research with company details
42. **Morning briefs** — Scheduled daily summaries and actionable items
43. **Invoice generation** — Create HTML invoices via natural language
44. **Email drafting** — AI drafts emails for review (never auto-send)
45. **Niche analysis** — Multi-model triad for business strategy decisions

---

## 3. ARCHITECTURE PATTERNS

### High-Level Architecture
```
┌─────────────────────────────────────────────────────────┐
│                     USER INTERFACES                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────┐ │
│  │  Claude   │  │ Telegram │  │ Dashboard│  │ Glider │ │
│  │ Code OS   │  │   App    │  │   (Web)  │  │(Voice) │ │
│  └────┬──────┘  └────┬─────┘  └────┬─────┘  └───┬────┘ │
└───────┼──────────────┼─────────────┼─────────────┼──────┘
        │              │             │             │
        ▼              ▼             ▼             ▼
┌─────────────────────────────────────────────────────────┐
│                    HERMES AGENT CORE                     │
│  ┌────────────┐  ┌──────────┐  ┌───────────────────┐  │
│  │  Pantheon   │  │  Memory  │  │  Cron Scheduler   │  │
│  │  Personas   │  │  System  │  │  (Morning/Night)  │  │
│  └────────────┘  └──────────┘  └───────────────────┘  │
│  ┌────────────┐  ┌──────────┐  ┌───────────────────┐  │
│  │  Document   │  │  Skills  │  │  Connectors       │  │
│  │  Manager    │  │  System  │  │  (Zapier/GitHub)  │  │
│  └────────────┘  └──────────┘  └───────────────────┘  │
└──────────────────────┬──────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
┌───────────┐  ┌───────────┐  ┌───────────────┐
│  Ollama   │  │Open Router│  │  Direct APIs  │
│ (Local)   │  │ (Cloud)   │  │ (DeepSeek,    │
│ Qwen 3    │  │ Opus/GPT  │  │  Anthropic)   │
└───────────┘  └───────────┘  └───────────────┘
```

### Key Architectural Patterns

**1. Persona-as-Skill (Agent Delegation Pattern)**
- Each Pantheon persona is a file in a dedicated folder
- Personas have: name, job description, flow (multi-step prompt), assigned orchestrator model
- Changing a persona file auto-syncs to Hermes (folder-watch)
- Personas can invoke sub-models (triad: Conductor → Worker → Critic)

**2. Multi-Brain / Multi-Model Orchestration**
- One model orchestrates (Opus 4.7), delegates work to cheaper/faster models (DeepSeek, Llama)
- Critic model (GPT-5.5) reviews output before final delivery
- Token-aware fallback: if expensive model runs out of tokens, fallback to cheaper
- Cost optimization: 95% of value for 1% of cost using DeepSeek for heavy lifting

**3. Privacy Tier / Model Routing**
- Three operating modes: Vault (local), Connected (cloud), Hybrid (dynamic)
- Hermes can be told: "send this to the private model" or "use my cloud model"
- Local models require 64K context window minimum for Hermes compatibility
- Future-proof: local models ~12 months behind frontier, rapidly catching up

**4. Folder-Sync Document Management**
- Dedicated Hermes folder on desktop
- Automatic sync with dashboard document interface
- Non-Git files excluded from document view
- Supports: images, HTML invoices, markdown, code, data

**5. External Tool Integration via MCP (Model Context Protocol)**
- Zapier MCP server provides tool backbone
- Tools connected via principle of least access (e.g., Gmail: draft only, no send)
- Hermes substituted for "Open Claw" in MCP config
- Supported: Google Calendar (read/write events), Gmail (draft/find), Apollo API

---

## 4. UI DESIGN DECISIONS

### Dashboard Layout (Top to Bottom)
1. **Connections bar** — Shows all integrated services with status indicators
2. **Active model display** — Currently selected model + weekly usage stats
3. **Chat window** — Conversation history, multi-session (Telegram + Web unified)
4. **Skills section** — Installed skills/connectors with status
5. **Document interface** — Grid of documents (4-5 per row), filterable by type
6. **Command center** — Terminal output, CLI integrations visible (GitHub)

### Design Principles
- **Follow existing design structure** — New features match existing dashboard patterns
- **Visual-first** — User prefers seeing things visually over chat-only text
- **Interactive & gorgeous** — Design priority stated across all videos
- **Filter by type** — Documents filterable by: Code, Data, HTML, Markdown, Text
- **Live updates** — Changes reflected immediately without manual refresh
- **Mobile via Telegram** — Same Hermes accessible on phone through Telegram
- **Hands-free** — Voice dictation enables yapping-driven workflows
- **One-click install** — Installation prompts for replicating any feature

---

## 5. PER-TRANSCRIPT BREAKDOWN

### Transcript 1 (zqUdtL5l9yM): Document Management System
- **Focus**: Building features inside the dashboard
- **Key tech**: Code Graph (82% token savings), HTML document interface
- **Frontend**: Web dashboard, Claude Code OS shell
- **Process**: Clarify → mockup on localhost → build → finalize
- **Commands**: `/steer` (redirect), `/background` (separate tasks)
- **New component**: Document management with filtering/search/preview/delete

### Transcript 2 (7xuWZ-3lyQE): Full Setup & Integration Ecosystem
- **Focus**: End-to-end Hermes setup, Pantheon AI, integrations
- **Key tech**: Telegram bot, Obsidian vault, Apollo API, Zapier MCP
- **Backend**: `hermes setup model` CLI, GitHub backup/mirror
- **Pantheon**: Philosopher, Mercury, Labyrinth (folder-based auto-sync)
- **Memory**: Agent memory, user profile, soul.md, Claude OS Bridge
- **Cron**: Nightly reflection with cheap model delegation
- **Security**: User ID whitelist for Telegram; principle of least access for tools

### Transcript 3 (yaMcm3sQswc): Local Private Deployment
- **Focus**: Running Hermes 100% privately and free
- **Key tech**: Ollama, Qwen 3 models (30B, Coder 64K)
- **Constraint**: Local models must have 64K context window for Hermes
- **Three tiers**: Vault (local/private), Connected (cloud/perf), Hybrid
- **Cost**: $0/token for local models (speed = your machine)
- **Philosophy**: Not ideological — use best model for the job

### Transcript 4 (awRQWBvE5eQ): Multi-Model Brain & Triad Persona
- **Focus**: Advanced multi-model orchestration with Open Router
- **Key tech**: Open Router BYOK, Triad persona (Orpheus)
- **Triad flow**: Conductor (Opus) → Worker (DeepSeek) → Critic (GPT-5.5) → Synthesis
- **soul.md**: Detailed personal/business context for personalization
- **Token fallback**: Graceful degradation to cheaper model
- **Branch**: Fork conversations for parallel exploration

---

## 6. DEPLOYMENT METHOD

1. **Install Hermes Agent** — CLI tool (downloaded/installed locally)
2. **Setup models** — `hermes setup model` → select providers (local Ollama + cloud Open Router)
3. **Configure Telegram** — BotFather → token → user ID whitelist
4. **GitHub backup** — Mirror config + personas to private repo (versioned, rollback)
5. **Obsidian vault** — Connect for genetic memory/knowledge base
6. **Zapier MCP** — Connect tools (Gmail, Calendar, Apollo etc.)
7. **Build dashboard** — Hermes builds Claude Code OS dashboard via prompts
8. **Add personas** — Create Pantheon personas in dedicated folder (auto-syncs)
9. **Set cron** — Schedule morning briefs, nightly reflection
10. **One-click replication** — Installation prompts shared in Jack's community

---

## 7. KEY INSIGHTS

- **Hermes is NOT a single application** — it's an agent framework orchestrating Claude Code, local LLMs, cloud APIs, and external tools through a unified dashboard
- **The "operating system" metaphor** is literal: a web dashboard wrapping Claude Code with persistent memory, scheduled tasks, document management, and multi-model orchestration
- **Privacy is configurable**, not absolute — hybrid model routing lets users choose per-task
- **Personas are files**, not hardcoded features — folder-based design enables infinite customization
- **Cost optimization** is a first-class concern — token savings via Code Graph (82%), cheap model delegation for background tasks, and DeepSeek's 95%-value-for-1%-cost ratio
- **Security posture**: whitelist-only Telegram access, Gmail draft-only (no send), separate local models for proprietary data
