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
wget -O zotero.tar.xz "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64"
mkdir -p ~/Apps
tar -xvf zotero.tar.xz -C ~/Apps/
bash ~/Apps/Zotero_linux-x86_64/set_launcher_icon
ln -s ~/Apps/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop


# joplin

# smartgit