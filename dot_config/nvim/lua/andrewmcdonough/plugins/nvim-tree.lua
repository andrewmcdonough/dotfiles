return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Load the nvim-tree API
    local api = require("nvim-tree.api")

    -- Setup nvim-tree with current options
    require("nvim-tree").setup {
      -- Update the focused file and root directory
      update_focused_file = {
        enable = true,
        update_root = true,
      },

      view = {
        -- Make it slide out from the side
        side = "left",
        width = 30,
      },

      on_attach = function(bufnr)

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)
      end,

      actions = {
        open_file = {
          -- Close the tree when opening a file
          quit_on_open = true,
          window_picker = {
            enable = false,
          },
        },
        change_dir = {
          enable = false,
        },
      },

      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
      },
    }

    -- Toggle nvim-tree with <leader>ex
    vim.keymap.set('n', '<leader>ex', api.tree.toggle, { desc = "Toggle NvimTree" })

    -- Make :Ex open nvim-tree in the directory of the current file
    vim.api.nvim_create_user_command('Ex', function()
      api.tree.open({ find_file = true })
    end, {})
  end,
}
