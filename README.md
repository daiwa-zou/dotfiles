# My Dotffiles

This repository contains my personal configuration files for various tools and applications.
This setup provides a simple framework to create and modify a custom workspace.

## Depedencies

Ensure you have the following installed before proceeding:

- `curl` or `wget`
- `git`

## Features

- **Zsh setup and configuration**
  - Update `zsh/zshrc.lnk` for zsh configurations.
  - Reference [plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) for more zsh plugin information.
- **Homebrew setup**
  - Update `homebrew/Brewfile` to install packages.
- **Neovim setup and configuration**
  - Update `neovim/nvim` for neovim configurations.
- **Tmux setup and configuration**
  - Update `tmux/tmux.conf.lnk` for tmux configurations.
- **Git configuration**
  - Update `git/**` files for git configurations.
- **Custom scripts**
  - Custom bash functions can be placed under `functions` directory and will be loaded.

## Installation

I would fork this repository and modify as needed rather than using what I have here:

```bash
git clone https://github.com/daiwa-zou/dotfiles.git .dotfiles && cd .dotfiles && ./bootstrap.sh
```
