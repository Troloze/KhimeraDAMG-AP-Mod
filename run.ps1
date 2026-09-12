$root = $PSScriptRoot

$game = Join-Path $root "dist/khimera1.exe"

Start-Process -FilePath $game -WorkingDirectory (Join-Path $root "dist")