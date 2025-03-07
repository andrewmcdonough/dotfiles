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

-- Load all plugin specs from the plugins directory
require("lazy").setup("andrewmcdonough.plugins", {
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrwPlugin",   -- Netrw file browser
        "rplugin",       -- Remote plugin functionality
        "spellfile_plugin", -- For downloading spell files
        "2html_plugin",  -- Another HTML converter
        "man",           -- Built-in manpage viewer (if you use external tools for docs)
        "shada_plugin",  -- ShaDa (shared data) functionality
        "vimball",       -- Manages Vimball archives
        "getscript",     -- GetLatestVimScripts functionality
        "getscriptPlugin", -- Related to GetLatestVimScripts
        "logipat",       -- Logical pattern matcher
      },
    },
  },
})
