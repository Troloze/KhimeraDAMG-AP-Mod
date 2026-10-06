[CmdletBinding()]
param(
    [string] $Cli = "UndertaleModCLI.exe",
    [string] $Dist = "steam-v4.3"
)

$root = $PSScriptRoot

$build = Join-Path $root "build.ps1"
$run = Join-Path $root "run.ps1"

& $build -Cli $Cli -only $Dist
& $run -dist $Dist