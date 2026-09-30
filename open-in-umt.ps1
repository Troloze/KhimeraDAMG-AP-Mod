# This file is partially AI generated.
[CmdletBinding()]
param(
    [string] $Gui    = "UndertaleModTool.exe",
    [string] $SrcVer = "steam"
)
$Source = Join-Path (Join-Path $PSScriptRoot "source") $SrcVer
$ErrorActionPreference = 'Stop'

$sourceData = Join-Path $Source 'data.win'
if (-not (Test-Path $sourceData)) { throw "data.win not found in source folder: $sourceData" }

$guiPath = $Gui
if (Test-Path $guiPath -PathType Leaf) {
    $guiPath = (Resolve-Path $guiPath).Path
} else {
    $onPath = Get-Command $Gui -ErrorAction SilentlyContinue
    if ($onPath -and $onPath.CommandType -eq 'Application') { $guiPath = $onPath.Source }
    else { throw "UndertaleModTool.exe not found ('$Gui')." }
}

Write-Host "Launching UndertaleModTool with $sourceData ..." -ForegroundColor Cyan
Write-Host ""
Write-Host "  Next: Project -> Open project -> project.json (in this repo)"                 -ForegroundColor Yellow
Write-Host "        'Choose destination data file' -> Any name, preferably at this repo's root"          -ForegroundColor Yellow
Write-Host ""

Start-Process -FilePath $guiPath -ArgumentList "`"$sourceData`"" -WorkingDirectory (Split-Path $guiPath)
