#!/bin/bash

set -e 
# Function to install Oh My Zsh
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
        if curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh; then
            echo "Oh My Zsh installed successfully."
        else
            echo "Failed to install Oh My Zsh using curl."
            return 1
        fi
    elif command -v wget > /dev/null 2>&1; then
        if wget --quiet https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | sh; then
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

# Main
install_oh_my_zsh
