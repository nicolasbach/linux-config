
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.vim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true                 -- show line numbers
vim.opt.relativenumber = true         -- show relative line numbers
vim.opt.showmatch = true              -- show matching brackets
vim.opt.autoindent = true             -- automatic indentation
vim.opt.tabstop = 4
vim.opt.expandtab = true              -- convert tabs to spaces
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 999               -- keep cursor in the middle
vim.opt.encoding = "utf-8"            -- set encoding to utf-8
vim.opt.termguicolors = true          -- set to false to get opacity
vim.opt.mouse = "a"

require("lazy").setup({
    spec = {
        {
            "windwp/nvim-autopairs", -- Autopairs
            event = "InsertEnter",
            config = true
        },
        {
            "folke/tokyonight.nvim", -- Theme from lazy
            lazy = true,
            opts = { style = "moon" }
        },
        {
            "nvim-lualine/lualine.nvim", -- lualine, nicer line at the bottom
            dependencies = { "nvim-tree/nvim-web-devicons"}
        },
        "nvim-tree/nvim-tree.lua", -- file browser
        "nvim-tree/nvim-web-devicons", -- icons via nerd font for file browser
        {
            "nvim-treesitter/nvim-treesitter",
            lazy = false,
            build = ":TSUpdate"
        },
        {
            "saghen/blink.cmp",
            build = "cargo +nightly build --release",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts = {
                keymap = { 
                    preset = "default",
                    ["<Tab>"] = { "select_next", "fallback"},
                    ["<S-Tab>"] = {"select_prev", "fallback"},
                    ["<CR>"] = { "select_and_accept", "fallback" },
                },
                completion = { documentation = { auto_show = false } },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },
        "neovim/nvim-lspconfig",
    },
    install = { colorscheme = { "tokyonight" } },
})
-----------------------
--- NVIM Tree Setup ---
-----------------------
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    filters = {
        dotfiles = true,
    },
})
-- Todos:
-- open file in new tabs/buffers

---------------------
--- Lualine Setup ---
---------------------
require('lualine').get_config()
require('lualine').setup {
	options = { theme = 'horizon' },
}
-- show total lines

-----------------
--- LSP Setup ---
-----------------
local capabilities = require('blink.cmp').get_lsp_capabilities()


-- Rust Autocompletion
vim.lsp.config('rust_analyzer', {
    capabilities = capabilities
})
vim.lsp.enable('rust_analyzer')

-- Python Auto Completion
vim.lsp.config('pyright', {
    capabilities = capabilities
})
vim.lsp.enable('pyright')


vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = { border = "rounded" },
})

--------------------------
--- Custom Keybindings ---
--------------------------
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', {noremap= true})
vim.api.nvim_set_keymap('n', '<F3>', ':bo term<CR>', {noremap= true})
vim.api.nvim_set_keymap('n', '<F4>', ':w<CR>', {noremap= true})
vim.api.nvim_set_keymap('n', '<F5>', ':pc<CR>', {noremap= true})
