# A Communication platform for voice, video, and text messaging https://discord.com/
if ! command -v discord &> /dev/null; then
  cd /tmp
  wget https://discord.com/api/download?platform=linux -O discord.deb
  sudo apt install ./discord.deb -y
  rm discord.deb
  cd -
fi
