param(
    [String] $InputZip, 
    [String] $DestinationPath
    )

New-Item -type d $DestinationPath
Expand-Archive $InputZip -DestinationPath $DestinationPath
