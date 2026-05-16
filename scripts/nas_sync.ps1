<#
.SYNOPSIS
    AEGIS NAS sync — mirrors local Aegis_System to O:\Apex_Aegis\backups\AEGIS_SYSTEM_SYNC
.DESCRIPTION
    Runs robocopy with /MIR (mirror), /MT:16 (multi-threaded), verbose logging.
    Intended for scheduled or manual execution.
#>

$source = "C:\Aegis_System"
$dest = "O:\Apex_Aegis\backups\AEGIS_SYSTEM_SYNC"

if (-not (Test-Path "O:\")) {
    Write-Host "ERROR: O: drive not accessible. NAS may be offline." -ForegroundColor Red
    exit 1
}

Write-Host "Syncing AEGIS_SYSTEM → NAS..." -ForegroundColor Cyan
robocopy $source $dest /MIR /R:2 /W:2 /V /MT:16 /LOG:"C:\Aegis_System\Logs\nas_sync_$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

if ($LASTEXITCODE -le 7) {
    Write-Host "NAS sync complete" -ForegroundColor Green
} else {
    Write-Host "NAS sync FAILED (exit code: $LASTEXITCODE)" -ForegroundColor Red
}
