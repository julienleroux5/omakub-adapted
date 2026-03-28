#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Beach-Tokyonight-B-MB-Dark-Storm"
THEME_SRC="$SCRIPT_DIR/$THEME_NAME"
THEME_DST="$HOME/.themes/$THEME_NAME"
GTK4_DIR="$HOME/.config/gtk-4.0"
INDEX_THEME_FILE="$THEME_SRC/index.theme"

if [ ! -d "$THEME_SRC" ]; then
  echo "Theme source not found: $THEME_SRC" >&2
  exit 1
fi

if [ ! -f "$INDEX_THEME_FILE" ]; then
  echo "Missing index.theme: $INDEX_THEME_FILE" >&2
  exit 1
fi

icon_theme="$(awk -F= '/^IconTheme=/{print $2}' "$INDEX_THEME_FILE" | head -n1)"
cursor_theme="$(awk -F= '/^CursorTheme=/{print $2}' "$INDEX_THEME_FILE" | head -n1)"
button_layout="$(awk -F= '/^ButtonLayout=/{print $2}' "$INDEX_THEME_FILE" | head -n1)"

mkdir -p "$HOME/.themes" "$GTK4_DIR"

rm -rf "$THEME_DST"
cp -a "$THEME_SRC" "$THEME_DST"

for css in gtk.css gtk-dark.css; do
  if [ -f "$GTK4_DIR/$css" ]; then
    cp "$GTK4_DIR/$css" "$GTK4_DIR/$css.bak"
  fi
done

if [ ! -d "$THEME_SRC/gtk-4.0" ]; then
  echo "Missing GTK4 theme directory: $THEME_SRC/gtk-4.0" >&2
  exit 1
fi

rm -rf "$GTK4_DIR/assets"
cp -a "$THEME_SRC/gtk-4.0/." "$GTK4_DIR/"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
[ -n "$icon_theme" ] && gsettings set org.gnome.desktop.interface icon-theme "$icon_theme"
[ -n "$cursor_theme" ] && gsettings set org.gnome.desktop.interface cursor-theme "$cursor_theme"
[ -n "$button_layout" ] && gsettings set org.gnome.desktop.wm.preferences button-layout "$button_layout"

echo "Theme installed:"
echo "- GTK theme: $THEME_NAME"
echo "- GTK4 directory synced: $GTK4_DIR"



# install gdm theme from mactahoe with beach background
# cd mactahoe-gtk-theme
# sudo ./tweaks.sh -g -b "path to beach background"
# cd -


# install lafayette xkb custom layout for azerty to qwerty remapping
lafayette_file="$(mktemp /tmp/lafayette_linux_v0.9.xkb_custom.XXXXXX)"
wget -qO "$lafayette_file" https://qwerty-lafayette.org/releases/lafayette_linux_v0.9.xkb_custom
sudo mv "$lafayette_file" "${XKB_CONFIG_ROOT:-/usr/share/X11/xkb}/symbols/custom"

# set gdm locale to fr lafayette
sudo cp "$SCRIPT_DIR/keyboard" /etc/default/keyboard
sudo -u gdm dbus-run-session gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr+lafayette')]"
