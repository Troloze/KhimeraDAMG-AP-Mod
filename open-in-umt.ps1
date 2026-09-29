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
if (-not (Test-Path $guiPath)) {
    $onPath = Get-Command $Gui -ErrorAction SilentlyContinue
    if ($onPath) {
        $guiPath = $onPath.Source
    } else {
        throw "UndertaleModTool.exe not found ('$Gui')."
    }
}

Write-Host "Launching UndertaleModTool with $sourceData ..." -ForegroundColor Cyan
Write-Host ""
Write-Host "  Next: Project -> Open project -> project.json (in this repo)"                 -ForegroundColor Yellow
Write-Host "        'Choose destination data file' -> anywhere outside this repo,"          -ForegroundColor Yellow
Write-Host "        e.g. dist\data.win (created by build.ps1) or a new empty folder"        -ForegroundColor Yellow
Write-Host ""

Start-Process -FilePath $guiPath -ArgumentList "`"$sourceData`"" -WorkingDirectory (Split-Path $guiPath)
