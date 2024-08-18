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
install_homebrew() {
  echo "Installing Homebrew..."

  # Install Homebrew for macOS
  if [ "$(uname)" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Install Homebrew (Linuxbrew) for Linux
  elif [ "$(uname)" = "Linux" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
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

