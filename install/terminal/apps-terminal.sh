#!/bin/bash

sudo apt install -y fzf zsh ripgrep bat eza lsd zoxide plocate apache2-utils fd-find bat

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
