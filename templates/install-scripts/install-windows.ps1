$CA_URL = "https://ca.internal.local:4443"
$FINGERPRINT = "191020aeeeead5d4f5932b625413f1767cfdbccc324d49abb669f4335af6e721"

# Check and install step.exe
if (-not (Get-Command step -ErrorAction SilentlyContinue)) {
    Write-Host "[*] Downloading step CLI..."
    $zip = "$env:TEMP\step.zip"
    Invoke-WebRequest -Uri "https://dl.smallstep.com/cli/step-windows-amd64.zip" -OutFile $zip
    Expand-Archive $zip -DestinationPath "$env:TEMP\stepcli"
    Move-Item "$env:TEMP\stepcli\step_*\bin\step.exe" -Destination "C:\Windows\System32\" -Force
}

Write-Host "[*] Bootstrapping Smallstep CA..."
step ca bootstrap --ca-url $CA_URL --fingerprint $FINGERPRINT --install

$RootCA = "$env:USERPROFILE\.step\certs\root_ca.crt"

Write-Host "[*] Installing CA to Windows Trusted Root store..."
Import-Certificate -FilePath $RootCA -CertStoreLocation Cert:\LocalMachine\Root | Out-Null

Write-Host "[✓] Done! CA installed and trusted."



https://github.com/smallstep/cli/releases/download/v0.28.6/step_windows_0.28.6_amd64.zip
