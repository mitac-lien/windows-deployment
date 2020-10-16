# self elevating
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
# packages to install
# - git
# - nodejs

try {
    node --version
}
catch {
   choco.exe install -y nodejs.install
}

try {
    git --version
}
catch {
   choco.exe install -y git.install
}


