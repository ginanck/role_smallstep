#!/usr/bin/env bash

# Detect shell
if [[ -n "$ZSH_VERSION" ]]; then
  SHELL_NAME="zsh"
elif [[ -n "$BASH_VERSION" ]]; then
  SHELL_NAME="bash"
else
  echo "[!] Unsupported shell. Please run with bash or zsh."
  exit 1
fi

# Config
CA_URL="https://ca.internal.local:4443"
FINGERPRINT="191020aeeeead5d4f5932b625413f1767cfdbccc324d49abb669f4335af6e721"

echo "[*] Using $SHELL_NAME"
echo "[*] Bootstrapping from: $CA_URL"
echo "[*] Fingerprint: $FINGERPRINT"

set -e

# Ensure Homebrew exists
if ! command -v brew &>/dev/null; then
  echo "[!] Homebrew is not installed. Please install Homebrew first: https://brew.sh/"
  exit 1
fi

# Install step if missing
if ! command -v step &>/dev/null; then
  echo "[*] Installing step CLI via Homebrew..."
  brew install step
fi

# Bootstrap with --insecure
echo "[*] Bootstrapping Smallstep CA (insecure)..."
step ca bootstrap \
  --ca-url "$CA_URL" \
  --fingerprint "$FINGERPRINT" \
  --install

# Install to system trust store
CA_CERT="$HOME/.step/certs/root_ca.crt"
echo "[*] Installing CA to macOS system keychain..."
sudo security add-trusted-cert -d -r trustRoot \
  -k /Library/Keychains/System.keychain "$CA_CERT"

echo "[✓] Done! CA is trusted system-wide."


https://github.com/smallstep/cli/releases/download/v0.28.6/step_darwin_0.28.6_amd64.tar.gz
https://github.com/smallstep/cli/releases/download/v0.28.6/step_darwin_0.28.6_arm64.tar.gz
