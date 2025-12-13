-- Line numbers and relative numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Searches are case insensitive until an uppercase char is used in the search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs are 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- no text wrapping
vim.opt.wrap = false

-- Lets undotree take over instead of vim's
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Doesn't highlight all search results, adds incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- nicer colours
vim.opt.termguicolors = true

-- Always keeps 8 lines between your cursor and the edge of the screen
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- speeeeeed
vim.opt.updatetime = 50

-- 80 character column (most code rules need this)
vim.opt.colorcolumn = "80"

-- sets the leader for remaps
vim.g.mapleader = " "
