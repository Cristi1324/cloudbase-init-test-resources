param(
    $cloud
)


function Main {
    try { git clone "https://github.com/ader1990/cloudbase-init-test-resources-1" cbs-test-res }catch{}
    cd "../${cloud}"
    try {
        & "../bin/mkisofs.exe" -o "../../cloudbase-init-config-drive.iso" -ignore-error -ldots -allow-lowercase -allow-multidot -l -publisher "cbsl" -quiet -J -r -V "config-2" "cloudbase-init-metadata" 2>&1 | %{ "$_" }
    } catch {}
    try {
        & "../bin/mkisofs.exe" -o "../../cloudbase-init-config-drive-nocloud.iso" -ignore-error -ldots -allow-lowercase -allow-multidot -l -publisher "cbsl" -quiet -J -r -V "cidata" "cloudbase-init-metadata" 2>&1 | %{ "$_" }
    } catch {}
}

Main