#!/bin/bash

sudo apt install -y gnome-shell-extension-manager gir1.2-gtop-2.0 gir1.2-clutter-1.0
pipx install gnome-extensions-cli --system-site-packages

# Turn off default Ubuntu extensions
gnome-extensions disable tiling-assistant@ubuntu.com
# gnome-extensions disable ubuntu-appindicators@ubuntu.com
gnome-extensions disable ubuntu-dock@ubuntu.com
gnome-extensions disable ding@rastersoft.com

# Pause to assure user is ready to accept confirmations
gum confirm "To install Gnome extensions, you need to accept some confirmations. Ready?"

# Install new extensions
gext install tactile@lundal.io
gext install just-perfection-desktop@just-perfection
gext install blur-my-shell@aunetx
gext install space-bar@luchrioh
gext install undecorate@sun.wxg@gmail.com
# gext install tophat@fflewddur.github.io
gext install AlphabeticalAppGrid@stuarthayhurst
gext install gnomebedtime@ionutbortis.gmail.com
gext install desktop-cube@schneegans.github.com
gext install hotedge@jonathan.jdoda.ca
gext install openbar@neuromorph
gext install system-monitor@gnome-shell-extensions.gcampax.github.com
gext install unite@hardpixel.eu
gext install windowgestures@extension.amarullz.com
gext install focus-follows-workspace@christopher.luebbemeier.gmail.com

## install Unite
sudo apt install -y x11-utils
wget -qO- https://github.com/hardpixel/unite-shell/releases/download/v82/unite-v82.zip
gext install --force unite-v82.zip

# Compile gsettings schemas in order to be able to set them
sudo cp ~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/just-perfection-desktop\@just-perfection/schemas/org.gnome.shell.extensions.just-perfection.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/blur-my-shell\@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/space-bar\@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid\@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/openbar\@neuromorph/schemas/org.gnome.shell.extensions.openbar.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Configure Tactile
gsettings set org.gnome.shell.extensions.tactile col-0 1
gsettings set org.gnome.shell.extensions.tactile col-1 2
gsettings set org.gnome.shell.extensions.tactile col-2 1
gsettings set org.gnome.shell.extensions.tactile col-3 0
gsettings set org.gnome.shell.extensions.tactile row-0 1
gsettings set org.gnome.shell.extensions.tactile row-1 1
gsettings set org.gnome.shell.extensions.tactile gap-size 32

# Configure Just Perfection
gsettings set org.gnome.shell.extensions.just-perfection animation 4
gsettings set org.gnome.shell.extensions.just-perfection dash-app-running true
gsettings set org.gnome.shell.extensions.just-perfection workspace true
gsettings set org.gnome.shell.extensions.just-perfection workspace-popup false

# Configure Blur My Shell
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.lockscreen blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.screenshot blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.window-list blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.overview blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.overview pipeline 'pipeline_default'
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock brightness 0.6
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock sigma 30
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock static-blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 0

# Configure Space Bar
gsettings set org.gnome.shell.extensions.space-bar.behavior smart-workspace-names false
gsettings set org.gnome.shell.extensions.space-bar.behavior system-workspace-indicator false
gsettings set org.gnome.shell.extensions.space-bar.shortcuts enable-activate-workspace-shortcuts false
gsettings set org.gnome.shell.extensions.space-bar.shortcuts enable-move-to-workspace-shortcuts true
gsettings set org.gnome.shell.extensions.space-bar.shortcuts open-menu "@as []"
gsettings set org.gnome.shell.extensions.space-bar.appearance application-styles '.space-bar{\n -natural-hpadding:12px;\n}\n\n.space-bar-workspace-label.active{\n  margin: 0 4px;\n  background-color: rgba(255,255,255,0.3);\n  color: rgba(255,255,255,1);\n  border-color: rgba(0,0,0,0);\n  font-weight: 700;\n  border-radius: 4px;\n  border-width: 0px;\n  padding: 1px 6px;\n}\n\n.space-bar-workspace-label.inactive{\n  margin: 0 4px;\n  background-color: rgba(0,0,0,0);\n  color: rgba(255,255,255,1);\n  border-color: rgba(0,0,0,0);\n  font-weight: 700;\n  border-radius: 4px;\n  border-width: 0px;\n  padding: 1px 6px;\n}\n\n.space-bar-workspace-label.inactive.empty{\n  margin: 0 4px;\n  background-color: rgba(0,0,0,0);\n  color: rgba(255,255,255,0.5);\n  border-color:rgba(0,0,0,0);\n  font-weight:700;\n  border-radius: 4px;\n  border-width: 0px;\n  padding: 1px 6px;\n}'

# Configure TopHat
gsettings set org.gnome.shell.extensions.tophat show-icons false
gsettings set org.gnome.shell.extensions.tophat show-cpu false
gsettings set org.gnome.shell.extensions.tophat show-disk false
gsettings set org.gnome.shell.extensions.tophat show-mem false
gsettings set org.gnome.shell.extensions.tophat show-fs false
gsettings set org.gnome.shell.extensions.tophat network-usage-unit bits

# Configure AlphabeticalAppGrid
gsettings set org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'end'

# Configure OpenBar
gsettings set org.gnome.shell.extensions.openbar bartype 'Islands'
gsettings set org.gnome.shell.extensions.openbar height '24'
gsettings set org.gnome.shell.extensions.openbar margin '0'
gsettings set org.gnome.shell.extensions.openbar bgalpha-wmax '0.22'
gsettings set org.gnome.shell.extensions.openbar margin-wmax '0'
gsettings set org.gnome.shell.extensions.openbar buttonbg-wmax false
gsettings set org.gnome.shell.extensions.openbar bgalpha '0'
gsettings set org.gnome.shell.extensions.openbar isalpha '0.25'
gsettings set org.gnome.shell.extensions.openbar halpha '0.25'
gsettings set org.gnome.shell.extensions.openbar vpad '0.9'
gsettings set org.gnome.shell.extensions.openbar bwidth '0'
gsettings set org.gnome.shell.extensions.openbar bradius '12'
gsettings set org.gnome.shell.extensions.openbar balpha '0.4'
gsettings set org.gnome.shell.extensions.openbar neon false
gsettings set org.gnome.shell.extensions.openbar menustyle false
gsettings set org.gnome.shell.extensions.openbar autohg-bar false
gsettings set org.gnome.shell.extensions.openbar default-font 'Sans 10'

