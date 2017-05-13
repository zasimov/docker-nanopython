param(
    [Parameter(Mandatory=$true)][String] $PyVersion,
    [String] $Arch = "x64"
)

$BaseUrl = "https://www.python.org/ftp/python/${PyVersion}"

if ( $Arch -eq "x64" ) {
    $ArchSuffix = "-amd64"
    $InstalledArchSuffix = ""
} else {
    $ArchSuffix = ""
    $InstalledArchSuffix = "-32"
}

$url = "$BaseUrl/python-${PyVersion}${ArchSuffix}.exe"

$PythonProcessName = "python-${PyVersion}${ArchSuffix}"
$PythonInstaller = "${PythonProcessName}.exe"

if ( ! (Test-Path -Type Leaf $PythonInstaller) ) {
    Invoke-WebRequest -Uri $url -OutFile ${PythonInstaller}
}

$SplittedVersion = $PyVersion.split(".")
$Major = $SplittedVersion[0]
$Minor = $SplittedVersion[1]
$LocalAppData = $env:LOCALAPPDATA
# Use default installation path (see https://docs.python.org/3/using/windows.html)
$PythonDirectory = "${LocalAppData}\Programs\Python\Python${Major}${Minor}${InstalledArchSuffix}"

# Run python installation (if it's not installed) and what until finish
if (! (Test-Path -Type Container $PythonDirectory)) {
    Invoke-Expression "./${PythonInstaller} /quiet"

    $running = (get-process | where {$_.ProcessName -eq $PythonProcessName})
    while ( $running ) {
        Start-Sleep 1
        $running = (get-process | where {$_.ProcessName -eq $PythonProcessName})
    }
}

if (! (Test-Path -Type Leaf "$PythonProcessName.zip")) {
    # Create zip archive with python
    Compress-Archive $PythonDirectory -DestinationPath "$PythonProcessName.zip"
}
