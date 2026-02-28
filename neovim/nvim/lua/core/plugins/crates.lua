return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  opts = {
    lsp = {
      enabled = true,   -- registers as LSP server → blink.cmp picks it up automatically
      actions = true,
      completion = true,
      hover = true,
    },
  },
  config = function(_, opts)
    local crates = require 'crates'
    crates.setup(opts)
    vim.api.nvim_create_autocmd('BufRead', {
      pattern = 'Cargo.toml',
      callback = function(ev)
        local map = function(keys, cmd, desc)
          vim.keymap.set('n', keys, cmd, { buffer = ev.buf, desc = desc })
        end
        map('<leader>ct', crates.toggle, 'Crates Toggle')
        map('<leader>cr', crates.reload, 'Crates Reload')
        map('<leader>cv', crates.show_versions_popup, 'Crates Show Versions')
        map('<leader>cf', crates.show_features_popup, 'Crates Show Features')
        map('<leader>cu', crates.update_crate, 'Crates Update Crate')
        map('<leader>cU', crates.update_all_crates, 'Crates Update All')
        map('<leader>cA', crates.upgrade_all_crates, 'Crates Upgrade All')
      end,
    })
  end,
}
