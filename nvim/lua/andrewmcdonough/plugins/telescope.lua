return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    vim.api.nvim_create_user_command('Rg', function(opts)
      if opts.args and opts.args ~= "" then
        require('telescope.builtin').grep_string({ search = opts.args })
      else
        require('telescope.builtin').live_grep()
      end
    end, { nargs = '?', desc = 'Search with ripgrep via Telescope' })


    telescope.load_extension("fzf")
  end,
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = "Find Files" },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = "Live Grep" },
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = "Find Buffers" },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = "Help Tags" },
    { '<leader>fl', function() require('telescope.builtin').lsp_references() end, desc = "LSP References" },
    { '<C-p>', function() require('telescope.builtin').find_files() end, desc = "Find Files (FZF)" },
    { '<leader>b', function() require('telescope.builtin').buffers() end, desc = "Find Buffers (FZF)" },
  },
}
