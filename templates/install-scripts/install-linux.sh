#!/bin/bash

CA_URL="https://ca.internal.local:4443"
FINGERPRINT="191020aeeeead5d4f5932b625413f1767cfdbccc324d49abb669f4335af6e721"

set -e

# Install step CLI if not present
if ! command -v step &> /dev/null; then
  echo "[*] Installing step CLI..."
  curl -LO https://github.com/smallstep/cli/releases/download/v0.28.6/step_linux_0.28.6_amd64.tar.gz
  tar -xf step-linux-amd64.tar.gz
  sudo mv step_*/bin/step /usr/local/bin/
  rm -rf step-* step-linux-amd64.tar.gz
fi

echo "[*] Bootstrapping Smallstep CA..."
step ca bootstrap --ca-url "$CA_URL" --fingerprint "$FINGERPRINT" --install

echo "[*] Installing CA to system trust store..."
sudo cp ~/.step/certs/root_ca.crt /usr/local/share/ca-certificates/smallstep.crt
sudo update-ca-certificates

echo "[✓] Done! CA installed and trusted."