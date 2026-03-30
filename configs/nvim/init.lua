-------------------------------------
-- ############################### --
-- ############################### --
----------- Neovim Config -----------
-- ############################### --
-- ############################### --
-------------------------------------

-- General
vim.g.mapleader = ","
require("config.options")

-- Plugins
require("plugins.lazysetup")
require("plugins.plugins")

-- LSP
require("config.lsp")

-- Keymaps
require("config.keymaps")

