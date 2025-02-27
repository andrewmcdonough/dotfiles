return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('gitsigns').setup()
  end,
  keys = {
    { '<leader>gb', ":Git blame<CR>", desc = "Git blame" },
    { '<leader>gt', ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git blame" },
  }
}