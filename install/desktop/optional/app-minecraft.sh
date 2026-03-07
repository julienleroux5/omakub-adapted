#!/bin/bash

sudo apt install -y openjdk-8-jdk

if ! command -v minecraft-launcher &> /dev/null; then
  cd /tmp
  wget https://launcher.mojang.com/download/Minecraft.deb
  sudo apt install -y ./Minecraft.deb
  rm Minecraft.deb
  cd -
fi
