$root = $PSScriptRoot

$build = Join-Path $root "build.ps1"
$run = Join-Path $root "run.ps1"

& $build
& $run