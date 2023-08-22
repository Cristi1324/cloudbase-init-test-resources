param(
    [Parameter(Mandatory=$true)]
    $cloud
)

$Erroractionpreference = "Stop"
$myPath = $MyInvocation.MyCommand.Path
$repoPath = Split-Path $path -Parent | Split-Path -Parent

function Main {
    cd "${repoPath}/${cloud}"
    & "../bin/mkisofs.exe" -o "../../cloudbase-init-config-drive.iso" -ignore-error -ldots -allow-lowercase -allow-multidot -l -publisher "cbsl" -quiet -J -r -V "config-2" "cloudbase-init-metadata" 2>&1 | %{ "$_" }
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to create cloudbase-init-config-drive.iso"
        exit 1
    }
    & "../bin/mkisofs.exe" -o "../../cloudbase-init-config-drive-nocloud.iso" -ignore-error -ldots -allow-lowercase -allow-multidot -l -publisher "cbsl" -quiet -J -r -V "cidata" "cloudbase-init-metadata" 2>&1 | %{ "$_" }
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to create cloudbase-init-config-drive-nocloud.iso"
        exit 1
    }
}

Main