#!/bin/bash

source ~/.local/share/omakub/themes/beach/gnome.sh

# Apply Beach custom GTK theme assets (window controls, GTK4 overrides, etc.)
if [[ -f ~/.local/share/omakub/themes/beach/install.sh ]]; then
  bash ~/.local/share/omakub/themes/beach/install.sh
fi

source ~/.local/share/omakub/themes/beach/tophat.sh
