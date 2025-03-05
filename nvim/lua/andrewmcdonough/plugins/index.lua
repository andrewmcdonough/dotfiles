return {
  -- Core plugins
  { import = "andrewmcdonough.plugins.ale" },
  { import = "andrewmcdonough.plugins.telescope" },
  { import = "andrewmcdonough.plugins.lualine" },
  { import = "andrewmcdonough.plugins.which-key" },
  { import = "andrewmcdonough.plugins.gitsigns" },
  { import = "andrewmcdonough.plugins.mason" },

  -- Additional plugins that don't need their own file
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'tpope/vim-fugitive' },
  { 'kana/vim-textobj-user' },
  { 'mileszs/ack.vim' },
  { 'vim-scripts/tComment' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-abolish' },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  { 'mattn/emmet-vim' },
  { 'mpyatishev/vim-sqlformat' },
  { 'hashivim/vim-terraform' },
  { 'pearofducks/ansible-vim' },
  { 'github/copilot.vim' },
  { 'tpope/vim-rails' },
  { 'thoughtbot/vim-rspec' },
  { 'posva/vim-vue' },
  { 'pangloss/vim-javascript' },

  -- Colorschemes
  { 'chriskempson/base16-vim' },
  { 'morhetz/gruvbox' },
}

