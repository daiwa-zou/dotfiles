#!/bin/bash

source lib/helper.sh

#
# Bootstrap
#
# The main entrypoint for the setup of user configuration.

set -e

# Set script parent directory as DOTFILES_ROOT and export for sub-installers
DOTFILES_ROOT=$(pwd -P)
export DOTFILES_ROOT

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
        info "Running installer: $installer"
        if ! sh -c "$installer"; then
            fail "Failed to run installer $installer"
        fi
    done
}

# Main script execution
run_installers
install_dotfiles

success "Setup completed successfully."
exit 0
