#!/bin/bash

# Function to display messages
log() {
    echo "[INFO] $1"
}

# Determine the appropriate shell configuration file
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
    log "Using .zshrc for configuration."
else
    SHELL_CONFIG="$HOME/.bashrc"
    log "Using .bashrc for configuration."
fi

# Update the system package list
log "Updating system package list..."
sudo apt-get update -y

# Install essential build tools
log "Installing essential build tools..."
sudo apt-get install -y build-essential cmake unzip curl tar git

# Install ripgrep (for Telescope plugin and text search)
log "Installing ripgrep..."
sudo apt-get install -y ripgrep

# Install xclip
sudo apt install xclip -y

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    log "npm not found. Installing Node.js using nvm..."

    # Check if nvm is installed
    if ! command -v nvm &> /dev/null; then
        log "nvm not found. Installing nvm..."
        
        # Install nvm
        export NVM_DIR="$HOME/.nvm" && (
          git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
          cd "$NVM_DIR"
          git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh" 

        # add to bashrc
        echo 'export NVM_DIR="$HOME/.nvm"' >> $SHELL_CONFIG
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $SHELL_CONFIG
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> $SHELL_CONFIG

        # Source nvm script to make it available in this shell session
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
    fi

    # Install the LTS version of Node.js
    log "Installing Node.js LTS version..."
    nvm install --lts
    
    # Use the installed LTS version
    nvm use --lts
    
    # Verify npm installation
    if command -v npm &> /dev/null; then
        log "npm successfully installed."
    else
        log "npm installation failed. Please check for issues."
        exit 1
    fi
else
    log "npm is already installed."
fi

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
mkdir -p ~/.config/nvim 
git clone https://github.com/GareArc/nvchad-config ~/.config/nvim
log "Installation completes. Type nvim to start."
