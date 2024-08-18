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

setup_gitconfig () {
  local config_file="git/gitconfig.local.symlink"
  local example_file="git/gitconfig.local.symlink.example"
  
  if [ ! -f "$config_file" ]; then
    echo "Setting up gitconfig..."

    # Determine credential helper based on OS
    local git_credential="cache"
    if [ "$(uname -s)" = "Darwin" ]; then
      git_credential="osxkeychain"
    fi

    # Prompt user for Git author information
    echo -n " - What is your GitHub author name? "
    read -r git_authorname
    if [ -z "$git_authorname" ]; then
      echo "Error: Author name cannot be empty." >&2
      return 1
    fi

    echo -n " - What is your GitHub author email? "
    read -r git_authoremail
    if [ -z "$git_authoremail" ]; then
      echo "Error: Author email cannot be empty." >&2
      return 1
    fi

    # Generate the git configuration file
    sed -e "s/AUTHORNAME/$git_authorname/g" \
        -e "s/AUTHOREMAIL/$git_authoremail/g" \
        -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
        "$example_file" > "$config_file"

    if [ $? -eq 0 ]; then
      echo "Git configuration setup completed successfully."
    else
      echo "Error: Failed to generate git configuration." >&2
      return 1
    fi
  else
    echo "Git configuration already set up."
  fi
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

# Execute functions
run_installers
install_packages
setup_gitconfig
install_dotfiles
if ! check_zsh_installed; then
    # Set zsh as the default shell
    set_zsh_as_default
fi

echo "Setup completed successfully."
