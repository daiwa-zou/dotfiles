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
    if ln -s "$1" "$2"; then
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

# Run the installation
install_dotfiles

