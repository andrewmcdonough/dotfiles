vim.cmd('colorscheme gruvbox')
local status, _ = pcall(vim.cmd, 'colorscheme gruvbox')
if not status then
  print('Error loading colorscheme')
  return
end
