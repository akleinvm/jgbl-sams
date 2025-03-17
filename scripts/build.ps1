#Type these lines on the CLI
$solutionName = "JGBLSAMS"

Copy-Item -path ".\$($solutionName)" -Destination ".\build" -Recurse -Force
$currentDirectory = $(Get-Location).Path

Get-ChildItem -Path ".\build" -Filter "*.msappfolder" -Recurse | ForEach-Object {
    pac canvas pack --sources "$($_.FullName)" --msapp $_.FullName.Replace($currentDirectory, '.\').Replace('.msappfolder', '.msapp')
    Remove-Item -Path $_.FullName -Recurse -Force
}

pac solution pack --zipfile ".\build.zip" --folder ".\build\." -Recurse

Remove-Item -Path ".\build" -Recurse
