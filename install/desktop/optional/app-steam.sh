#!/bin/bash

# Play games from https://store.steampowered.com/
if ! command -v steam &> /dev/null; then
  cd /tmp
  wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
  sudo apt install -y ./steam.deb
  rm steam.deb
  cd -
fi
