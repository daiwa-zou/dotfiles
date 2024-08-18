#!/bin/bash
set -e

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

# Function to install zsh via brew
install_zsh {
    echo "Installing zsh..."
    if command -v brew > /dev/null 2>&1; then
        brew install zsh
    else
        echo "Homebrew is not installed. Please install Homebrew first."
        exit 1
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

# Main script logic
if ! check_zsh_installed; then
  install_zsh
fi

# Set zsh as the default shell
set_zsh_as_default

# Verify installation
if command -v zsh > /dev/null 2>&1; then
    echo "zsh installation was successful."
else
    echo "Failed to install zsh."
    exit 1
fi
