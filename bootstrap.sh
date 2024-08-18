#!/bin/bash
set -e

# Set script parent directory as DOTFILES_ROOT
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
  local config_file="git/gitconfig.local.lnk"
  local example_file="git/gitconfig.local.lnk.example"
  
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

# Function to create a symbolic link with overwrite handling
link_file() {
    local source="$1"
    local destination="$2"

    # Check if the source file exists
    if [ ! -e "$source" ]; then
        fail "Source file $source does not exist"
        return 1
    fi

    # Check if the destination directory exists
    local dest_dir
    dest_dir=$(dirname "$destination")
    if [ ! -d "$dest_dir" ]; then
        fail "Destination directory $dest_dir does not exist"
        return 1
    fi

    # If the destination exists and is not a symbolic link, remove it
    if [ -e "$destination" ] && [ ! -L "$destination" ]; then
        rm -rf "$destination"
        if [ $? -ne 0 ]; then
            fail "Failed to remove existing file $destination"
            return 1
        fi
    fi

    # Create the symbolic link
    if ln -sf "$source" "$destination"; then
        success "Linked $source to $destination"
    else
        fail "Failed to link $source to $destination"
    fi
}

# Function to print success messages
success() {
    echo "Success: $1"
}

# Function to print failure messages
fail() {
    echo "Error: $1" >&2
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

# Function to install oh-my-zsh
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
        if curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended; then
            echo "Oh My Zsh installed successfully."
        else
            echo "Failed to install Oh My Zsh using curl."
            return 1
        fi
    elif command -v wget > /dev/null 2>&1; then
        if wget --quiet https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | sh -s -- --unattended; then
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

# Execute functions
run_installers
install_packages
setup_gitconfig
install_oh_my_zsh
install_dotfiles
if ! check_zsh_installed; then
    # Set zsh as the default shell
    set_zsh_as_default
fi

echo "Setup completed successfully."
