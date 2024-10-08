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

# Set up github config
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

# Find all files with .lnk extension and link them to user home directory
install_dotfiles() {
    info 'Installing dotfiles'

    find "$DOTFILES_ROOT" -maxdepth 2 -name '*.lnk' -print0 | while IFS= read -r -d '' source; do
        destination="$HOME/.$(basename "${source%.*}")"
        link_file "$source" "$destination"
    done
}
