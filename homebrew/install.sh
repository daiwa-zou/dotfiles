#!/bin/sh

source lib/helper.sh

#
# Homebrew
#
# This installs Homebrew on macOS if it's not already installed.

# Function to check if Homebrew is installed
check_brew() {
  command -v brew >/dev/null 2>&1
}

# Function to install Homebrew
install_package_manager() {
  # Ensure homebrew for macOS
  if [ "$(uname)" = "Darwin" ]; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    fail "Unsupported OS: $(uname)"
  fi
}

# Install packages using Brewfile
install_packages() {
    info "Installing packages from Brewfile..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v brew > /dev/null 2>&1; then
            fail "Homebrew is not installed. Please install Homebrew first."
        fi
        brew bundle --file=homebrew/Brewfile
        success "All packages installed."
    else
        fail "Unsupported OS: $OSTYPE"
    fi
}

# Main script execution
if ! check_brew; then
  install_package_manager
else
  success "Homebrew is already installed."
fi

install_packages

exit 0

