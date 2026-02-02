return {
  -- Core LSP packages
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP package manager
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- LSP completion integration
      'hrsh7th/cmp-nvim-lsp',

      -- Optional: LSP UI improvements
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
    config = function()
      -- Setup Mason first (required)
      require('mason').setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      require('mason-lspconfig').setup({
        -- Servers to automatically install
        ensure_installed = {
          "lua_ls",
          "ruby_lsp",
          "ts_ls",
          "volar",
        },
        automatic_installation = true,
      })

      -- LSP settings
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Define on_attach function for keymaps and settings
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Key mappings
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)

        -- Add diagnostic navigation
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
      end

      -- Configure lua_ls for Neovim Lua API
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- TypeScript configuration
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
      })

      -- Vue configuration (Volar)
      lspconfig.volar.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "vue" },
      })

      -- Ruby LSP specific configuration
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "ruby-lsp" },
        filetypes = { "ruby" },
        root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
        init_options = {
          formatter = "auto",  -- Use the Ruby LSP's default formatter
        },
        settings = {
          rubylsp = {
            diagnostics = true,
            formatter = {
              enable = true,
            },
            rubyVersionManager = "asdf",
            includePaths = {
              -- ASDF Ruby standard library paths
              vim.fn.expand("~/.asdf/installs/ruby/*/lib/ruby/*/"),
              -- ASDF Ruby gem paths
              vim.fn.expand("~/.asdf/installs/ruby/*/lib/ruby/gems/*/gems/*/lib"),
              -- Project bundled gems
              vim.fn.getcwd() .. "/vendor/bundle/ruby/*/gems/*/lib",
            }
          }
        }
      })

      -- Setup other language servers with default config
      local servers = {
        -- Add any other language servers here that you want with default config
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
        },
      })

      -- Add border to hover and signature help
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = "rounded" }
      )
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end
  }
}
