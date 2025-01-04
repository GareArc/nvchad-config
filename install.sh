#!/bin/bash

# Function to display messages
log() {
    echo "[INFO] $1"
}

# Update the system package list
log "Updating system package list..."
apt-get update -y

# Install essential build tools
log "Installing essential build tools..."
apt-get install -y build-essential cmake unzip curl tar git

# Install ripgrep (for Telescope plugin and text search)
log "Installing ripgrep..."
apt-get install -y ripgrep

# Download and install Neovim from the official release page
log "Downloading Neovim release..."
NEOVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux64.tar.gz"
TEMP_DIR=$(mktemp -d)
curl -Lo $TEMP_DIR/nvim-linux64.tar.gz $NEOVIM_URL

log "Extracting Neovim release..."
tar -xzf $TEMP_DIR/nvim-linux64.tar.gz -C $TEMP_DIR
mv $TEMP_DIR/nvim-linux64 /usr/local/

log "Setting up Neovim binary..."
ln -sf /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim

# Verify installation
log "Verifying Neovim installation..."
if command -v nvim &> /dev/null; then
    nvim --version
    log "Neovim installed successfully!"
else
    log "Neovim installation failed!"
    exit 1
fi

# Clean up temporary files
log "Cleaning up temporary files..."
rm -rf $TEMP_DIR

log "NeoVim installation completed."

log "Configuring NvChad..."

rm -rf ~/.config/nvim
git clone https://github.com/GareArc/nvchad-config ~/.config/nvim
log "Installation completes. Type nvim to start."
