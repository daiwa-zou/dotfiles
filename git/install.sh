#!/bin/sh

source lib/helper.sh

#
# Git
#
# This setup git config.

# Set up github config
setup_gitconfig () {
  local config_file="git/gitconfig.local.lnk"
  local example_file="git/gitconfig.local.lnk.example"
  
  if [ ! -f "$config_file" ]; then
    info "Setting up gitconfig..."

    # Determine credential helper based on OS
    local git_credential="cache"
    if [ "$(uname -s)" = "Darwin" ]; then
      git_credential="osxkeychain"
    fi

    # Prompt user for Git author information
    echo -n " - What is your GitHub author name? "
    read -r git_authorname
    if [ -z "$git_authorname" ]; then
      fail "Author name cannot be empty" >&2
    fi

    echo -n " - What is your GitHub author email? "
    read -r git_authoremail
    if [ -z "$git_authoremail" ]; then
      fail "Author email cannot be empty" >&2
    fi

    # Generate the git configuration file
    sed -e "s/AUTHORNAME/$git_authorname/g" \
        -e "s/AUTHOREMAIL/$git_authoremail/g" \
        -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
        "$example_file" > "$config_file"

    if [ $? -eq 0 ]; then
      success "Git configuration setup completed successfully"
    else
      fail "Failed to generate git configuration" >&2
    fi
  else
    success "Git configuration already set up"
  fi
}

# Main script execution
setup_gitconfig

exit 0
