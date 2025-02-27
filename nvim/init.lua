vim.g.mapleader = " "
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.opt.termguicolors = true

-- Load plugins
require('andrewmcdonough.plugins-setup')

-- Load core configuration
require('andrewmcdonough.core.keymaps')
require('andrewmcdonough.core.options')
require('andrewmcdonough.core.colorscheme')

-- Load custom functions
require('andrewmcdonough.functions.ruby')
require('andrewmcdonough.functions.nvim')
