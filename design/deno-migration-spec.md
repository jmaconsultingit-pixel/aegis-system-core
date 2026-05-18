# Deno 2.x Migration — Security Sandbox Specification
## Phase 3 | Shield & Warden Approved | APRE Score Pending Re-review

**Date:** 2026-05-18
**Status:** Planning (security-approved, awaiting execution)
**Reviewers:** Shield (BLOCKED → conditions met), Warden (WARNING → conditions accepted)

---

## Approved Deno Permission Matrix

Each plugin/process gets ONLY the permissions its code actually needs. No broad grants.

| Component | --allow-net | --allow-read | --allow-write | --allow-env | Rationale |
|-----------|------------|-------------|--------------|------------|-----------|
| **model-fallback** | `none` | `none` | `none` | `none` | Intercepts session.error events, runs regex, calls client.app.log(). Zero network, zero filesystem, zero env needed. |
| **aegis-memory** | `none` | `C:\Aegis_System\Projects\aegis\700 Memory\` | `C:\Aegis_System\Projects\aegis\700 Memory\` | `none` | Reads/writes session memory files only. Local-only L3 data. |
| **apre-gate** | `none` | `C:\Aegis_System\` | `none` | `none` | Intercepts file.edited and tool.execute.before events. Read-only. No writes. |
| **vault-sync** | See note | `\\[NODE_220_TS]\Obsidian_Vault\Apex_Aegis\` | `\\[NODE_220_TS]\Obsidian_Vault\Apex_Aegis\` | `none` | SMB operations use OS filesystem layer — `--allow-net` does NOT gate SMB. Windows Firewall + SMB encryption provide transport security. |
| **n8n-bridge** | `[NODE_248_TS]:5678` | `none` | `none` | `N8N_ENCRYPTION_KEY` | Tailscale-only. LAN IP excluded unless as documented temporary fallback. |

### Notes

1. **SMB is not network**: vault-sync uses Node/Deno fs operations, not sockets. `--allow-net` is semantically misleading for SMB — don't include it.
2. **Tailscale firewall priority**: n8n-bridge currently hardcodes Tailscale IP (`[NODE_248_TS]:5678`) but the firewall on .248 blocks it. The LAN IP (`[NODE_248]:5678`) works but is cleartext. Fix the .248 Windows Firewall to allow port 5678 on the Tailscale interface, then remove LAN fallback within 30 days.
3. **DENO_DIR**: Set to `C:\Aegis_System\deno-cache\` to keep compiled artifacts inside sovereign boundary. Add to .gitignore.

---

## Deno Environment Configuration

```powershell
# On each node (.170, .220, .248):
[Environment]::SetEnvironmentVariable("DENO_DIR", "C:\Aegis_System\deno-cache", "User")
[Environment]::SetEnvironmentVariable("AEGIS_CONFIG_DIR", "$env:USERPROFILE\.config\opencode", "User")
```

---

## Windows Firewall Hardening (.170)

```powershell
# Allow Deno outbound to approved endpoints only
New-NetFirewallRule -DisplayName "Aegis Deno — NAS" -Direction Outbound -Program "deno.exe" -RemoteAddress [NODE_220_TS] -Action Allow
New-NetFirewallRule -DisplayName "Aegis Deno — n8n Tailscale" -Direction Outbound -Program "deno.exe" -RemoteAddress [NODE_248_TS] -RemotePort 5678 -Action Allow
New-NetFirewallRule -DisplayName "Aegis Deno — Block All Other" -Direction Outbound -Program "deno.exe" -Action Block
```

---

## .248 Tailscale Firewall Fix (P0)

```powershell
# On Node .248, run as [ADMIN_USER]:
New-NetFirewallRule -DisplayName "n8n — Allow Tailscale" -Direction Inbound -InterfaceType "Tailscale" -LocalPort 5678 -Protocol TCP -Action Allow
```

Verify: `port-check [NODE_248_TS] 5678` from .170 after applying rule.

---

## Deno Installation

```powershell
# On each node:
irm https://deno.land/install.ps1 | iex
deno --version  # Verify >= 2.0
```

---

## OpenCode Config Changes (opencode.jsonc)

After Deno is installed and firewall rules applied:

```jsonc
"mcp": {
  "n8n-bridge": {
    "type": "local",
    "command": ["deno", "run", "--allow-net=[NODE_248_TS]:5678", "--allow-env=N8N_ENCRYPTION_KEY", "${AEGIS_CONFIG_DIR}/mcp/n8n-bridge/main.ts"],
    "enabled": true,
    "timeout": 60000
  }
}
```

Plugin invocations follow same `deno run` pattern with component-specific permissions from the matrix above.

---

*Classification: AEGIS-SOVEREIGN | Specification SHIELD-REVIEWED v1.0 | May 2026*
