---------------------
-- General options --
---------------------
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true

-- Indentation
vim.opt.autoindent = true
vim.opt.shiftwidth = 4

-- Tab handling
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Undofile
vim.opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'
vim.opt.undofile = true

-- List characters
vim.opt.list = true
vim.opt.listchars = { trail = "*", tab = ">> " }

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 1
vim.opt.foldenable = false

-- Misc
vim.opt.scrolloff = 100
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.signcolumn = 'yes:1'

-- Swapfile
vim.opt.swapfile = false

-- file name tab completion
vim.opt.wildmenu = true
vim.opt.wildignorecase = true

-- Colorscheme --
vim.cmd[[colorscheme sorbet]]

