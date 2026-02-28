# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A personal dotfiles repository for macOS. Configuration is managed via symlinks — files with `.lnk` extensions are linked to `$HOME/.<filename>` (without the `.lnk` extension) during bootstrap.

## Setup / Installation

Run from the repo root (must be cloned as `~/.dotfiles`):

```bash
./bootstrap.sh
```

This runs all `install.sh` scripts found in subdirectories, then symlinks all `*.lnk` files to `~/.<name>`.

To re-run only package installation:
```bash
brew bundle --file=homebrew/Brewfile
```

To re-apply symlinks without running installers, the logic is in `bootstrap.sh:install_dotfiles()`.

## Architecture

### Symlink convention
Any file named `foo.lnk` in a subdirectory (up to `maxdepth 2`) gets linked to `~/.foo`. For example:
- `zsh/zshrc.lnk` → `~/.zshrc`
- `git/gitconfig.lnk` → `~/.gitconfig`
- `git/gitconfig.local.lnk` → `~/.gitconfig.local` (generated from `gitconfig.local.lnk.example` during `git/install.sh`)

### Zsh configuration loading order
`zshrc.lnk` sources all `*.zsh` files from the dotfiles tree in this order:
1. `*/path.zsh` files first
2. All other `*.zsh` files (except `path.zsh` and `completion.zsh`)
3. `*/completion.zsh` files last (after `compinit`)

To add shell config, add a `*.zsh` file anywhere in the repo; it will be auto-loaded.

### Custom functions
Shell functions placed in `functions/` are added to `$fpath` and autoloaded.

### Neovim (`neovim/nvim/`)
Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as plugin manager. Plugin specs live in two locations:
- `lua/core/plugins/` — core plugins (LSP, treesitter, telescope, completion via blink-cmp, DAP, linting/formatting)
- `lua/custom/plugins/` — personal customizations (colorscheme, bufferline, etc.)

Config entry point: `init.lua` loads `custom.configs.options`, `custom.configs.autocmd`, then lazy.nvim.

### Git aliases
`git/gitconfig.lnk` defines conventional commit aliases (`feat`, `fix`, `chore`, `docs`, etc.) with optional `--scope`/`-s` and `--attention`/`-a` flags:
```bash
git feat -s auth my message        # → commit -m "feat(auth): my message"
git fix -a critical bug            # → commit -m "fix!: critical bug"
```

### Sensitive/local config
- `git/gitconfig.local.lnk` — generated on first run; contains `[user]` name/email. Not committed.
- `~/.localrc` — sourced by `zshrc.lnk` if it exists; for machine-local env vars.

## Key files to edit

| Goal | File |
|------|------|
| Add Homebrew packages | `homebrew/Brewfile` |
| Add/change zsh aliases | `zsh/aliases.zsh` |
| Add/change zsh options | `zsh/config.zsh` |
| Add PATH entries | `zsh/path.zsh` (or `functions/path.zsh`) |
| Change shell plugins | `zsh/zshrc.lnk` (plugins array) |
| Git global config | `git/gitconfig.lnk` |
| Neovim options | `neovim/nvim/lua/custom/configs/options.lua` |
| Neovim autocommands | `neovim/nvim/lua/custom/configs/autocmd.lua` |
| Add neovim plugins | `neovim/nvim/lua/custom/plugins/` |
