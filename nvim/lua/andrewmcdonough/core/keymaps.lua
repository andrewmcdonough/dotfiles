vim.g.mapleader = " "

local keymap = vim.keymap

-- Moving around buffers and tabs
keymap.set("n", "<C-n>", ":bprev<CR>") -- Previous buffer
keymap.set("n", "<C-m>", ":bnext<CR>") -- Next buffer
keymap.set("n", "{", ":tabprev<CR>")   -- Previus tab
keymap.set("n", "}", ":tabnext<CR>")   -- Next tab

-- ALE
keymap.set("n", "<leader>f", ":ALELint<CR>")

-- Pry
keymap.set("n", "<leader>pry", 'orequire "pry"; binding.pry<ESC>^')
keymap.set("n", "<leader>prr", 'orequire "pry"; binding.pry_remote<ESC>^')

-- fzf - moving to telescope
keymap.set("n", "<C-p>", ":Files<CR>")
keymap.set("n", "<leader>b", ":Buffers<CR>")

-- Telescope
local telescope = require('telescope.builtin')
keymap.set('n', '<leader>ff', telescope.find_files, {})
keymap.set('n', '<leader>fg', telescope.live_grep, {})
keymap.set('n', '<leader>fb', telescope.buffers, {})
keymap.set('n', '<leader>fh', telescope.help_tags, {})
keymap.set('n', '<leader>fl', telescope.lsp_references, {})

-- NvimTree
keymap.set('n', '<leader>nt', ':NvimTreeFindFileToggle<CR>')

-- Mason
keymap.set('n', '<Leader>rn', vim.lsp.buf.rename)
keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, {})
keymap.set('n', 'gd', vim.lsp.buf.definition, {})
keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
-- keymap.set('n', 'K', vim.lsp.buf.hover, {})


