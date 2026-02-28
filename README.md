# dotfiles

Personal macOS configuration managed via symlinks. Clone, run the bootstrap, and everything links itself into place.

## Prerequisites

- macOS
- `git`
- `curl` (for Oh My Zsh install)

## Installation

Clone as `~/.dotfiles` and run the bootstrap:

```bash
git clone https://github.com/daiwa-zou/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./bootstrap.sh
```

The bootstrap script installs Homebrew packages, runs each subdirectory's `install.sh`, then symlinks all `*.lnk` files to `~/.<name>`.

> I'd recommend forking this repo and customizing it rather than using it as-is.

## How It Works

Any file named `foo.lnk` (up to two directories deep) gets linked to `~/.foo`:

```
zsh/zshrc.lnk          → ~/.zshrc
git/gitconfig.lnk      → ~/.gitconfig
tmux/tmux.conf.lnk     → ~/.tmux.conf
```

To re-run only package installation:

```bash
brew bundle --file=homebrew/Brewfile
```

## What's Included

### Zsh

- **Oh My Zsh** with plugins: `git`, `git-auto-fetch`, `colored-man-pages`, `brew`, `colorize`, `golang`, `rust`, `tmux`, `fancy-ctrl-z`, and more
- All `*.zsh` files in the repo are auto-loaded in order: `path.zsh` → everything else → `completion.zsh`
- Shell functions in `functions/` are added to `$fpath` and autoloaded
- Machine-local env vars: create `~/.localrc` (sourced automatically, not committed)

Key files:

| File | Purpose |
|------|---------|
| `zsh/zshrc.lnk` | Main zsh config, plugins, Oh My Zsh setup |
| `zsh/aliases.zsh` | Shell aliases (`cat` → `ccat`, `less` → `cless`, etc.) |
| `zsh/config.zsh` | Zsh options and settings |
| `zsh/path.zsh` | PATH additions |

### Neovim

Full Neovim setup using [lazy.nvim](https://github.com/folke/lazy.nvim). See [`docs/neovim/`](./docs/neovim/) for the full plugin and keymap reference.

Highlights:

- **Fuzzy finding** — fzf-lua (`<leader>s*`)
- **LSP** — gopls, lua_ls, jsonls, dockerls, pbls, rustaceanvim
- **Completion** — blink.cmp with LSP, snippets, path sources
- **Formatting** — conform.nvim (stylua, gofumpt, rustfmt, jq) with format-on-save
- **Linting** — nvim-lint (golangci-lint, markdownlint, shellcheck)
- **Debugging** — nvim-dap with Delve (Go) and codelldb (Rust)
- **File explorer** — oil.nvim (editable directory buffers)
- **Git** — gitsigns, LazyGit, gitbrowse via snacks.nvim
- **AI** — Claude Code integration via claudecode.nvim (`<leader>a*`)
- **Theme** — Kanagawa

Key files:

| File | Purpose |
|------|---------|
| `neovim/nvim/lua/core/plugins/` | LSP, completion, formatting, debugging |
| `neovim/nvim/lua/custom/plugins/` | UI, theme, Claude Code |
| `neovim/nvim/lua/custom/configs/options.lua` | Editor options and global keymaps |
| `neovim/nvim/lua/custom/configs/autocmd.lua` | Autocommands and extra keymaps |

### Git

Conventional commit aliases with optional `--scope`/`-s` and `--attention`/`-a` flags:

```bash
git feat my new feature           # → commit -m "feat: my new feature"
git fix -s auth broken login      # → commit -m "fix(auth): broken login"
git feat -a breaking change       # → commit -m "feat!: breaking change"
```

Available types: `feat`, `fix`, `chore`, `docs`, `ci`, `build`, `perf`, `refactor`, `style`, `test`, `wip`, `rev`

Sensitive config (name, email) goes in `git/gitconfig.local.lnk`, generated on first run from the `.example` template. Not committed.

### Tmux

Prefix remapped to `C-Space`. Key bindings:

| Key | Action |
|-----|--------|
| `C-Space` | Prefix |
| `\|` | Split horizontal |
| `-` | Split vertical |
| `\\` | Split full-width horizontal |
| `_` | Split full-width vertical |
| `<` / `>` | Swap window left/right |
| `r` | Reload config |
| `` ` `` | Jump to marked pane |

Default session name: `workspace`. Mouse support enabled.

### Homebrew

Packages installed via `homebrew/Brewfile`: `git`, `nvim`, `tmux`, `lazygit`, `ripgrep`, `go`, `npm`, `python`, `chroma`, `cowsay`, `fortune`, and more.

## Documentation

- [`docs/neovim/README.md`](./docs/neovim/README.md) — Neovim overview and language support
- [`docs/neovim/keymaps.md`](./docs/neovim/keymaps.md) — Full keymap reference
- [`docs/neovim/plugins.md`](./docs/neovim/plugins.md) — Plugin-by-plugin usage guide
