# self elevating
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

$current_time = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$log_file = "$PSScriptRoot\$current_time.log"
$versions = @{}

& "$PSScriptRoot\choco_installer.ps1" *>> "$log_file"
& "$PSScriptRoot\choco_packages_installer.ps1" *>> "$log_file"

$versionTable = $versions | Sort-Object {$_.Key.count} | Format-Table @{name='package';expr={$_.Key}},@{name='version';expr={$_.Value}}
$versionTable | Tee-Object -FilePath "$log_file" -Append

pause