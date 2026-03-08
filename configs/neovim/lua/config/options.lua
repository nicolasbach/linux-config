-- General options
vim.opt.number = true                         -- show line numbers
vim.opt.relativenumber = true                 -- show relative line numbers
vim.opt.showmatch = true                      -- show matching brackets
vim.opt.autoindent = true                     -- automatic indentation
vim.opt.tabstop = 4
vim.opt.expandtab = true                      -- convert tabs to spaces
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 100                       -- keep cursor in the middle
vim.opt.encoding = "utf-8"                    -- set encoding to utf-8
vim.opt.termguicolors = true                  -- set to false to get opacity
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.signcolumn = 'yes:1'
vim.opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'
vim.opt.undofile = true                                             -- use undofile

-- Folding --
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 1
vim.opt.foldenable = false

-- Colorscheme --
vim.cmd[[colorscheme sorbet]]

