# self elevating
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
# packages to install
# - git
# - nodejs

try {
    $version = "$(git --version)".Split(' ')[-1]
    $versions.git = $version
} catch {
    choco install -y git.install
}

try {
    $version = "$(node --version)".Substring(1)
    $versions.node = $version
} catch {
    choco install -y nodejs.install
}
