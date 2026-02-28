# Neovim Configuration

Personal Neovim setup using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Directory Structure

```
neovim/nvim/
├── init.lua                        # Entry point
├── .stylua.toml                    # Lua formatter config (160 col, spaces, single quotes)
├── lazy-lock.json                  # Locked plugin versions
└── lua/
    ├── core/plugins/               # Core functionality
    │   ├── aerial.lua              # Code outline / symbol tree
    │   ├── blink-cmp.lua           # Completion engine
    │   ├── blink.lua               # Indent guides + char-toggle
    │   ├── conform.lua             # Code formatter
    │   ├── crates.lua              # Rust Cargo.toml helper
    │   ├── fzf-lua.lua             # Fuzzy finder
    │   ├── gitsigns.lua            # Git signs in gutter + hunk actions
    │   ├── neogen.lua              # Annotation / doc generator
    │   ├── nvim-dap.lua            # Debugger (Go, Rust)
    │   ├── nvim-lint.lua           # Linter
    │   ├── nvim-lspconfig.lua      # LSP servers
    │   ├── oil.lua                 # File explorer
    │   ├── refactoring.lua         # Refactoring tools
    │   ├── rustaceanvim.lua        # Rust-specific LSP extras
    │   ├── treesitter.lua          # Syntax highlighting & parsing
    │   └── trouble.lua             # Diagnostics panel
    └── custom/
        ├── configs/
        │   ├── options.lua         # Editor options & global keymaps
        │   └── autocmd.lua         # Autocommands & extra keymaps
        └── plugins/
            ├── bufferline.lua      # Buffer tabs
            ├── claudecode.lua      # Claude Code AI integration
            ├── colorscheme.lua     # Kanagawa theme
            ├── lazydev.lua         # Lua LSP for Neovim config files
            ├── mini.lua            # Pairs, surround, text objects, statusline
            ├── snacks.lua          # UI enhancements, LazyGit, Zen mode
            ├── todo-comments.lua   # TODO/FIXME highlighting
            └── which-key.lua       # Keymap help popup
```

## Leader Key

**`<Space>`** — used for both `mapleader` and `maplocalleader`.

## Core Editor Options

| Option | Value | Notes |
|--------|-------|-------|
| Line numbers | on | `number = true` |
| Mouse | all modes | `mouse = 'a'` |
| Tab width | 2 spaces | `tabstop/shiftwidth = 2, expandtab = true` |
| Clipboard | system | `unnamedplus` — yanks go to OS clipboard |
| Search | smart case | `ignorecase + smartcase` |
| Scroll offset | 10 lines | `scrolloff = 10` |
| Cursor line | on | `cursorline = true` |
| Which-key timeout | 300ms | `timeoutlen = 300` |

## Language Support

| Language | LSP | Formatter | Linter | Debugger |
|----------|-----|-----------|--------|----------|
| Go | gopls | gofumpt | golangci-lint | Delve (nvim-dap-go) |
| Rust | rustaceanvim | rustfmt | (clippy via LSP) | codelldb |
| Lua | lua_ls | stylua | — | — |
| JSON | jsonls | jq | — | — |
| Docker | dockerls, docker_compose_language_service | — | — | — |
| Protobuf | pbls | pbls | pbls | — |
| Markdown | — | — | markdownlint | — |
| Bash | — | — | shellcheck | — |

## Documentation Files

- [keymaps.md](./keymaps.md) — Full keymap reference organized by category
- [plugins.md](./plugins.md) — Plugin-by-plugin usage guide
