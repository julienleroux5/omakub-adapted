#!/bin/bash

mkdir -p ~/.local/share/fonts

cd /tmp
if ! ls ~/.local/share/fonts/CaskaydiaMonoNerdFont*.ttf &>/dev/null; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
  unzip CascadiaMono.zip -d CascadiaFont
  cp CascadiaFont/*.ttf ~/.local/share/fonts
  rm -rf CascadiaMono.zip CascadiaFont
fi

if ! ls ~/.local/share/fonts/iAWriterMonoS-*.ttf &>/dev/null; then
  wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip iafonts.zip -d iaFonts
  cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
  rm -rf iafonts.zip iaFonts
fi

fc-cache
cd -
