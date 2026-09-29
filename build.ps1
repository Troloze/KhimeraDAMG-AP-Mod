[CmdletBinding()]
param(
    [string] $Cli    = "UndertaleModCLI.exe",
    [string] $only = "",
    [switch] $Release,
    [string] $Version = ""
)

$OutputBase = Join-Path $PSScriptRoot "dist"
$SourceBase = Join-Path $PSScriptRoot "source"
$ReleaseBase = Join-Path $PSScriptRoot "releases"
$ProjectFile = Join-Path $PSScriptRoot "project.json"
$ErrorActionPreference = 'Stop'

Get-ChildItem -Path $SourceBase -Directory | ForEach-Object {
    $Output = Join-Path $OutputBase $_.Name
    $Source = $_.FullName
    $cliPath = $Cli

    if (($only -ne "") -and ($only -eq $_.Name)) {
        if (-not (Test-Path $Output)) {
            Write-Host "Creating playtest copy at $Output ..." -ForegroundColor Cyan
            New-Item -ItemType Directory -Path $Output -Force | Out-Null
            Copy-Item -Path (Join-Path $Source '*') -Destination $Output -Recurse -Force
        }

        if ($_.Name -eq "steam") {
            $appIdFile = Join-Path $Output 'steam_appid.txt'
            if (-not (Test-Path $appIdFile)) {
                Set-Content -Path $appIdFile -Value '467380' -NoNewline -Encoding ascii
            }
        }
        $SrcData = Join-Path $Source "data.win"
        
        $DestData = Join-Path $Output 'data.win'

        Write-Host "Building project -> $DestData" -ForegroundColor Cyan
        & $cliPath project build $ProjectFile -s $SrcData -d $DestData
        if ($LASTEXITCODE -ne 0) { throw "Build failed with exit code $LASTEXITCODE" }

        Write-Host ("Build OK - {0:N0} bytes" -f (Get-Item $DestData).Length) -ForegroundColor Green

        if ($Release) {
            if ($Version -eq "") {throw "Please provide a version"}
            $ReleasePath = Join-Path (Join-Path $ReleaseBase $Version) $_.Name
            New-Item -ItemType Directory -Path $ReleasePath -Force
            $HashPath = Join-Path $ReleasePath "source_hash.txt"
            $DiffPath = Join-Path $ReleasePath ("khimeraAP-{0}-{1}.bsdiff4" -f $_.Name, $Version)
            python .\make_release.py $SrcData $DestData $DiffPath
            python .\make_hash.py $SrcData $HashPath
        }
    }
}