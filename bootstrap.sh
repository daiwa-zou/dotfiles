#!/bin/bash
set -e

source lib/helper.sh

# Set script parent directory as DOTFILES_ROOT
DOTFILES_ROOT=$(pwd -P)

# Function to create a symbolic link with overwrite handling
link_file() {
    local source="$1"
    local destination="$2"

    # Check if the source file exists
    if [ ! -e "$source" ]; then
        fail "Source file $source does not exist"
    fi

    # Check if the destination directory exists
    local dest_dir
    dest_dir=$(dirname "$destination")
    if [ ! -d "$dest_dir" ]; then
        fail "Destination directory $dest_dir does not exist"
    fi

    # If the destination exists and is not a symbolic link, remove it
    if [ -e "$destination" ] && [ ! -L "$destination" ]; then
        rm -rf "$destination"
        if [ $? -ne 0 ]; then
            fail "Failed to remove existing file $destination"
        fi
    fi

    # Create the symbolic link
    if ln -sf "$source" "$destination"; then
        success "Linked $source to $destination"
    else
        fail "Failed to link $source to $destination"
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

# Main script execution
run_installers
install_dotfiles

success "Setup completed successfully."
