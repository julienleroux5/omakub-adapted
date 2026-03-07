#!/bin/bash

sudo apt install -y emacs
if [[ ! -x "$HOME/.config/emacs/bin/doom" ]]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
  ~/.config/emacs/bin/doom install
fi
