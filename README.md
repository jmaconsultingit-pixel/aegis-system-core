# AEGIS Sentinel — Full System Inventory

**Phase 8 Install + Phase 9 Council + Phase 10 Validated + Phase 11 OpenSpace + Phase 12 Council Agents + Phase 13 MCP Wiring + Phase 14 n8n Bridge · Rebuild #4 · May 17, 2026**

---

## LIVE OPERATIONS — BACKUP & REMOTE

| Status | Detail |
|--------|--------|
| **Last Backup** | `SYSTEM_CORE_GOLDEN_20260516-134404` |
| **Backup Destination** | `O:\Apex_Aegis\backups\` |
| **Files Backed Up** | 24,225 files / 340 MB |
| **GitHub Remote** | CONNECTED |
| **Repository** | [jmaconsultingit-pixel/aegis-system-core](https://github.com/jmaconsultingit-pixel/aegis-system-core) |
| **Remote Branch** | `main` (tracking `origin/main`) |
| **Last Commit** | AEGIS REBUILD #4: N8N BRIDGE MCP SERVER DEPLOYED |
| **System State** | LOCKED — All operations verified |
| **Config Size** | 48.75 MB (+0.17 MB drift) — GREEN |

## AEGIS COUNCIL LOAD REPORT

- Council agents deployed: 11 / 11
- Council skills deployed: 12 / 12
- Aegis plugins deployed: 4 / 4
- MCP servers wired: 5 / 5
- MCP transport: local stdio (n8n bridge uses network to Node .248)
- AGENTS.md injected: 344 lines
- Golden config synced: PARITY VERIFIED
- opencode.jsonc updated: instructions + skills + plugins + mcp
- Config drift: +0.17 MB (GREEN)
- APRE review score: 8.55 / 10 — TIER 1
- Veto check: ALL PASS

## Packages Installed

| Package | Version | Source | Status |
|---------|---------|--------|--------|
| `ecc-agentshield` | 1.4.0 | [ecc.tools](https://ecc.tools) | PASS |
| `superpowers` | 0.0.2 | npm registry | PASS |
| `ecc-universal` | 1.10.0 | [ecc.tools/skills](https://ecc.tools/skills) | PASS |
| `openspace` | 0.1.0 | [HKUDS/OpenSpace](https://github.com/HKUDS/OpenSpace) | PASS |

## MCP Servers — Wired to OpenCode

Location: `opencode.jsonc` `mcp` block · Transport: local stdio (n8n bridge uses network to Node .248)

| Server | Type | Command | Timeout | Status |
|--------|------|---------|---------|--------|
| **Gmail** | local stdio | `gmail-mcp.cmd` | 30s | WIRED |
| **OpenSpace** | local stdio | `python -m openspace.mcp_server` | 120s | WIRED |
| **TrendShift RSS** | local stdio | `python rss_mcp_server.py` | 15s | WIRED |
| **TrendShift HF** | local stdio | `python hf_mcp_server.py` | 15s | WIRED |
| **AEGIS n8n Bridge** | local stdio | `python mcp_server.py` | 120s | WIRED |

**MCP tools available:**
- **Gmail:** Email read, send, search, labels, attachments (OAuth)
- **OpenSpace:** `execute_task`, `search_skills`, `fix_skill`, `upload_skill`
- **TrendShift RSS:** `fetch_rss_feed(url, limit)` — structured feed data
- **TrendShift HF:** `get_trending_models(limit, task)` — HuggingFace trends
- **AEGIS n8n Bridge:** `n8n_list_workflows`, `n8n_execute_workflow(id, data)`, `n8n_get_execution(id)` — bridges OpenCode to n8n workflows on Node .248
  - **L1-L4 Bouncer:** Injects `classification_level` and `allowed_storage` into every workflow payload. Enforces data sovereignty by blocking L3+ data from cloud-enabled workflows. Workflow allowlist validates target workflow against `n8n-webhook-allowlist.json` before execution.

`n8n-webhook-allowlist.json` is stored on the NAS (`\\[NODE_220_TS]\Obsidian_Vault\Apex_Aegis\Config\`) alongside `.env` for centralized credential management.

## Council Agents — Deployed to OpenCode

Location: `~/.config/opencode/agents/` · Config: `opencode.jsonc` · Golden: `C:\Aegis_System\Config\OpenCode\golden\`

| Agent | Mode | Domain | Authority |
|-------|------|--------|-----------|
| `@titan` | subagent | Macro Strategy, ROI, Wealth | High |
| `@navigator` | subagent | 20-Year Roadmap, Milestones | High |
| `@architect` | subagent | n8n, System Design, Agent Mesh | High |
| `@shield` | subagent | Data Sovereignty, L1-L4, Encryption | CRITICAL |
| `@warden` | subagent | Network Security, Perimeter | CRITICAL |
| `@auditor` | subagent | CRA Compliance, Tax Strategy | CRITICAL |
| `@chancellor` | subagent | Bookkeeping, Cash Flow, FX | Medium-High |
| `@catalyst` | primary | Execution, State, Burnout | HARD GATE |
| `@oracle` | subagent | Trends, Signals, AI Future | Advisory-High |
| `@sentinel-warden` | subagent | Physical Security, Hardware | Medium |
| `@apre` | subagent | Peer Review Scoring Engine | Governance |

## Council Skills — Deployed to OpenCode

Location: `~/.config/opencode/skills/` · Source: O: drive + backup

| Skill | Purpose |
|-------|---------|
| `apre-review` | Score proposals (Alignment/Security/Logic/Focus) |
| `council-vote` | Weighted council consensus protocol |
| `configure-ecc` | Interactive ECC installer wizard |
| `data-classify` | L1-L4 classification enforcement |
| `tax-calendar` | CRA deadlines, TFSA/RRSP, GST/HST |
| `skill-stocktake` | Audit skills quality & coverage |
| `daily-log` | State tracking, wins, blockers, streaks |
| `memory-management` | Persistent cross-session context |
| `task-management` | Priority system, WIP limits, projects |
| `bank-reconciliation` | Ledger matching, variance detection |
| `journal-entry` | Double-entry bookkeeping preparation |
| `compliance-monitoring` | CRA + PIPEDA + corporate governance |

## Aegis Plugins

Location: `~/.config/opencode/plugins/`

| Plugin | Hooks |
|--------|-------|
| `aegis-memory.ts` | session.compacting, tool.execute.after, message.updated, session.idle |
| `apre-gate.ts` | file.edited, tool.execute.before |
| `model-fallback.ts` | session.error (credit/quota exhaustion detection) |
| `vault-sync.ts` | session.created (backup + vault sync) |

## The High Council — Decision Engine

Location: `O:\Apex_Aegis\Council\` (source) · Agents: `~/.config/opencode/agents/` (deployed) · Governance: `Council_Governance_Charter.md` v3.1

| Role | Domain | Authority |
|------|--------|-----------|
| **THE TITAN** | Macroeconomic Strategy · Systemic Risk · Decision Architecture | High |
| **THE NAVIGATOR** | Roadmap · Timing · Priority · 20-Year Vision | High |
| **THE ARCHITECT** | n8n Orchestration · Agent Mesh · System Logic | High |
| **THE SHIELD** | Data Sovereignty · Encryption · Key Management | CRITICAL |
| **THE WARDEN** | Network Security · Perimeter Defense · Hardware | CRITICAL |
| **THE AUDITOR (CRA)** | Tax Compliance · Legal Review · CRA Regulations | CRITICAL |
| **THE CHANCELLOR** | Cash Flow · Burn Rate · Bookkeeping · Liquidity | Medium-High |
| **THE CATALYST** | State Management · Execution Speed · Burnout Prevention | HARD GATE |
| **THE ORACLE** | Trend Prediction · Signal Intelligence · Future-Proofing | Advisory-High |
| **THE SENTINEL WARDEN** | Physical Security · Environmental · Facility Risk | Medium |

## APRE — Peer Review Engine

Location: `O:\Apex_Aegis\logs\apre_reports\` · Agent: `~/.config/opencode/agents/apre.md` · Skill: `~/.config/opencode/skills/apre-review/SKILL.md`

Validates all complex and high-impact actions through multi-role evaluation. Cross-checks decisions for risk, scalability, and integrity before execution. Deployed as both an opencode subagent (`@apre`) and a skill (`/apre-review`).

**Rebuild #4 APRE Score: 8.55 / 10 — TIER 1 AUTO-PROCEED**

## ECC Universal Skills & Agents

**Key Skills:** `/tdd-workflow`, `/security-review`, `/security-scan`, `/continuous-learning-v2`, `/strategic-compact`, `/verification-loop`, `/agentic-engineering`, `/prompt-optimizer`

**Key Agents:** `planner`, `architect`, `code-reviewer`, `security-reviewer`, `tdd-guide`, `e2e-runner`, `chief-of-staff`, `database-reviewer`

**Key Commands:** `/plan`, `/verify`, `/tdd`, `/code-review`, `/build-fix`, `/e2e`, `/checkpoint`, `/save-session`, `/resume-session`, `/quality-gate`, `/model-route`, `/loop-start`

## Data Classification Framework

| Level | Label | Storage | Transmission |
|-------|-------|---------|--------------|
| L1 | Public | Any | Any |
| L2 | Internal | Encrypted at rest | TLS required |
| L3 | Confidential | Encrypted, access-controlled | E2E encrypted |
| L4 | Sovereign | Encrypted, air-gapped backup | Never cloud; local only |

## System Paths

| Path | Purpose | Access |
|------|---------|--------|
| `O:\Apex_Aegis\` | Source of Truth — Council, Governance, APRE | Read-only |
| `O:\Apex_Aegis\Council\` | Council roles, governance charter, decision flow | Read-only |
| `~/.config/opencode/` | Global OpenCode config (agents, skills, plugins) | Write (guarded) |
| `~/.config/opencode/agents/` | 11 council agents (@titan, @shield, @apre, etc.) | Write (guarded) |
| `~/.config/opencode/skills/` | 12 council skills (apre-review, council-vote, etc.) | Write (guarded) |
| `~/.config/opencode/plugins/` | 4 aegis plugins (memory, apre-gate, fallback, vault-sync) | Write (guarded) |
| `~/.config/opencode/trendshift/` | TrendShift MCP servers (RSS + HuggingFace) | Write (guarded) |
| `~/.config/opencode/mcp-servers/` | AEGIS n8n Bridge MCP server (L1-L4 bouncer) | Write (guarded) |
| `C:\Aegis_System\Config\OpenCode\golden\` | Golden config — source of truth for config state | Write (guarded) |
| `C:\Aegis_System\Config\OpenCode\backups\` | Timestamped pre-change snapshots | Write (guarded) |
| `C:\Aegis_System\Projects\aegis\` | Project files, AGENTS.md, reports | Write |
| `C:\Aegis_System\Recovery\scripts\` | Watchdog, backup, recovery scripts | Write |
| `C:\Aegis_System\Logs\` | Watchdog and system logs | Write |

---

*Full detailed inventory available in [`skills-report.html`](skills-report.html).*
