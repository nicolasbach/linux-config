
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

---------------------
--- Setup Plugins ---
---------------------
require("lazy").setup({
    spec = {
        {
            "akinsho/bufferline.nvim",                              -- Bufferline for nice ui
            version = "*",
            dependencies = { "nvim-tree/nvim-web-devicons" }
        },
        {
            "windwp/nvim-autopairs",                                -- set matching brackts automatically
            event = "InsertEnter",
            config = true
        },
        {
            "kylechui/nvim-surround",                               -- change surrounding characters
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({})
            end
        },
        {
            "folke/tokyonight.nvim",                                -- Theme
            lazy = false,
            priority = 1000,
            opts = {}
        },
        {
            "lewis6991/gitsigns.nvim"                               -- Git stuff, primarily for blame
        },
        {
            "nvim-java/nvim-java",
            config = function()
                require('java').setup()
                vim.lsp.enable('jdtls')
            end,
        },
        {
            "nvim-lualine/lualine.nvim",                            -- like vim airline
            dependencies = { "nvim-tree/nvim-web-devicons"}
        },
        {
            "nvim-tree/nvim-tree.lua"                               -- File browser
        },
        {
            "nvim-tree/nvim-web-devicons",                          -- Icons and fonts
        },
        {
            "nvim-treesitter/nvim-treesitter",                      -- treesitter
            lazy = false,
            build = ":TSUpdate"
        },
        {
            "nvim-telescope/telescope.nvim",                        --  fuzzy finding
            tag = "v0.2.1",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        {
            "MeanderingProgrammer/render-markdown.nvim",            -- Markdown rendering
            dependencies =  { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
            ---@module "render-markdown"
            ---@type render.md.UserConfig
            opts = {}
        },
        {
            "neovim/nvim-lspconfig"                                 -- LSP
        },
        {
            "hrsh7th/cmp-nvim-lsp"
        },
        {
            "hrsh7th/cmp-buffer"
        },
        {
            "hrsh7th/cmp-path"
        },
        {
            "hrsh7th/cmp-cmdline"
        },
        {
            "hrsh7th/nvim-cmp"
        },
        {
            "L3MON4D3/LuaSnip"
        },
        {
            "saadparwaiz1/cmp_luasnip"
        }
    },
    install = { colorscheme = { "tokyonight" } },
})
