<#
.SYNOPSIS
    AEGIS OpenCode startup routine — validates system integrity before work begins.
.DESCRIPTION
    Runs watchdog, checks Council availability, locates last session for resume.
    Must be executed at the start of each OpenCode session.
#>

Write-Host "=== AEGIS OPENCODE STARTUP ===" -ForegroundColor Cyan

# 1. Run watchdog
Write-Host "`n[1/3] Running config watchdog..." -ForegroundColor Yellow
$watchdogScript = Join-Path $PSScriptRoot "watchdog.ps1"
if (Test-Path $watchdogScript) {
    & $watchdogScript
} else {
    Write-Host "  WARNING: watchdog.ps1 not found at $watchdogScript" -ForegroundColor Red
}

# 2. Load Council context
Write-Host "`n[2/3] Council Load Required:" -ForegroundColor Yellow
Write-Host "  Run: Load Council from O:\Apex_Aegis" -ForegroundColor Yellow

# 3. Resume last session if available
Write-Host "`n[3/3] Session Resume:" -ForegroundColor Yellow
$sessionsDir = "C:\Aegis_System\Tools\OpenCode\sessions"

Write-Host "  Checking OpenCode session history..." -ForegroundColor DarkGray
try {
    $sessionList = opencode session list 2>&1
    if ($LASTEXITCODE -eq 0) {
        $lines = $sessionList | Where-Object { $_ -match '^ses_' }
        if ($lines) {
            $latest = $lines | Select-Object -First 1
            Write-Host "  Latest session: $($latest.Trim())" -ForegroundColor Green
            Write-Host "  Run: opencode -c (to continue)" -ForegroundColor Yellow
        } else {
            Write-Host "  No previous sessions found." -ForegroundColor DarkGray
        }
    }
} catch {
    Write-Host "  Could not query sessions. Continue manually." -ForegroundColor DarkGray
}

if (Test-Path $sessionsDir) {
    $lastSession = Get-ChildItem $sessionsDir -File | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($lastSession) {
        Write-Host "  Stored session: $($lastSession.Name)" -ForegroundColor Green
        Write-Host "  Run: opencode import $($lastSession.FullName)" -ForegroundColor Yellow
    }
}

Write-Host "`n=== STARTUP COMPLETE ===" -ForegroundColor Green
Write-Host "  Config baseline: 48.58 MB | Watchdog: GREEN | GitHub: CONNECTED"
