#!/bin/sh
#
# Homebrew
#
# This installs Homebrew on macOS or Linux if it's not already installed.

# Function to check if Homebrew is installed
check_brew() {
  command -v brew >/dev/null 2>&1
}

# Function to install Homebrew
install_package_manager() {
  # Ensure homebrew for macOS
  if [ "$(uname)" = "Darwin" ]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # TODO: Ensure apt-get for linux
  elif [ "$(uname)" = "Linux" ]; then  
  else
    echo "Unsupported OS: $(uname)"
    exit 1
  fi
}

# Main script execution
if ! check_brew; then
  install_homebrew
else
  echo "Homebrew is already installed."
fi

exit 0

