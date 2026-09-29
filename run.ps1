$root = $PSScriptRoot

$game = Join-Path $root "dist/steam/khimera1.exe"

Start-Process -FilePath $game -WorkingDirectory (Join-Path $root "dist/steam")