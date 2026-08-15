# open-in-umt.ps1
# Launches the UndertaleModTool GUI with your game's data file loaded, ready
# for Project -> Open project. See README.md for the full step-by-step.
#
# One-time setup (same env vars as build.ps1):
#   $env:KHIMERA_SOURCE = "C:\Games\Khimera"
#   $env:UMT_GUI        = "C:\Tools\UndertaleModTool\UndertaleModTool.exe"
#
# Usage:
#   .\open-in-umt.ps1

[CmdletBinding()]
param(
    [string] $Source = $env:KHIMERA_SOURCE,
    [string] $Gui    = $(if ($env:UMT_GUI) { $env:UMT_GUI } else { "UndertaleModTool.exe" })
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Source)) {
    throw "No source game folder specified. Pass -Source <path>, or set `$env:KHIMERA_SOURCE once."
}
$sourceData = Join-Path $Source 'data.win'
if (-not (Test-Path $sourceData)) { throw "data.win not found in source folder: $sourceData" }

$guiPath = $Gui
if (-not (Test-Path $guiPath)) {
    $onPath = Get-Command $Gui -ErrorAction SilentlyContinue
    if ($onPath) {
        $guiPath = $onPath.Source
    } else {
        throw "UndertaleModTool.exe not found ('$Gui'). Pass -Gui <path>, set `$env:UMT_GUI, or put it on PATH."
    }
}

Write-Host "Launching UndertaleModTool with $sourceData ..." -ForegroundColor Cyan
Write-Host ""
Write-Host "  Next: Project -> Open project -> project.json (in this repo)"                 -ForegroundColor Yellow
Write-Host "        'Choose destination data file' -> anywhere outside this repo,"          -ForegroundColor Yellow
Write-Host "        e.g. dist\data.win (created by build.ps1) or a new empty folder"        -ForegroundColor Yellow
Write-Host ""

Start-Process -FilePath $guiPath -ArgumentList "`"$sourceData`"" -WorkingDirectory (Split-Path $guiPath)
