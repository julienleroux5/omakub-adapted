#!/bin/bash

# Install 1password and 1password-cli single script
if ! command -v 1password &> /dev/null; then
  cd /tmp
  wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb -O 1password.deb
  sudo apt install ./1password.deb -y
  rm 1password.deb
  cd -
fi
