#!/usr/bin/env bash

# Arsenik and Kanata installation script
# This script installs Arsenik (keyboard remapping tool) and Kanata (keyboard firmware)
# Following instructions from: https://github.com/OneDeadKey/arsenik/tree/main/kanata

set -euo pipefail

# Configuration
ARSENIK_VERSION="0.2.0"
ARSENIK_URL="https://github.com/OneDeadKey/arsenik/releases/download/${ARSENIK_VERSION}/arsenik-${ARSENIK_VERSION}.zip"
KATANA_VERSION="v1.11.0"
KATANA_URL="https://github.com/jtroo/kanata/releases/download/${KATANA_VERSION}/linux-binaries-x64.zip"

INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/arsenik"

# Create directories
echo "Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"

# Install Arsenik
echo "Installing Arsenik..."
if [ ! -d "$CONFIG_DIR" ] || [ -z "$(ls -A $CONFIG_DIR)" ]; then
    # Download and extract Arsenik
    echo "Downloading Arsenik from $ARSENIK_URL..."
    curl -L "$ARSENIK_URL" -o /tmp/arsenik.zip
    unzip /tmp/arsenik.zip -d $CONFIG_DIR
    rm -rf /tmp/arsenik.zip
    
    echo "Arsenik installed successfully to $CONFIG_DIR"
else
    echo "Arsenik is already installed"
fi

# Install Kanata
echo "Installing Kanata..."
if [ ! -f "$INSTALL_DIR/kanata_linux_x64" ]; then
    # Download and extract Kanata
    echo "Downloading Kanata from $KATANA_URL..."
    curl -L "$KATANA_URL" -o /tmp/kanata.zip
    unzip /tmp/kanata.zip -d /tmp/kanata
    
    # Install binary
    install -m 755 /tmp/kanata/kanata_linux_x64 "$INSTALL_DIR/kanata_linux_x64"
    rm -rf /tmp/kanata /tmp/kanata.zip
    
    echo "Kanata installed successfully to $INSTALL_DIR/kanata_linux_x64"
else
    echo "Kanata is already installed"
fi

# Configure uinput permissions for Kanata (requires sudo)
echo "Configuring uinput permissions for Kanata..."

# Create uinput group and add user to input and uinput groups
if ! getent group uinput >/dev/null; then
    echo "Creating uinput group and adding user to groups..."
    sudo groupadd -U $USER uinput
    sudo usermod -aG input $USER
    echo "Groups created. You will need to log out and back in for group changes to take effect."
else
    echo "uinput group already exists"
    # Check if user is in input and uinput groups
    if ! id -nG $USER | grep -qw input; then
        sudo usermod -aG input $USER
        echo "Added user to input group"
    fi
    if ! id -nG $USER | grep -qw uinput; then
        sudo usermod -aG uinput $USER
        echo "Added user to uinput group"
    fi
fi

# Create udev rule for uinput
echo "Creating udev rule for Kanata..."
cat > /tmp/50-kanata.rules << 'EOF'
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF

sudo mv /tmp/50-kanata.rules /etc/udev/rules.d/50-kanata.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Create systemd service for Kanata (user service, no sudo required)
echo "Setting up Kanata systemd service..."
cat > "$HOME/.config/systemd/user/kanata.service" << 'EOF'
[Unit]
Description=Kanata Keyboard Remapping
Documentation=https://github.com/jtroo/kanata

[Service]
Environment=PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
Environment=DISPLAY=:0
Type=simple
ExecStart=%h/.local/bin/kanata_linux_x64 --cfg %h/.config/arsenik/kanata.kbd
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF

# Enable and start the service
echo "Enabling and starting Kanata service..."
systemctl --user enable kanata.service
systemctl --user start kanata.service

# Configure Kanata configuration
echo "Configuring Kanata configuration..."

    sed -i 's/^;; (include defsrc\/pc.kbd)/(include defsrc\/pc.kbd)/' "$CONFIG_DIR/kanata.kbd"
    sed -i 's/^;; (include deflayer\/base_lt.kbd)/(include deflayer\/base_lt.kbd)/' "$CONFIG_DIR/kanata.kbd"
    sed -i 's/^;; (include deflayer\/symbols_lafayette_num.kbd)/(include deflayer\/symbols_lafayette_num.kbd)/' "$CONFIG_DIR/kanata.kbd"
    sed -i 's/^;;(include deflayer\/navigation_vim.kbd)/(include deflayer\/navigation_vim.kbd)/' "$CONFIG_DIR/kanata.kbd"
    sed -i 's/^;;(include defalias\/qwerty-lafayette_pc.kbd)/(include defalias\/qwerty-lafayette_pc.kbd)/' "$CONFIG_DIR/kanata.kbd"
    # Ensure the run alias is set to do nothing if it exists
    sed -i 's/^;; (defalias run M-p)/;; (defalias run M-p)/' "$CONFIG_DIR/kanata.kbd"
    sed -i 's/^;;(defalias run XX)/(defalias run XX)/' "$CONFIG_DIR/kanata.kbd"

echo "Kanata configuration set up with desired options:"
echo "  - PC keyboard layout"
echo "  - Layer-taps on thumb keys"
echo "  - Lafayette symbols with number row layers"
echo "  - Vim-style navigation layer"
echo "  - Qwerty-Lafayette PC aliases"

echo "Installation complete!"
echo "Arsenik configuration: $CONFIG_DIR"
echo "Kanata binary: $INSTALL_DIR/kanata_linux_x64"
echo ""
echo "IMPORTANT: You need to log out and back in for the group changes to take effect."
echo "After logging back in, you can manage Kanata service with: systemctl --user status/stop/start/restart kanata.service"
echo ""
echo "Remember to add $INSTALL_DIR to your PATH if it's not already there."
