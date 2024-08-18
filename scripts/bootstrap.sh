#!/bin/bash
set -e

# Change directory to the parent directory of this script
# Set script parent directory as DOTFILES_ROOT
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Print formatted info message to stdout
info() {
    printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

success() {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
    echo ''
    exit 1
}

# Link file
link_file() {
    if ln -sf "$1" "$2"; then
        success "Linked $1 to $2"
    else
        fail "Failed to link $1 to $2"
    fi
}

# Find all files with .lnk extension and link them to user home directory
install_dotfiles() {
    info 'Installing dotfiles'

    find "$DOTFILES_ROOT" -maxdepth 2 -name '*.lnk' -print0 | while IFS= read -r -d '' source; do
        destination="$HOME/.$(basename "${source%.*}")"
        link_file "$source" "$destination"
    done
}

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

# Execute functions
run_installers
install_packages
install_dotfiles

echo "Setup completed successfully."
