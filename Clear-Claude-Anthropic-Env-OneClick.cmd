@echo off
setlocal

set "PS1=%TEMP%\clear-claude-anthropic-env-%RANDOM%%RANDOM%.ps1"
set "CLEAR_CLAUDE_ONECLICK_CMD=%~f0"

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$self = '%~f0'; $lines = Get-Content -LiteralPath $self; $marker = '# POWERSHELL_PAYLOAD'; $index = [Array]::IndexOf($lines, $marker); if ($index -lt 0) { throw 'Payload marker not found.' }; $payload = $lines[($index + 1)..($lines.Count - 1)]; Set-Content -LiteralPath '%PS1%' -Value $payload -Encoding UTF8"
if errorlevel 1 (
  echo Failed to prepare script.
  pause
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PS1%"
set "EXITCODE=%ERRORLEVEL%"

del "%PS1%" >nul 2>nul
exit /b %EXITCODE%

# POWERSHELL_PAYLOAD
$ErrorActionPreference = "Stop"

$names = @(
  "ANTHROPIC_AUTH_TOKEN",
  "ANTHROPIC_BASE_URL"
)

function Test-IsAdmin {
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal]::new($identity)
  return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

$isAdmin = Test-IsAdmin
$machineVars = @()

foreach ($name in $names) {
  if ($null -ne [Environment]::GetEnvironmentVariable($name, "Machine")) {
    $machineVars += $name
  }
}

if ($machineVars.Count -gt 0 -and -not $isAdmin) {
  Write-Host ""
  Write-Host "System-level variables were found:" -ForegroundColor Yellow
  foreach ($name in $machineVars) {
    Write-Host "  $name" -ForegroundColor Yellow
  }
  Write-Host ""
  Write-Host "Windows will ask for administrator permission to remove them." -ForegroundColor Cyan
  Write-Host "If you cancel, only user-level variables can be removed." -ForegroundColor Cyan
  Write-Host ""
  $answer = Read-Host "Relaunch as Administrator now? [Y/N]"
  if ($answer -match "^[Yy]") {
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$env:CLEAR_CLAUDE_ONECLICK_CMD`"" -Verb RunAs
    exit 0
  }
}

Write-Host ""
Write-Host "Clearing Claude/Anthropic environment variables..." -ForegroundColor Cyan
Write-Host ""

foreach ($name in $names) {
  Remove-Item "Env:$name" -ErrorAction SilentlyContinue
  [Environment]::SetEnvironmentVariable($name, $null, "User")
  Write-Host "Removed user variable:   $name" -ForegroundColor Green

  if ($null -ne [Environment]::GetEnvironmentVariable($name, "Machine")) {
    if ($isAdmin) {
      [Environment]::SetEnvironmentVariable($name, $null, "Machine")
      Write-Host "Removed system variable: $name" -ForegroundColor Green
    } else {
      Write-Host "System variable still exists: $name" -ForegroundColor Yellow
    }
  }
}

Write-Host ""
Write-Host "Done. Open a new PowerShell window before running claude." -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to close"
