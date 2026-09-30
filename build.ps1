# This file is partially AI generated.
[CmdletBinding()]
param(
    [string] $Cli    = "UndertaleModCLI.exe",
    [string] $only = "",
    [switch] $Release,
    [string] $Version = ""
)

if ($release -and ($only -ne "")) {$only = ""}

$OutputBase = Join-Path $PSScriptRoot "dist"
$SourceBase = Join-Path $PSScriptRoot "source"
$ReleaseBase = Join-Path $PSScriptRoot "releases"
$ReleaseFolder = Join-Path $ReleaseBase $Version
$ProjectFile = Join-Path $PSScriptRoot "project.json"
$ErrorActionPreference = 'Stop'

$Folders = (Get-ChildItem -Path $SourceBase -Directory)
$FolderCount = $Folders.Length

if ($FolderCount -eq 0) {throw "$SourceBase has no children."}

$CliExists = Get-Command $Cli -ErrorAction SilentlyContinue
if (-not $CliExists) {throw "Could not find UndertaleModCLI, set its path with -Cli or add it to PATH"}

$Folders | ForEach-Object {
    $Output = Join-Path $OutputBase $_.Name
    $Source = $_.FullName
    $cliPath = $Cli

    if (($only -eq "") -or ($only -eq $_.Name)) {
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
            $ReleasePath = Join-Path $ReleaseFolder $_.Name
            #New-Item -ItemType Directory -Path $ReleaseBase -Force
            New-Item -ItemType Directory -Path $ReleasePath -Force
            $DiffName = "kdamg_diff.bsdiff4" -f $_.Name, $Version
            $HashName = "kdamg_hash.json" -f $_.Name, $Version
            $HashPath = Join-Path $ReleasePath $HashName
            $DiffPath = Join-Path $ReleasePath $DiffName
            
            python (Join-Path $PSScriptRoot "make_release.py") $SrcData $DestData $DiffPath
            if ($LASTEXITCODE -ne 0) { throw "Diff maker failed with exit code: $LASTEXITCODE" }
            python (Join-Path $PSScriptRoot "make_hash.py") $SrcData $DestData $Version $HashPath
            if ($LASTEXITCODE -ne 0) { throw "Hash maker failed with exit code: $LASTEXITCODE" }
        }
    }
}

if ($Release) {
    Compress-Archive -Path ("{0}\*" -f $ReleaseFolder) -DestinationPath ("{0}.zip" -f $ReleaseFolder) -Force
    Remove-Item -Path $ReleaseFolder -Recurse -Force
}