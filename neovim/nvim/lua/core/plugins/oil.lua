return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    view_options = { show_hidden = true },
  },
  keys = {
    { '<leader>e', '<CMD>Oil<CR>', desc = 'Open parent directory (oil)' },
  },
}
