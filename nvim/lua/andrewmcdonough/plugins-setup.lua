local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'nvim-lua/plenary.nvim',
  -- Fuzzy finder
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'folke/which-key.nvim',                -- Show available keybindings
  'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' },
  'lewis6991/gitsigns.nvim',             --  Git signs
  'nvim-tree/nvim-tree.lua',             --  File tree
  'nvim-tree/nvim-web-devicons',         --  File tree icons
  'nvim-lualine/lualine.nvim',           --  Status line
  'tpope/vim-fugitive',                  --  Git commands
  'tpope/vim-sensible',                  --  A sensible set of vim defaults
  'kana/vim-textobj-user',               --  Create your own text objects
  'tmhedberg/matchit',                   --  Extended block matching
  'mileszs/ack.vim',                     --  For searching for files
  'vim-scripts/tComment',                --  For easy line commenting
  'tpope/vim-surround',                  --  Manipulate surrounding parentheses, brackets, quotes, etc
  'tpope/vim-abolish',                   --  For case insensitive text substitution
  'dense-analysis/ale',                  --  Syntax Checking
  'junegunn/fzf',                        --  Fuzzy finder
  'junegunn/fzf.vim',                    --  Fuzzy finder
  'mattn/emmet-vim',                     --  Templating
  'mpyatishev/vim-sqlformat',            --  Format SQL
  'hashivim/vim-terraform',              --  Terrform
  'pearofducks/ansible-vim',             --  Ansible syntax
  'github/copilot.vim',                  --  GitHub Copilot
  'williamboman/mason.nvim',             --  Mason
  'williamboman/mason-lspconfig.nvim',   --  Mason LSP config
  'neovim/nvim-lspconfig',               --  LSP
  'tpope/vim-rails',                     --  Rails
  'thoughtbot/vim-rspec',                --  Rspec
  'posva/vim-vue',                       --  Vue
  'pangloss/vim-javascript',             --  Javascript
  'chriskempson/base16-vim',             --  Base16 colorscheme
  'morhetz/gruvbox',                     --  Gruvbox
}, opts)
