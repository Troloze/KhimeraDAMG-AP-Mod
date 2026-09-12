# build.ps1
# Rebuilds data.win from this project (project.json + whatever asset folders
# exist alongside it) and installs the result into a playable copy of the
# game, for local playtesting. Your original game install is never modified.
#
# One-time setup (e.g. in your PowerShell profile), so you don't have to pass
# paths every time:
#   $env:KHIMERA_SOURCE = "C:\Games\Khimera"                     # your legally-owned, unmodified install
#   $env:UMT_CLI        = "C:\Tools\UndertaleModCli\UndertaleModCli.exe"
#
# Usage:
#   .\build.ps1          # build only
#   .\build.ps1 -Run     # build, then launch the game
#
# All parameters can also be passed explicitly instead of using env vars.

[CmdletBinding()]
param(
    [string] $Source = "D:\Games\Khimera",
    [string] $Output = "",
    [string] $Cli    = "D:\UndertaleModTool\CLI\UndertaleModCLI.exe",
    [string] $Exe    = "khimera1.exe",
    [switch] $Run
)

$Output = Join-Path $PSScriptRoot "\dist"

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Source)) {
    throw "No source game folder specified. Pass -Source <path>, or set `$env:KHIMERA_SOURCE once (see comments at the top of this script)."
}
if (-not (Test-Path $Source)) { throw "Source game folder not found: $Source" }

$sourceData = Join-Path $Source 'data.win'
if (-not (Test-Path $sourceData)) { throw "data.win not found in source folder: $sourceData" }

$projectFile = Join-Path $PSScriptRoot 'project.json'
if (-not (Test-Path $projectFile)) { throw "project.json not found next to this script: $projectFile" }

# Resolve the CLI executable: explicit/env path, or fall back to PATH.
$cliPath = $Cli
if (-not (Test-Path $cliPath)) {
    $onPath = Get-Command $Cli -ErrorAction SilentlyContinue
    if ($onPath) {
        $cliPath = $onPath.Source
    } else {
        throw "UndertaleModCli.exe not found ('$Cli'). Pass -Cli <path>, set `$env:UMT_CLI, or put it on PATH."
    }
}

# One-time: pristine copy of the game to install the mod into. Everything
# except data.win (DLLs, audio, the .exe) is copied as-is.
if (-not (Test-Path $Output)) {
    Write-Host "Creating playtest copy at $Output ..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $Output -Force | Out-Null
    Copy-Item -Path (Join-Path $Source '*') -Destination $Output -Recurse -Force
}

# The retail build calls SteamAPI_RestartAppIfNecessary on boot, which hands
# control back to Steam and relaunches the *installed* copy - so the playtest
# build would silently exit and you'd be testing the unmodded game. Dropping
# the app id next to the exe makes that check a no-op and the copy runs itself.
$appIdFile = Join-Path $Output 'steam_appid.txt'
if (-not (Test-Path $appIdFile)) {
    Set-Content -Path $appIdFile -Value '467380' -NoNewline -Encoding ascii
}

$destData = Join-Path $Output 'data.win'

Write-Host "Building project -> $destData" -ForegroundColor Cyan
& $cliPath project build $projectFile -s $sourceData -d $destData
if ($LASTEXITCODE -ne 0) { throw "Build failed with exit code $LASTEXITCODE" }

Write-Host ("Build OK - {0:N0} bytes" -f (Get-Item $destData).Length) -ForegroundColor Green

if ($Run) {
    $exePath = Join-Path $Output $Exe
    if (-not (Test-Path $exePath)) { throw "Game executable not found: $exePath (wrong -Exe name? pass -Exe <name.exe>)" }
    Write-Host "Launching $exePath ..." -ForegroundColor Cyan
    Start-Process -FilePath $exePath -WorkingDirectory $Output
}
