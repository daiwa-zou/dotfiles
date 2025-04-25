return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        bash = { 'shellcheck' },
        go = { 'golangcilint' },
        protobuf = { 'pbls' },
      }

      local goci = lint.linters.golangcilint

      goci.args = {
        'run',
        '--output.json.path=stdout',
        '--issues-exit-code=0',
        '--show-stats=false',
        function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
        end,
      }

      lint.linters_by_ft = lint.linters_by_ft or {}

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>local', function()
        lint.try_lint()
      end, { desc = 'Trigger linting for current file' })
    end,
  },
}
