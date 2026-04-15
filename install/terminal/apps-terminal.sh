#!/bin/bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt install -y \
  fzf zsh ripgrep bat eza lsd zoxide plocate apache2-utils fd-find sd ncdu duf \
  pass qtpass pass-extension-tomb pinentry-gnome3 gnome-pass-search-provider

if ! command -v oh-my-posh &> /dev/null; then
  curl -fsSL https://ohmyposh.dev/install.sh | bash -s
fi

# Nushell: data-oriented shell (using polars). add repo and install only if missing
if ! command -v nu &> /dev/null; then
  if [[ ! -f /etc/apt/sources.list.d/fury-nushell.list ]] || [[ ! -f /etc/apt/keyrings/fury-nushell.gpg ]]; then
    sudo install -d -m 0755 /etc/apt/keyrings
    wget -qO- https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/fury-nushell.gpg
    echo "deb [signed-by=/etc/apt/keyrings/fury-nushell.gpg] https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury-nushell.list >/dev/null
  fi
  sudo apt update
  sudo apt install -y nushell
fi

# PassFF host app for Firefox
if ! command -v passff-host &> /dev/null; then
  curl -fsSL https://codeberg.org/PassFF/passff-host/releases/download/latest/install_host_app.sh | bash -s -- firefox
fi

# yazi (install from deb release)
if ! command -v yazi &> /dev/null; then
  arch="$(dpkg --print-architecture)"
  case "$arch" in
    amd64) yazi_arch="x86_64" ;;
    arm64) yazi_arch="aarch64" ;;
    *)
      echo "Skipping yazi install: unsupported architecture '$arch'" >&2
      yazi_arch=""
      ;;
  esac
  if [[ -n "$yazi_arch" ]]; then
    yazi_deb="/tmp/yazi-${yazi_arch}-unknown-linux-gnu.deb"
    curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/yazi-${yazi_arch}-unknown-linux-gnu.deb" -o "$yazi_deb"
    sudo apt install -y "$yazi_deb"
    rm -f "$yazi_deb"
  fi
fi

# superfile
if ! command -v spf &> /dev/null; then
  sf_tag="$(curl -fsSL https://api.github.com/repos/yorukot/superfile/releases/latest | grep -Po '"tag_name": "\K[^"]*')"
  if [[ -z "$sf_tag" ]]; then
    echo "Skipping superfile install: failed to resolve latest version." >&2
  else
    arch="$(dpkg --print-architecture)"
    case "$arch" in
      amd64) sf_arch="amd64" ;;
      arm64) sf_arch="arm64" ;;
      *)
        echo "Skipping superfile install: unsupported architecture '$arch'" >&2
        sf_arch=""
        ;;
    esac
    if [[ -n "$sf_arch" ]]; then
      sf_tar="/tmp/superfile-linux-${sf_tag}-${sf_arch}.tar.gz"
      curl -fsSL "https://github.com/yorukot/superfile/releases/latest/download/superfile-linux-${sf_tag}-${sf_arch}.tar.gz" -o "$sf_tar"
      tar -xzf "$sf_tar" -C /tmp
      sudo install "/tmp/dist/superfile-linux-${sf_tag}-${sf_arch}/spf" /usr/local/bin/spf
      rm -rf "$sf_tar" "/tmp/dist/superfile-linux-${sf_tag}-${sf_arch}"
    fi
  fi
fi

# dust (replacement for du written in Rust)
if ! command -v dust &> /dev/null; then
  sudo snap install dust
fi

# television fuzzy finder
if ! command -v tv &> /dev/null; then
  tv_tag="$(curl -fsSL https://api.github.com/repos/alexpasmantier/television/releases/latest | grep -Po '"tag_name": "\K[^"]*')"
  if [[ -z "$tv_tag" ]]; then
    echo "Skipping television install: failed to resolve latest version." >&2
  else
    arch="$(dpkg --print-architecture)"
    case "$arch" in
      amd64) tv_arch="x86_64-unknown-linux-gnu" ;;
      arm64) tv_arch="aarch64-unknown-linux-gnu" ;;
      *)
        echo "Skipping television install: unsupported architecture '$arch'" >&2
        tv_arch=""
        ;;
    esac
    if [[ -n "$tv_arch" ]]; then
      tv_deb="/tmp/tv-${tv_tag}-${tv_arch}.deb"
      curl -fsSL "https://github.com/alexpasmantier/television/releases/download/${tv_tag}/tv-${tv_tag}-${tv_arch}.deb" -o "$tv_deb"
      sudo apt install -y "$tv_deb"
      rm -f "$tv_deb"
    fi
  fi
fi

# install croc
if ! command -v croc &> /dev/null; then
  curl -fsSL https://getcroc.schollz.com/install.sh | bash
fi

