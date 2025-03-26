vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Neovim
map("n", "<leader>vrr", ":lua reload_config()<CR>", opts)  -- Reload nvim config

-- Moving around buffers and tabs
map("n", "<C-n>", ":bprev<CR>", opts)        -- Previous buffer
map("n", "<C-m>", ":bnext<CR>", opts)        -- Next buffer
map("n", "{", ":tabprev<CR>", opts)          -- Previous tab
map("n", "}", ":tabnext<CR>", opts)          -- Next tab
map("n", "<leader>nt", ":tabnew<CR>", opts)  -- New tab

-- Ruby
map("n", "<leader>rtt", ':silent !tmux send-keys -t:3 \'bundle exec rspec %\' C-m<CR>', opts)
map("n", "<leader>rtc", ":lua create_rspec_file()<CR>", opts)

-- Pry
map("n", "<leader>pry", 'orequire "pry"; binding.pry<ESC>^', opts)
map("n", "<leader>prr", 'orequire "pry"; binding.pry_remote<ESC>^', opts)
map("n", "<leader>prd", 'oRails.logger.debug("[DEBUG] ")<ESC>hi', opts)

-- Telescope
map("n", "<C-p>", ":Files<CR>", opts)
map("n", "<leader>b", ":Buffers<CR>", opts)

-- Mason
map("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)

-- Git
map("n", "<leader>gb", ":Git blame<CR>", opts)
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", opts)
map("n", "<leader>gho",":GBrowse<CR>", opts)

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
-- Close buffer
map("n", "<leader>q", "<Cmd>BufferClose<CR>", opts)
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
