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
vim.g.mapleader = "ö"
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
vim.opt.hidden = true
-- Folding --
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 1
vim.opt.foldenable = false

---------------------
--- Setup Plugins ---
---------------------
-- Plugin List:
-- akinsho/bufferline.nvim
-- folke/tokyonight.nvim                # colorscheme
-- kylechui/nvim-surround               # surround motions
-- lewis6991/gitsigns.nvim              # Git plugin
-- neovim/nvim-lspconfig                # lspconfig for autocompletion
-- nvimdev/dashboard-nvim               # Dashboard like vim-startify
-- nvim-lualine/lualine.nvim            # lualine as an equivalent for airline
-- nvim-tree/nvim-tree.lua              # filebrowser
-- nvim-tree/nvim-web-devicons          # nerdfonts and icons for nvim-tree
-- nvim-treesitter/nvim-treesitter      # Treesitter
-- nvim-telescope/telescope.nvim        # fuzzy finding
-- MeanderingProgrammer/render-markdown.nvim
-- saghen/blink.cmp                     # lsp client
-- windwp/nvim-autopairs                # auto pairs
require("lazy").setup({
    spec = {
        {
            "akinsho/bufferline.nvim",
            version = "*",
            dependencies = { "nvim-tree/nvim-web-devicons" }
        },
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
            "lewis6991/gitsigns.nvim"
        },
        {
            "nvimdev/dashboard-nvim",
            event = "VimEnter",
            config = function()
                require("dashboard").setup {
                    theme = "hyper",
                    config = {
                        packages = { enable = true },
                    }
                }
            end,
            dependencies = { "nvim-tree/nvim-web-devicons" }
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons"}
        },
        {
            "nvim-tree/nvim-tree.lua"
        },
        {
            "nvim-tree/nvim-web-devicons",
        },
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
            "MeanderingProgrammer/render-markdown.nvim",
            dependencies =  { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
            ---@module "render-markdown"
            ---@type render.md.UserConfig
            opts = {}
        },
        {
            "saghen/blink.cmp",
            build = "cargo +nightly build --release",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts = {
                keymap = {
                    preset = "default",
                    ["<Tab>"] = { "select_next", "fallback"}, -- use tab to select items
                    ["<S-Tab>"] = {"select_prev", "fallback"}, -- go backwards at the selection via Shift Tab
                    ["<CR>"] = { "select_and_accept", "fallback" }, -- select item with Enter
                },
                completion = { documentation = { auto_show = false } },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },
        {
            "neovim/nvim-lspconfig"
        },
    },
    install = { colorscheme = { "tokyonight" } },
})


-----------------------------
--- Plugin Configurations ---
-----------------------------
-- Bufferline --
require("bufferline").setup{
    options = {
        indicator = {
            style = "underline"
        },
        separator_style = "thick",
        show_buffer_close_icons = false,
        show_close_icons = false,
        hover = {
            enabled = false
        }
    }
}

-- Colorscheme --
vim.cmd[[colorscheme tokyonight]]


--- Git ---
require("gitsigns").setup {
    signcolumn = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text_pos = "eol",
    }
}

-- Lualine --
require('lualine').get_config()
require('lualine').setup {
    options = { theme = 'tokyonight' },
}

-- Markdown --
require("render-markdown").setup({
    enabled = false,
    completions = {
        lsp = { enabled = true }
    },
})

-- NVIM Tree --
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


-----------------
--- LSP Setup ---
-----------------
-- capabilities for lsp (defaults in this case) --
local capabilities = require('blink.cmp').get_lsp_capabilities()
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Rust Autocompletion --
vim.lsp.config('rust_analyzer', {
    capabilities = capabilities
})
vim.lsp.enable('rust_analyzer')

-- Python Auto Completion --
vim.lsp.config('pyright', {
    capabilities = capabilities
})
vim.lsp.enable('pyright')

-- Html Auto Completion --
vim.lsp.config('html', {
    capabilities = capabilities,
})
vim.lsp.enable('html')
-- Necessary for error messages --
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = { border = "rounded" },
})

-------------------
--- Keybindings ---
-------------------
-- General bindings --
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "toggle neovim"})
vim.keymap.set("n", "<leader>t", ":bo term<CR>i", { desc = "open terminal in new Buffer"}) -- opens terminal at the bottom
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "save file without quitting"})
vim.keymap.set("n", "<leader>p", ":pc<CR>", { desc = "get help out of the way"}) -- maybe YCM specific and not necessary anymore
vim.keymap.set("n", "<leader>n", ":noh<CR>", { desc = "execute noh to remove highlighting"})
vim.keymap.set("v", ">", ">gv", { desc = "reselect in visual mode for right indentation"}) -- reselect previous selection in visual mode for indentation
vim.keymap.set("v", "<", "<gv", { desc = "reselect in visual mode for left indentation"}) -- reselect previous selection in visual mode for indentation

-- Buffer related bindings --
vim.keymap.set("n", "<leader>b", ":bn<CR>", { desc = "next buffer"})
vim.keymap.set("n", "<leader>B", ":bp<CR>", { desc = "previous buffer"})
vim.keymap.set("n", "<leader>db", ":bd<CR>", { desc = "delete current buffer"})
vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1"})
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2"})
vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3"})
vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4"})
vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5"})
vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6"})
vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7"})
vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8"})
vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9"})

-- Git bindings --
vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Show git blame for current line"})
vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Show current dif"})
vim.keymap.set("n", "<leader>gts", ":Gitsigns toggle_signs<CR>", { desc = "toggle signs on the side"})

-- Fuzzy finding with Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })

-- Markdown
vim.keymap.set("n", "<leader>rm", ":RenderMarkdown toggle<CR>", { desc = "Turn Markdown rendering on and off"})

-- Folds
vim.keymap.set("n", "<leader>a", "za")
vim.keymap.set("n", "<leader>o", "zR")
vim.keymap.set("n", "<leader>c", "zM")

-- Special Bindings --
vim.keymap.set("n", "<leader>W", [[/\s\+$<CR>]], { desc = "Show trailing whitespaces"}) -- Shows trailing whitespaces (happens a lot)
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "map esc in terminal mode"}) -- makes it easier to get to normal mode in the terminal (for example for yanking)
vim.keymap.set("n", "<leader>yy", [["+yy]], { desc = "Copy line to system clipboard" })

