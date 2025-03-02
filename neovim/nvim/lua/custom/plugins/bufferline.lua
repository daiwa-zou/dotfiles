return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    { '<leader>gb', '<cmd>BufferLinePick<cr>', desc = 'Toggle bufferline pick' },
  },
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.minimal,
        separator_style = 'slant',
        sort_by = 'directory',
        diagnostics = 'nvim_lsp',
      },
    }
  end,
}
