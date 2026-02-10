-------------------------------------
-- ############################### --
-- ############################### --
----------- Neovim Config -----------
-- ############################### --
-- ############################### --
-------------------------------------

-- General
vim.g.mapleader = "ö"
vim.g.maplocalleader = "\\"
require("config.options")

-- Plugins
require("plugins.lazysetup")
require("plugins.plugins")

-- LSP
require("config.lsp")

-- Keymaps
require("config.keymaps")

