#!/bin/bash

sudo apt install -y fzf zsh ripgrep bat eza lsd zoxide plocate apache2-utils fd-find

if ! command -v oh-my-posh &> /dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi
