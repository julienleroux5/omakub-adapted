#!/bin/bash

# teams for linux
if [ ! -f /etc/apt/sources.list.d/teams-for-linux-packages.sources ]; then
  [ -f /etc/apt/keyrings/teams-for-linux.asc ] && sudo rm etc/apt/keyrings/teams-for-linux.asc
  sudo mkdir -p /etc/apt/keyrings
  sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
  sh -c 'echo "Types: deb\nURIs: https://repo.teamsforlinux.de/debian/\nSuites: stable\nComponents: main\nSigned-By: /etc/apt/keyrings/teams-for-linux.asc\nArchitectures: amd64" | sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.sources'
fi

sudo apt update
sudo apt install -y teams-for-linux

# zotero
sudo apt install -y gtk2-engines-murrine
if [[ ! -x "$HOME/Apps/Zotero_linux-x86_64/zotero" ]]; then
  cd /tmp
  wget -O zotero.tar.xz "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64"
  mkdir -p ~/Apps
  tar -xvf zotero.tar.xz -C ~/Apps/
  bash ~/Apps/Zotero_linux-x86_64/set_launcher_icon
  ln -sf ~/Apps/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop
  rm zotero.tar.xz
  cd -
fi

# joplin

# smartgit

if [[ ! -x "$HOME/Apps/smartgit/bin/smartgit.sh" ]]; then
  cd /tmp
  wget -O smartgit.tar.gz "https://download.smartgit.dev/smartgit/smartgit-26_1-latest-linux-amd64.tar.gz"
  mkdir -p ~/Apps
  tar -xvf smartgit.tar.gz -C ~/Apps/
  bash ~/Apps/smartgit/bin/add-menuitem.sh
  rm smartgit.tar.gz
  cd -
fi

# couleur color picker

if ! command -v gnomestarterpack-couleur &> /dev/null; then
  if [[ ! -f /etc/apt/sources.list.d/gnomestarterpack.list ]] || [[ ! -f /usr/share/keyrings/gnomestarterpack.gpg ]]; then
    # Add the GPG key
    curl -fsSL https://apt.gnomestarterpack.com/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/gnomestarterpack.gpg
    # Add the repository
    echo "deb [signed-by=/usr/share/keyrings/gnomestarterpack.gpg arch=amd64] https://apt.gnomestarterpack.com questy main" | sudo tee /etc/apt/sources.list.d/gnomestarterpack.list >/dev/null
  fi
  sudo apt update
  sudo apt install -y gnomestarterpack-couleur
fi

# cava audio visualizer

sudo apt install -y cava
