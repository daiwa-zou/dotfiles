#!/bin/bash
set -e

source lib/helper.sh

# Set script parent directory as DOTFILES_ROOT
DOTFILES_ROOT=$(pwd -P)

# Install packages using Brewfile
install_packages() {
    echo "› brew bundle"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "Installing packages for macOS..."
        if ! command -v brew > /dev/null 2>&1; then
            echo "Homebrew is not installed. Please install Homebrew first."
            exit 1
        fi
        brew bundle --file=homebrew/Brewfile-macos
    elif [[ "$OSTYPE" == "linux"* ]]; then
        # Linux
        echo "Installing packages for Linux..."
        if ! command -v brew > /dev/null 2>&1; then
            echo "Homebrew is not installed. Please install Homebrew first."
            exit 1
        fi
        brew bundle --file=homebrew/Brewfile-linux
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

# Find and run installers
run_installers() {
    # Find the installers and run them iteratively, exclude scripts directory
    find . -name 'install.sh' -not -path './scripts/*' -print0 | while IFS= read -r -d '' installer; do
        echo "Running installer: $installer"
        if ! sh -c "$installer"; then
            fail "Failed to run installer $installer"
        fi
    done
}

# Function to check if zsh is installed
check_zsh_installed() {
    if command -v zsh > /dev/null 2>&1; then
        echo "zsh is already installed."
        return 0
    else
        echo "zsh is not installed."
        return 1
    fi
}

# Function to set zsh as the default shell
set_zsh_as_default() {
    if [ "$(basename "$SHELL")" != "zsh" ]; then
        echo "Setting zsh as the default shell..."
        chsh -s "$(command -v zsh)"
        echo "zsh has been set as the default shell."
    else
        echo "zsh is already the default shell."
    fi
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    local omz_dir="$HOME/.oh-my-zsh"

    # Check if Oh My Zsh is already installed
    if [ -d "$omz_dir" ]; then
        echo "Oh My Zsh is already installed at $omz_dir."
        return 0
    fi

    echo "Installing Oh My Zsh..."

    # Attempt to install using curl or wget
    if command -v curl > /dev/null 2>&1; then
        if curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended; then
            echo "Oh My Zsh installed successfully."
        else
            echo "Failed to install Oh My Zsh using curl."
            return 1
        fi
    elif command -v wget > /dev/null 2>&1; then
        if wget --quiet https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | sh -s -- --unattended; then
            echo "Oh My Zsh installed successfully."
        else
            echo "Failed to install Oh My Zsh using wget."
            return 1
        fi
    else
        echo "Error: Neither curl nor wget is installed. Please install one of them first."
        return 1
    fi
}

# Execute functions
run_installers
install_packages
setup_gitconfig
install_oh_my_zsh
install_dotfiles
if ! check_zsh_installed; then
    # Set zsh as the default shell
    set_zsh_as_default
fi

echo "Setup completed successfully."
