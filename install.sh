#!/bin/zsh
# install.sh: Installation script for personal-scripts

set -euo pipefail

# Configuration Variables
REPO_URL="https://github.com/brandongilchrist/personal-scripts.git"  # Replace with your repo URL
INSTALL_DIR="$HOME/personal-scripts"
BIN_DIR="$INSTALL_DIR/bin"

# Function to display messages
echo_info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

echo_success() {
    echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

echo_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo_error "Git is not installed. Please install Git and rerun the script."
    exit 1
fi

# Clone the repository if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo_info "Cloning repository into '$INSTALL_DIR'."
    git clone "$REPO_URL" "$INSTALL_DIR"
    echo_success "Repository cloned."
else
    echo_info "Repository already exists at '$INSTALL_DIR'. Pulling latest changes."
    git -C "$INSTALL_DIR" pull
    echo_success "Repository updated."
fi

# Ensure bin directory exists
if [ ! -d "$BIN_DIR" ]; then
    mkdir -p "$BIN_DIR"
    echo_info "Created bin directory at '$BIN_DIR'."
fi

# Create a symbolic link to the bin directory in ~/bin
if [ ! -d "$HOME/bin" ]; then
    mkdir -p "$HOME/bin"
    echo_info "Created '~/bin' directory."
fi

# Add ~/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo_info "Adding '~/bin' to PATH in .zshrc."
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
    echo_success "Updated PATH. Please restart your terminal or run 'source ~/.zshrc'."
else
    echo_info "'~/bin' is already in PATH."
fi

# Link scripts to ~/bin
for script in "$BIN_DIR"/*; do
    script_name=$(basename "$script")
    ln -sf "$script" "$HOME/bin/$script_name"
    echo_info "Linked '$script_name' to '~/bin'."
done

# Add function to .zshrc if not already present
FUNCTION_SNIPPET="# Personal Scripts Functions\n# Load custom scripts functions\n"

if ! grep -q "Personal Scripts Functions" ~/.zshrc 2>/dev/null; then
    echo_info "Adding function aliases to .zshrc."
    echo -e "\n$FUNCTION_SNIPPET" >> ~/.zshrc
    echo -e "alias combine_files='combine_files'" >> ~/.zshrc
    echo_success "Added function aliases to .zshrc. Please restart your terminal or run 'source ~/.zshrc'."
else
    echo_info "Function aliases already present in .zshrc."
fi

echo_success "Installation complete!"
echo "You may need to restart your terminal or run 'source ~/.zshrc' to apply changes."