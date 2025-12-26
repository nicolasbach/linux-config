-------------------------------------
-- ############################### --
-- ############################### --
----------- Neovim Config -----------
-- ############################### --
-- ############################### --
-------------------------------------

---------------------------
--- Bootstrap lazy.nvim ---
---------------------------
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

-----------------------
--- Set vim options ---
-----------------------
--- maybe some are unnecessary
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

---------------------
--- Setup Plugins ---
---------------------
-- Plugin List:
-- folke/tokyonight.nvim                # colorscheme
-- kylechui/nvim-surround               # surround motions
-- neovim/nvim-lspconfig                # lspconfig for autocompletion
-- nvim-lualine/lualine.nvim            # lualine as an equivalent for airline
-- nvim-tree/nvim-tree.lua              # filebrowser
-- nvim-tree/nvim-web-devicons          # nerdfonts and icons for nvim-tree
-- nvim-treesitter/nvim-treesitter      # Treesitter
-- nvim-telescope/telescope.nvim        # fuzzy finding
-- saghen/blink.cmp                     # lsp client
-- windwp/nvim-autopairs                # auto pairs
require("lazy").setup({
    spec = {
        {
            "windwp/nvim-autopairs", 
            event = "InsertEnter",
            config = true
        },
        {
            "kylechui/nvim-surround",
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({})
            end
        },
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {}
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons"}
        },
        "nvim-tree/nvim-tree.lua", 
        "nvim-tree/nvim-web-devicons", 
        {
            "nvim-treesitter/nvim-treesitter",
            lazy = false,
            build = ":TSUpdate"
        },
        {
            "nvim-telescope/telescope.nvim", tag = "v0.2.0",
            dependencies = { "nvim-lua/plenary.nvim" }
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

---------------------
--- Lualine Setup ---
---------------------
require('lualine').get_config()
require('lualine').setup {
options = { theme = 'tokyonight' },
}

-----------------
--- LSP Setup ---
-----------------
-- Setup capabilities for lsp (defaults in this case)
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

-- Necessary for error messages
vim.diagnostic.config({
virtual_text = true,
signs = true,
update_in_insert = false,
underline = true,
severity_sort = true,
float = { border = "rounded" },
})

-----------------
--- Telescope ---
-----------------
-- Fuzzy finding setup
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

---------------------
--- Customization ---
---------------------
vim.cmd[[colorscheme tokyonight]]
vim.api.nvim_set_keymap("n", "<leader>k", ":NvimTreeToggle<CR>", { desc = "toggle neovim"})
vim.api.nvim_set_keymap("n", "<leader>t", ":bo term<CR>i", { desc = "open terminal in new Buffer"})
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { desc = "save file without quitting"})
vim.api.nvim_set_keymap("n", "<leader>p", ":pc<CR>", { desc = "get help out of the way"}) -- maybe YCM specific and not necessary anymore
vim.api.nvim_set_keymap("n", "<leader>n", ":noh<CR>", { desc = "execute noh to remove highlighting"})
vim.api.nvim_set_keymap("n", "<leader>W", [[/\s\+$<CR>]], { desc = "Show trailing whitespaces"})
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "map esc in terminal mode"})

