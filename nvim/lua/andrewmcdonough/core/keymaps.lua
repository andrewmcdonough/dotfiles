vim.g.mapleader = " "

local keymap = vim.keymap

-- Neovim
keymap.set("n", "<leader>vrr", ":lua reload_config()<CR>", { noremap = true, silent = true })  -- Reload nvim config

-- Moving around buffers and tabs
keymap.set("n", "<C-n>", ":bprev<CR>")        -- Previous buffer
keymap.set("n", "<C-m>", ":bnext<CR>")        -- Next buffer
keymap.set("n", "{", ":tabprev<CR>")          -- Previous tab
keymap.set("n", "}", ":tabnext<CR>")          -- Next tab
keymap.set("n", "<leader>nt", ":tabnew<CR>")  -- New tab

-- ALE
keymap.set("n", "<leader>af", ":ALEFix<CR>")
keymap.set("n", "<leader>al", ":ALELint<CR>")


-- Ruby
keymap.set("n", "<leader>rtt", ':silent !tmux send-keys -t:3 \'bundle exec rspec %\' C-m<CR>', { noremap = true, silent = true })
keymap.set("n", '<leader>rtc', ':lua create_rspec_file()<CR>', { noremap = true, silent = true })

-- Pry
keymap.set("n", "<leader>pry", 'orequire "pry"; binding.pry<ESC>^')
keymap.set("n", "<leader>prr", 'orequire "pry"; binding.pry_remote<ESC>^')
keymap.set("n", "<leader>prd", 'oRails.logger.debug("[DEBUG] ")<ESC>hi')

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
keymap.set('n', '<leader>t', ':NvimTreeFindFileToggle<CR>')

-- Mason
keymap.set('n', '<Leader>rn', vim.lsp.buf.rename)
keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, {})
keymap.set('n', 'gd', vim.lsp.buf.definition, {})
keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
-- keymap.set('n', 'K', vim.lsp.buf.hover, {})

-- Git
keymap.set('n', '<leader>gb', ":Git blame<CR>")
keymap.set('n', '<leader>gt', ":Gitsigns toggle_current_line_blame<CR>")

-- barbar
local map = vim.api.nvim_set_keymap
local opts = { noremap = true  }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)
-- Close buffer
map('n', '<leader>q', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
--map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
