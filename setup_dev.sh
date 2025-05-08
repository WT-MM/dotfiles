#!/usr/bin/env bash
#
# setup_dev.sh — install Conda, Rust, and Tailscale
# Run with: ./setup_dev.sh

set -euo pipefail

### 1. Detect OS + architecture ###############################################
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "Detected OS:      $OS"
echo "Detected Arch:    $ARCH"

case "$ARCH" in
  arm64|aarch64) CONDA_ARCH="aarch64" ;;
  x86_64|amd64)  CONDA_ARCH="x86_64"  ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

### 2. Ensure core tools #######################################################
install_pkg_linux() {
  if   command -v apt   >/dev/null 2>&1; then sudo apt-get -y update && sudo apt-get -y install "$@"
  elif command -v dnf   >/dev/null 2>&1; then sudo dnf     -y install "$@"
  elif command -v yum   >/dev/null 2>&1; then sudo yum     -y install "$@"
  elif command -v pacman>/dev/null 2>&1; then sudo pacman  --noconfirm -Sy "$@"
  elif command -v apk   >/dev/null 2>&1; then sudo apk     add --no-cache "$@"
  else echo "No supported package manager found (apt, dnf, yum, pacman, apk)"; exit 1
  fi
}

need_curl() {
  if ! command -v curl >/dev/null 2>&1; then
    echo "Installing curl…"
    if [[ "$OS" == "Darwin" ]]; then
      command -v brew >/dev/null 2>&1 || /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew install curl
    else
      install_pkg_linux curl
    fi
  fi
}
need_curl

### 3. Install Conda #############################################
install_conda() {
  local CONDA_VERSION="latest"
  local CONDA_OS
  if [[ "$OS" == "Darwin" ]]; then
    CONDA_OS="MacOSX"
  else
    CONDA_OS="Linux"
  fi

  local BASE_URL="https://github.com/conda-forge/miniforge/releases/${CONDA_VERSION}/download"
  local CONDA_SH="Miniforge3-${CONDA_OS}-${CONDA_ARCH}.sh"

  echo "Downloading $CONDA_SH…"
  curl -L "${BASE_URL}/${CONDA_SH}" -o "/tmp/${CONDA_SH}"
  echo "Running installer…"
  bash "/tmp/${CONDA_SH}" -b  # -b = batch / non-interactive
  rm "/tmp/${CONDA_SH}"

  # Initialize shell
  "$HOME/miniforge3/bin/conda" init
}
if ! command -v conda >/dev/null 2>&1; then
  install_conda
else
  echo "Conda already installed — skipping."
fi

### 4. Install Rust ###########################################################
if ! command -v rustc >/dev/null 2>&1; then
  echo "Installing Rust via rustup…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "Rust already installed — skipping."
fi

### 5. Install Tailscale ######################################################
install_tailscale() {
  if [[ "$OS" == "Darwin" ]]; then
    if command -v brew >/dev/null 2>&1; then
      brew install --cask tailscale
    else
      echo "Homebrew missing; installing via script (requires sudo)…"
      curl -fsSL https://tailscale.com/install.sh | sh
    fi
  else
    # Linux (script chooses the right repo—Debian, RPM, Alpine, etc.)
    curl -fsSL https://tailscale.com/install.sh | sh
  fi
}

if ! command -v tailscale >/dev/null 2>&1; then
  echo "Installing Tailscale…"
  install_tailscale
else
  echo "Tailscale already installed — skipping."
fi

### 6. Done ###################################################################
echo "🎉  All done!  Open a new shell or run 'source ~/.bashrc' to begin."
