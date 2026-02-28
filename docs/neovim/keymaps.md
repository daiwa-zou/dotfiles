# Keymaps Reference

Leader key: **`<Space>`**

## Navigation

| Key | Action | Mode |
|-----|--------|------|
| `<C-h>` | Move to left split | n |
| `<C-j>` | Move to lower split | n |
| `<C-k>` | Move to upper split | n |
| `<C-l>` | Move to right split | n |
| `]c` | Next git change | n |
| `[c` | Previous git change | n |
| `]w` | Next word reference | n |
| `[w` | Previous word reference | n |

## Search — `<leader>s`

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search current word |
| `<leader>s.` | Search recent files |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Search fzf builtins |
| `<leader>sd` | Search document diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s/` | Grep in open buffers |
| `<leader>sn` | Search Neovim config files |
| `<leader><leader>` | Find open buffers |
| `<leader>/` | Fuzzy search current buffer |

## LSP — `<leader>c`, `<leader>d`, `<leader>w`

| Key | Action | Mode |
|-----|--------|------|
| `gd` | Go to definition | n |
| `gr` | Go to references | n |
| `gI` | Go to implementation | n |
| `gD` | Go to declaration | n |
| `<leader>D` | Type definition | n |
| `<leader>rn` | Rename symbol | n |
| `<leader>ca` | Code action | n, x |
| `<leader>ds` | Document symbols | n |
| `<leader>ws` | Workspace symbols | n |
| `<leader>th` | Toggle inlay hints | n |

## Diagnostics — `<leader>x`

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle all diagnostics (Trouble) |
| `<leader>xX` | Toggle buffer diagnostics (Trouble) |
| `<leader>xL` | Location list (Trouble) |
| `<leader>xQ` | Quickfix list (Trouble) |
| `<leader>cs` | Symbols (Trouble) |
| `<leader>cl` | LSP definitions/references (Trouble) |
| `<leader>q` | Open diagnostic quickfix list |

## Code Actions — `<leader>c`, `<leader>r`

| Key | Action | Mode |
|-----|--------|------|
| `<leader>co` | Toggle code outline (Aerial) | n |
| `<leader>cn` | Generate annotation (Neogen) | n |
| `<leader>f` | Format buffer | n |
| `<leader>re` | Extract function | x |
| `<leader>rf` | Extract to file | x |
| `<leader>rv` | Extract variable | x |
| `<leader>ri` | Inline variable | n, x |
| `<leader>rI` | Inline function | n |
| `<leader>rb` | Extract block | n |
| `<leader>rbf` | Extract block to file | n |

## Git — `<leader>g`, `<leader>h`, `<leader>t`

| Key | Action | Mode |
|-----|--------|------|
| `<leader>gg` | Open LazyGit | n |
| `<leader>gB` | Git browse (open in browser) | n |
| `<leader>gb` | Pick buffer (bufferline) | n |
| `<leader>hs` | Stage hunk | n, v |
| `<leader>hr` | Reset hunk | n, v |
| `<leader>hS` | Stage buffer | n |
| `<leader>hu` | Undo stage hunk | n |
| `<leader>hR` | Reset buffer | n |
| `<leader>hp` | Preview hunk | n |
| `<leader>hb` | Blame line | n |
| `<leader>hd` | Diff against index | n |
| `<leader>hD` | Diff against last commit | n |
| `<leader>tb` | Toggle blame line | n |
| `<leader>tD` | Toggle show deleted | n |

## Debugger — `<F*>`, `<leader>b`

| Key | Action |
|-----|--------|
| `<F5>` | Continue / start debug session |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<F7>` | Toggle DAP UI |

## AI — `<leader>a`

| Key | Action | Mode |
|-----|--------|------|
| `<leader>ac` | Toggle Claude Code | n |
| `<leader>af` | Focus Claude Code | n |
| `<leader>ar` | Resume Claude Code | n |
| `<leader>aS` | Send selection to Claude | v |
| `<leader>ab` | Add buffer to Claude | n |
| `<leader>aa` | Accept diff | n |
| `<leader>ad` | Deny diff | n |

## Rust — `<leader>r` (Rust files only)

| Key | Action |
|-----|--------|
| `<leader>rr` | Runnables |
| `<leader>rt` | Testables |
| `<leader>rm` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rd` | Render diagnostics |
| `K` | Hover with actions |

## Cargo.toml — `<leader>c` (Cargo.toml only)

| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle crates info |
| `<leader>cr` | Reload crates |
| `<leader>cv` | Show versions popup |
| `<leader>cf` | Show features popup |
| `<leader>cu` | Update crate |
| `<leader>cU` | Update all crates |
| `<leader>cA` | Upgrade all crates |

## UI & Utility

| Key | Action | Mode |
|-----|--------|------|
| `<leader>e` | Open file explorer (Oil) | n |
| `<leader>z` | Zen mode | n |
| `<leader>bd` | Delete buffer | n |
| `<leader>f` | Format buffer | n |
| `<leader>w` | Save file | n |
| `<leader>x` | Save and quit | n |
| `<leader>;` | Append `;` at end of line | n |
| `<Esc>` | Clear search highlights | n |
| `<C-;>` | Toggle `;` at end of line | n, v |
| `,` | Toggle `,` at end of line | n, v |

## Insert / Visual Mode

| Key | Action | Mode |
|-----|--------|------|
| `jj` | Jump to next closing bracket | i |
| `J` | Move line down | v |
| `K` | Move line up | v |
| `<t>:<Esc><Esc>` | Exit terminal mode | t |

## Which-Key Groups

| Prefix | Group |
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
| `<leader>x` | Diagnostics |
