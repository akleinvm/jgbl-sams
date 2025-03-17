#Type these lines on the CLI

$solutionName = "JGBLSAMS"

pac solution export --path ".\package.zip" --name $solutionName --managed false --include general
pac solution unpack --zipfile ".\package.zip" --folder ".\$($solutionName)\."

Remove-Item -Path ".\package.zip"

Get-ChildItem -Path ".\$($solutionName)" -Filter "*.msapp" -Recurse | ForEach-Object {    
    pac canvas unpack --msapp $_.FullName --sources "$($_.FullName)folder"
    Remove-Item -Path $_.FullName
}