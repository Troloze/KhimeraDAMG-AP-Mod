[CmdletBinding()]
param(
    [string] $Dist = "steam-v4.3"
)

$root = $PSScriptRoot

$game = Join-Path (Join-Path (Join-Path $root "dist") $Dist) "khimera1.exe"

$arguments = "--apw_launcher"

# Debug Mode
# $arguments += " --debug"

Start-Process -FilePath $game -WorkingDirectory $root -ArgumentList $arguments