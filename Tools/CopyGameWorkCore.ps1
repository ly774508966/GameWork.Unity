$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$parentDir = Split-Path -Parent $scriptDir

$sourcePath = Join-Path $parentDir 'GameWork.Core'
$destPath = Join-Path $parentDir 'Assets\GameWork\Core'

If(Test-Path $destPath)
{
    Write-Output "Removing: $destPath"
    Remove-Item $destPath -Recurse
}

Get-ChildItem $sourcePath -Recurse -Include '*.cs' -Exclude 'AssemblyInfo.cs' | Foreach-Object `
{
    $destDir = Split-Path ($_.FullName -Replace [regex]::Escape($sourcePath), $destPath)
    
    if (!(Test-Path $destDir))
    {
        Write-Output "Creating: $destDir"
        New-Item -ItemType directory $destDir | Out-Null
    }

    Write-Output "Copying: $_"
    Copy-Item $_ -Destination $destDir
}

Pause