return {
  'coder/claudecode.nvim',
  config = function()
    require('claudecode').setup {
      terminal = { provider = 'native' },
    }
  end,
  keys = {
    { '<leader>ac', '<cmd>ClaudeCode<cr>',            desc = 'Toggle Claude' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>',       desc = 'Focus Claude' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<cr>',   desc = 'Resume Claude' },
    { '<leader>aS', '<cmd>ClaudeCodeSend<cr>',        mode = 'v', desc = 'Send to Claude' },
    { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>',       desc = 'Add buffer to Claude' },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>',  desc = 'Accept diff' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>',    desc = 'Deny diff' },
  },
}
