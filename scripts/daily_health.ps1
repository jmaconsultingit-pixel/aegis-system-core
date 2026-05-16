<#
.SYNOPSIS
    AEGIS daily health report generator
.DESCRIPTION
    Captures watchdog status, OpenSpace experience file count,
    OpenCode session list, and last 5 git commits into a dated report.
    Output: C:\Aegis_System\Logs\daily_health_yyyy-MM-dd.md
#>

$date = Get-Date -Format "yyyy-MM-dd"
$watchdog = & "C:\Aegis_System\Recovery\scripts\watchdog.ps1" 2>&1 | Out-String

$openspaceFiles = Get-ChildItem "C:\Aegis_System\Tools\OpenSpace\Experience" -Recurse -File -ErrorAction SilentlyContinue | Measure-Object | Select-Object -ExpandProperty Count

$sessions = Get-ChildItem "C:\Aegis_System\Tools\OpenCode\sessions" -ErrorAction SilentlyContinue | Select-Object Name, LastWriteTime | Format-Table -AutoSize | Out-String

Push-Location "C:\Aegis_System\Projects\aegis"
$gitLog = git log --oneline -5 2>$null | Out-String
Pop-Location

$report = @"
# AEGIS DAILY HEALTH REPORT — $date

## Watchdog
$watchdog

## OpenSpace Status
Experience files: $openspaceFiles

## Sessions
$sessions

## Git History (last 5)
$gitLog

## Paths
- Config: C:\Aegis_System\Config\OpenCode\
- Backup: O:\Apex_Aegis\backups\
- Golden: C:\Aegis_System\Config\OpenCode\golden\
- OpenSpace: C:\Aegis_System\Tools\OpenSpace\Experience\
- Logs: C:\Aegis_System\Logs\
- GitHub: https://github.com/jmaconsultingit-pixel/aegis-system-core
"@

$reportPath = "C:\Aegis_System\Logs\daily_health_$date.md"
$report | Out-File -FilePath $reportPath -Encoding utf8

Write-Host "Daily health report generated: $reportPath" -ForegroundColor Green
Write-Host "  Watchdog: $((Select-String -InputObject $watchdog -Pattern 'WATCHDOG:' | Select-Object -ExpandProperty Line).Trim())" -ForegroundColor Cyan
Write-Host "  OpenSpace experience files: $openspaceFiles" -ForegroundColor Cyan
Write-Host "  Sessions available: $((Get-ChildItem 'C:\Aegis_System\Tools\OpenCode\sessions' -ErrorAction SilentlyContinue).Count)" -ForegroundColor Cyan
