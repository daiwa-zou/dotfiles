# horus.nvim

```ascii
     /\_/\
    ((@v@))
    ():::()
     VV-VV
```

## Description

Basic neovim configuration for personal use

## Installation

### Install Neovim

horus.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

### Install Configuration

```sh
git clone git@github.com:daiwa-zou/horus.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
