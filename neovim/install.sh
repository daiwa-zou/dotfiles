#!/bin/sh

source lib/helper.sh

#
# Neovim
#
# Setup neovim configuration.
#

NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

check_neovim_configured() {
    if [ -d "$NVIM_DIR" ]; then
        return 0
    else
        return 1
    fi
}

configure_neovim() {
    local local_nvim_configs="${DOTFILES:-$DOTFILES_ROOT}/neovim/nvim"
    info "Configuring neovim..."
    link_file "$local_nvim_configs" "$NVIM_DIR"
    success "Configured neovim"
}

if ! check_neovim_configured; then
    configure_neovim
else
    success "Neovim is already configured"
fi

exit 0
