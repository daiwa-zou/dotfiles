# Plugins

## Plugin Manager

**[lazy.nvim](https://github.com/folke/lazy.nvim)** — Loaded from `init.lua`. Plugins are split into two groups:
- `lua/core/plugins/` — core functionality (LSP, completion, debugging, formatting)
- `lua/custom/plugins/` — UI and personal customizations

---

## Core Plugins

### LSP — nvim-lspconfig

Configures language servers via Mason (auto-install) and native LSP client.

**Configured servers:** gopls (Go), lua_ls (Lua), jsonls (JSON), dockerls, docker_compose_language_service, pbls (Protobuf)

**Mason auto-installs:**
- Formatters: `stylua`, `jq`, `gofumpt`
- Linters: `markdownlint`, `golangci-lint`
- DAP adapters: `codelldb`

LSP keymaps are set per-buffer on `LspAttach`. See [keymaps.md](./keymaps.md#lsp----leaderc-leaderd-leaderw).

---

### Completion — blink.cmp

Modern completion engine with LSP, snippets, path, and buffer sources. Uses a Rust-based fuzzy matcher.

**Accept completion:** `<C-y>`
**Scroll docs:** `<C-b>` / `<C-f>`
**Navigate items:** `<C-n>` / `<C-p>`

Snippets come from `friendly-snippets`. Documentation auto-shows in a side window.

---

### Fuzzy Finder — fzf-lua

All search operations go through fzf-lua. See [keymaps.md](./keymaps.md#search----leaders) for the full list.

**Tips:**
- `<leader>sg` for live grep across the project
- `<leader>/` to fuzzy-search within the current buffer
- `<leader>sn` opens the Neovim config directory directly
- `<leader>sr` resumes the last search session

---

### File Explorer — oil.nvim

Editable directory buffers. Navigate directories like a normal file, make edits, save to apply.

| Key | Action |
|-----|--------|
| `<leader>e` | Open parent directory |
| `-` | Go up a directory |
| `<CR>` | Open file / enter directory |
| `<C-s>` | Open in vertical split |
| `<C-h>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-p>` | Preview |
| `<C-c>` | Close |
| `<C-l>` | Refresh |

Hidden files are shown by default. Deleted files go to trash.

---

### Formatter — conform.nvim

Async formatting with LSP fallback. Format-on-save is enabled (1.5s timeout).

| Filetype | Formatter |
|----------|-----------|
| Lua | stylua |
| Go | gofumpt |
| Rust | rustfmt |
| JSON | jq |
| Protobuf | pbls |

**Manual format:** `<leader>f`

---

### Linter — nvim-lint

Runs on `BufEnter`, `BufWritePost`, and `InsertLeave`.

| Filetype | Linter |
|----------|--------|
| Go | golangci-lint |
| Markdown | markdownlint |
| Bash | shellcheck |
| Protobuf | pbls |

---

### Syntax — treesitter

Installed grammars: bash, go, rust, toml, lua, luadoc, json, dockerfile, gitcommit, diff, vim, vimdoc

**nvim-treesitter-context** shows up to 3 lines of scope context at the top of the buffer.

---

### Debugger — nvim-dap

**Go:** Uses Delve via `nvim-dap-go`. Run `<F5>` in a Go file to start.
**Rust / C++:** Uses `codelldb`. On `<F5>` it prompts for the executable path.

DAP UI opens automatically when a session starts (`<F7>` to toggle manually).

See [keymaps.md](./keymaps.md#debugger----f-leaderb) for all debug keymaps.

---

### Diagnostics — trouble.nvim

A panel for browsing LSP diagnostics, references, and quickfix lists.

| Key | Panel |
|-----|-------|
| `<leader>xx` | All diagnostics |
| `<leader>xX` | Current buffer diagnostics |
| `<leader>cs` | Document symbols |
| `<leader>cl` | LSP definitions & references |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

---

### Git Signs — gitsigns.nvim

Shows added/changed/removed lines in the sign column. Integrates with the statuscolumn via snacks.

**Hunk navigation:** `]c` / `[c`
**Stage, reset, preview, blame:** see [keymaps.md](./keymaps.md#git----leaderg-leaderh-leadert)

---

### Code Outline — aerial.nvim

Symbol tree sidebar showing functions, types, methods, etc.

| Key | Action |
|-----|--------|
| `<leader>co` | Toggle outline |
| `{` / `}` | Jump to previous/next symbol (in aerial buffer) |

---

### Refactoring — refactoring.nvim

Treesitter-based code refactoring. Works in visual mode for extraction operations.

| Key | Action | Mode |
|-----|--------|------|
| `<leader>re` | Extract to function | x |
| `<leader>rf` | Extract to file | x |
| `<leader>rv` | Extract variable | x |
| `<leader>ri` | Inline variable | n, x |
| `<leader>rI` | Inline function | n |
| `<leader>rb` | Extract block | n |
| `<leader>rbf` | Extract block to file | n |

Go is configured to prompt for type annotations during extraction.

---

### Annotation Generator — neogen

Generates documentation comments (JSDoc, GoDoc, LuaDoc, etc.) for the item under the cursor.

| Key | Action |
|-----|--------|
| `<leader>cn` | Generate annotation |

---

### Rust — rustaceanvim

Drop-in replacement for the Rust LSP setup. Adds Rust-specific commands on top of standard LSP.

**Config:** all features enabled, clippy for checking, proc macros enabled, inlay hints with lifetime elision.

See [keymaps.md](./keymaps.md#rust----leaderr-rust-files-only).

---

### Cargo Helper — crates.nvim

Loads automatically when a `Cargo.toml` is opened. Shows crate versions inline and provides a popup UI.

See [keymaps.md](./keymaps.md#cargotoml----leaderc-cargotoml-only).

---

### Indent Guides & Char Toggle — blink.nvim

Two features bundled:

**Indent guides** — static `▎` guides with 7-color rainbow scope highlighting.

**Chartoggle** — add or remove a character at the end of a line:

| Key | Action | Mode |
|-----|--------|------|
| `<C-;>` | Toggle `;` at EOL | n, v |
| `,` | Toggle `,` at EOL | n, v |

---

## Custom Plugins

### Theme — kanagawa.nvim

Dark colorscheme. Comments have italic disabled.

---

### Statusline, Pairs, Surround, Text Objects — mini.nvim

Five `mini.*` modules are loaded:

| Module | Purpose |
|--------|---------|
| mini.statusline | Simple status bar with file info and diagnostics |
| mini.pairs | Auto-close brackets, quotes, parens |
| mini.ai | Extended text objects (`a` = around, `i` = inside for functions, classes, etc.) |
| mini.surround | Add (`sa`), delete (`sd`), replace (`sr`) surrounding characters |
| mini.icons | Icon provider used by other plugins |

**mini.surround examples:**
- `saiw"` — surround word with `"`
- `sd"` — delete surrounding `"`
- `sr"'` — replace surrounding `"` with `'`

---

### Buffer Tabs — bufferline.nvim

Displays open buffers as tabs. Sorts by directory. Shows LSP diagnostics per buffer.

| Key | Action |
|-----|--------|
| `<leader>gb` | Pick buffer interactively |

---

### UI Enhancements — snacks.nvim

Collection of small UI improvements:

| Feature | What it does |
|---------|-------------|
| **notifier** | Replaces `vim.notify` with a floating notification UI |
| **input** | Replaces `vim.ui.input` with a nicer prompt |
| **dashboard** | Startup screen with recent files and shortcuts |
| **indent** | Indent scope guides |
| **scroll** | Smooth scrolling (15ms steps, 120ms total) |
| **words** | Highlights all references to the word under cursor; `]w`/`[w` to jump |
| **statuscolumn** | Git signs + diagnostic icons in the gutter |
| **bigfile** | Disables heavy features for large files |
| **quickfile** | Faster file opening |
| **lazygit** | Embedded LazyGit terminal |
| **gitbrowse** | Opens current file/line in the browser (GitHub, GitLab, etc.) |
| **bufdelete** | Deletes a buffer without closing the window/split |
| **zen** | Distraction-free writing mode |

**Keymaps:**

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gB` | Git browse |
| `<leader>bd` | Delete buffer |
| `<leader>z` | Zen mode |
| `]w` | Next word reference |
| `[w` | Previous word reference |

---

### Keymap Help — which-key.nvim

Shows a popup of available keybindings after pressing the leader key (300ms timeout).

Leader groups configured:

| Prefix | Label |
|--------|-------|
| `<leader>a` | AI (Claude) |
| `<leader>c` | Code |
| `<leader>d` | Document |
| `<leader>g` | Git |
| `<leader>h` | Git Hunk |
| `<leader>r` | Rename / Refactor |
| `<leader>s` | Search |
| `<leader>t` | Toggle |
| `<leader>w` | Workspace |

---

### Claude Code — claudecode.nvim

Integrates Claude Code into Neovim. Opens Claude in a terminal split and supports diff review.

| Key | Action | Mode |
|-----|--------|------|
| `<leader>ac` | Toggle Claude terminal | n |
| `<leader>af` | Focus Claude terminal | n |
| `<leader>ar` | Resume last Claude session | n |
| `<leader>aS` | Send visual selection to Claude | v |
| `<leader>ab` | Add current buffer as context | n |
| `<leader>aa` | Accept suggested diff | n |
| `<leader>ad` | Deny suggested diff | n |

---

### TODO Highlighting — todo-comments.nvim

Highlights `TODO`, `FIXME`, `HACK`, `WARN`, `NOTE`, `PERF` comments in any file. Signs are disabled.

Use `<leader>st` (if configured) or `:TodoFzfLua` to search all TODOs in the project.

---

### Lua LSP Dev — lazydev.nvim

Provides type hints and completions for the Neovim Lua API when editing config files. Automatically active for `.lua` files inside the Neovim config directory.
