local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'nvim-lua/plenary.nvim',
  -- Fuzzy finder
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' },
  'nvim-tree/nvim-tree.lua',            --  File tree
  'nvim-tree/nvim-web-devicons',        --  File tree icons
  'tpope/vim-fugitive',
  'tpope/vim-sensible',                  --  A sensible set of vim defaults
  'kana/vim-textobj-user',               --  Create your own text objects
  'tmhedberg/matchit',                   --  Extended block matching
  'mileszs/ack.vim',                     --  For searching for files
  'airblade/vim-gitgutter',              --  Shows git diff in the gutter (left hand side)
  'tpope/vim-dispatch',                  --  Run commands in tmux
  'vim-scripts/tComment',                --  For easy line commenting
  'eiginn/netrw',                        --  File browsing
  'tpope/vim-surround',                  --  Manipulate surrounding parentheses, brackets, quotes, etc
  'tpope/vim-abolish',                   --  For case insensitive text substitution
  --'nelstrom/vim-textobj-rubyblock', --  For working with Ruby blocks
  'dense-analysis/ale',                  --  Syntax Checking
  'vim-airline/vim-airline',             --  A better status line
  'vim-airline/vim-airline-themes', --  A better status line
  'tpope/vim-vinegar',                   --  Better netrw
  'junegunn/fzf',                        --  Fuzzy finder,
  'junegunn/fzf.vim',                    --  Fuzzy finder
  'liuchengxu/vim-which-key',            --  Show available keybindings
  'mattn/emmet-vim',                     --  Templating
  'mpyatishev/vim-sqlformat',            --  Format SQL
  'hashivim/vim-terraform',              --  Terrform
  'pearofducks/ansible-vim',             --  Ansible syntax
  'github/copilot.vim',                  --  GitHub Copilot
  'williamboman/mason.nvim',             --  Mason for LSPs
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'chriskempson/tomorrow-theme', rtp = 'vim/',
  'altercation/vim-colors-solarized',
  'morhetz/gruvbox',                     --  Gruvbox
  'tpope/vim-cucumber',                  --  Cucumber
  'tpope/vim-rails',                     --  Rails
  'thoughtbot/vim-rspec',                --  Rspec
  'mxw/vim-jsx',                         --  JSX
  'posva/vim-vue',                       --  Vue
  'pangloss/vim-javascript',             --  Javascript

}, opts)

