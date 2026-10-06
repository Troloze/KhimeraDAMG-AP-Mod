[CmdletBinding()]
param(
    [string] $Dist = "steam-v4.3"
)

$root = $PSScriptRoot

$game = Join-Path (Join-Path (Join-Path $root "dist") $Dist) "khimera1.exe"

Start-Process -FilePath $game -WorkingDirectory (Join-Path(Join-Path $root "dist") $Dist)