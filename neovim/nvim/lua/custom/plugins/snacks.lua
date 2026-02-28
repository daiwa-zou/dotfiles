return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- Performance
    bigfile   = { enabled = true },
    quickfile = { enabled = true },

    -- UI replacements
    notifier = { enabled = true },
    input    = { enabled = true },

    -- Editor enhancements
    indent = { enabled = true },
    words  = { enabled = true },
    scroll = { enabled = true, animate = { duration = { step = 15, total = 120 } } },

    -- Column / gutter
    statuscolumn = { enabled = true },

    -- Git
    lazygit   = { enabled = true },
    gitbrowse = { enabled = true },

    -- Misc
    bufdelete = { enabled = true },
    zen       = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        { section = 'keys',         gap = 1, padding = 1 },
        { section = 'recent_files', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },
  keys = {
    { '<leader>gg',  function() Snacks.lazygit() end,       desc = 'LazyGit' },
    { '<leader>gB',  function() Snacks.gitbrowse() end,     desc = 'Git Browse' },
    { '<leader>bd',  function() Snacks.bufdelete() end,     desc = 'Delete Buffer' },
    { '<leader>z',   function() Snacks.zen() end,           desc = 'Zen Mode' },
    { ']w',          function() Snacks.words.jump(1) end,   desc = 'Next Reference' },
    { '[w',          function() Snacks.words.jump(-1) end,  desc = 'Prev Reference' },
  },
}
