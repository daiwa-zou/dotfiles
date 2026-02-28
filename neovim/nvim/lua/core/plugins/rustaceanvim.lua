return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  config = function()
    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('blink.cmp').get_lsp_capabilities({}, false)
    )
    vim.g.rustaceanvim = {
      server = {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          local map = function(keys, cmd, desc)
            vim.keymap.set('n', keys, cmd, { buffer = bufnr, desc = desc })
          end
          -- Rust-specific overrides (buffer-local, take precedence over generic LSP keymaps)
          map('K', function() vim.cmd.RustLsp { 'hover', 'actions' } end, 'Rust Hover Actions')
          map('<leader>ca', function() vim.cmd.RustLsp 'codeAction' end, 'Rust Code Action')
          -- Rust workflow
          map('<leader>rr', function() vim.cmd.RustLsp 'runnables' end, 'Rust Runnables')
          map('<leader>rt', function() vim.cmd.RustLsp 'testables' end, 'Rust Testables')
          map('<leader>rm', function() vim.cmd.RustLsp 'expandMacro' end, 'Rust Expand Macro')
          map('<leader>rc', function() vim.cmd.RustLsp 'openCargo' end, 'Rust Open Cargo.toml')
          map('<leader>rd', function() vim.cmd.RustLsp 'renderDiagnostic' end, 'Rust Render Diagnostic')
        end,
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true, buildScripts = { enable = true } },
            check = { command = 'clippy', extraArgs = { '--no-deps' } },
            procMacro = { enable = true },
            inlayHints = {
              lifetimeElisionHints = { enable = 'skip_trivial', useParameterNames = true },
            },
          },
        },
      },
    }
  end,
}
