# AEGIS PROJECT RULES — AGENTS.md
## Mission
Aegis Sentinel architecture. Priority: data preservation, local-first, stable recovery.

## File Boundaries
- Do not write runtime state into OpenCode global config.
- Do not modify .env files without operator approval.
- Do not install tools without operator approval.
- Do not write cache or logs into C:\Users\Progress\.config\opencode.

## Install Rules
- One tool at a time. Verify after each. Backup after each success.
- If config exceeds 20 MB above baseline, stop and report.
- If config exceeds 50 MB total, treat as emergency.

## Security Rules
- Never expose API key values. Names only.
- MCP servers must be localhost-only unless operator approves.
- No marketplace skill without source review and operator approval.

## Recovery Rules
- Before any config change, operator runs freeze script externally.
- If OpenCode fails to launch, do not reinstall over corrupted state.
- Restore from C:\Aegis_System\Config\OpenCode\backups\ instead.

## Tools
### OpenSpace (Skill Evolution Engine)
- OpenSpace is authorized to track session trajectories to evolve skills.
- All evolved skill files (.FIX / .DERIVED / .CAPTURED) MUST be stored in C:\Aegis_System\Tools\OpenSpace\Experience.
- OpenSpace workspace: C:\Aegis_System\Tools\OpenSpace\Experience\.openspace.
- OpenSpace skills registry: C:\Aegis_System\Tools\OpenSpace\Experience\skills.
- Do NOT allow OpenSpace to write to $env:USERPROFILE\.config\opencode.

## ECC Execution Rule (Mandatory)

For all complex tasks in OpenCode:
1. Start with `/plan`
2. Before implementation: `/tdd`
3. After implementation: `/verify`
4. For system/config changes: `/security-review`
5. For multi-step tasks: `/checkpoint` after each step

## Directory Rules
- Config: C:\Aegis_System\Config\OpenCode\
- Projects: C:\Aegis_System\Projects\aegis\
- Tools: C:\Aegis_System\Tools\
- Logs: C:\Aegis_System\Logs\
- Recovery: C:\Aegis_System\Recovery\scripts\
