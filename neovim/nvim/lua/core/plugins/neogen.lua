return {
  'danymat/neogen',
  config = true,
  version = '*',
  cmd = 'Neogen',
  keys = {
    {
      '<leader>cn',
      function()
        require('neogen').generate()
      end,
      desc = 'Generate Annotations (Neogen)',
    },
  },
}
