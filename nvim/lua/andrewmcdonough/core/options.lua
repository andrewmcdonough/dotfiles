local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = false

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- splits
opt.splitbelow = true
opt.splitright = true

-- other options
opt.wrap = true
opt.encoding = "utf-8"
opt.visualbell = true
opt.showmatch = true
opt.colorcolumn = "120"
opt.list = true
opt.iskeyword:append("-")
opt.swapfile = false
