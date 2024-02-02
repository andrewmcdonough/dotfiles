local status, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night')
if not status then
  print('Error loading colorscheme')
  return
end

-- Create a function to open a color scheme picker
local pickers = require'telescope.pickers'
local finders = require'telescope.finders'
local actions = require'telescope.actions'
local action_state = require'telescope.actions.state'
local conf = require'telescope.config'.values

local function colorscheme_picker()
  local colorschemes = vim.fn.getcompletion('', 'color')

  pickers.new({}, {
    prompt_title = 'Color Schemes',
    finder = finders.new_table {
      results = colorschemes,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd('colorscheme ' .. selection[1])
      end)
      return true
    end,
  }):find()
end

-- Assign the function to a global variable for easy access
_G.colorscheme_picker = colorscheme_picker

-- Create a command to easily call this function
vim.api.nvim_create_user_command('CycleColorschemes', colorscheme_picker, {})
