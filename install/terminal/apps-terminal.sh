#!/bin/bash

sudo apt install -y fzf zsh ripgrep bat eza lsd zoxide plocate apache2-utils fd-find sd ncdu duf

if ! command -v oh-my-posh &> /dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
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

# keypassxc
#sudo snap install keypassxc

sudo apt install pass
sudo apt install qtpass
sudo apt install pass-extension-tomb
curl -sSL https://codeberg.org/PassFF/passff-host/releases/download/latest/install_host_app.sh | bash -s -- firefox
sudo apt install pinentry-gnome3
sudo apt install gnome-pass-search-provider


# ranger (sudo apt install ranger) ou autre file manager ? yazi (install from local deb) et superfile https://github.com/yorukot/superfile

sudo snap install dust #replacement for du written in rust

# television fuzzy finder
# https://alexpasmantier.github.io/television/getting-started/quickstart

# install croc
if ! command -v croc &> /dev/null; then
  curl -s https://getcroc.schollz.com/install.sh | bash
fi


