#!/bin/sh

source lib/helper.sh

#
# Zsh
#
# Setup zsh and oh-my-zsh configuration.

# Function to check if zsh is installed
check_zsh_installed() {
    if command -v zsh > /dev/null 2>&1; then
        info "zsh is already installed"
    else
        fail "zsh is not installed"
    fi
}

# Function to set zsh as the default shell
set_zsh_as_default() {
    if [ "$(basename "$SHELL")" != "zsh" ]; then
        info "Setting zsh as the default shell..."
        chsh -s "$(command -v zsh)"
        success "zsh has been set as the default shell"
    else
        info "zsh is already the default shell"
    fi
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    local omz_dir="$HOME/.oh-my-zsh"

    # Check if Oh My Zsh is already installed
    if [ -d "$omz_dir" ]; then
        success "Oh My Zsh is already installed at $omz_dir"
        exit 0
    fi

    info "Installing Oh My Zsh..."

    # Attempt to install using curl or wget
    if command -v curl > /dev/null 2>&1; then
        if curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended > /dev/null; then
            success "Oh My Zsh installed successfully"
        else
            fail "Failed to install Oh My Zsh using curl"
        fi
    elif command -v wget > /dev/null 2>&1; then
        if wget --quiet https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | sh -s -- --unattended > /dev/null; then
            success "Oh My Zsh installed successfully"
        else
            fail "Failed to install Oh My Zsh using wget"
        fi
    else
        fail "Neither curl nor wget is installed"
    fi
}

# Main script execution
install_oh_my_zsh
check_zsh_installed
set_zsh_as_default

exit 0
