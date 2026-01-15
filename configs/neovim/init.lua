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
            "nvim-telescope/telescope.nvim", tag = "v0.2.0",        -- Telescope fuzzy finding
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


-----------------------------
--- Plugin Configurations ---
-----------------------------
-- Bufferline --
require("bufferline").setup{
    options = {
        hover = {
            enabled = false
        },
        indicator = {
            style = "underline"
        },
        numbers = "ordinal",
        separator_style = "thick",
        show_buffer_close_icons = false,
        show_close_icons = false,
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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    filters = {
        dotfiles = false,
    },
})


-----------------
--- LSP Setup ---
-----------------
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<TAB>"] = cmp.mapping.select_next_item(),
        ["<S-TAB>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

-- Lua Auto Completion --
vim.lsp.config('lua_ls', {
    capabilities = capabilities,
})
vim.lsp.enable('lua_ls')

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

-- Fuzzy finding with Telescope --
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })

-- Markdown --
vim.keymap.set("n", "<leader>rm", ":RenderMarkdown toggle<CR>", { desc = "Turn Markdown rendering on and off"})

-- Folds --
vim.keymap.set("n", "<leader>a", "za", { desc = "Toggle fold under Line"})
vim.keymap.set("n", "<leader>o", "zR", { desc = "Open all folds"})
vim.keymap.set("n", "<leader>c", "zM", { desc = "Close all folds"})

-- Sessions --
vim.keymap.set("n", "<leader>s", ":mksession! ~/.local/state/nvim/sessions/session.vim<CR>")
vim.keymap.set("n", "<leader>S", ":source ~/.local/state/nvim/sessions/session.vim<CR>")

-- Special Bindings --
vim.keymap.set("n", "<leader>W", [[/\s\+$<CR>]], { desc = "Show trailing whitespaces"}) -- Shows trailing whitespaces (happens a lot)
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "map esc in terminal mode"}) -- makes it easier to get to normal mode in the terminal (for example for yanking)
vim.keymap.set("n", "<leader>yy", [["+yy]])
vim.keymap.set("n", "<leader>t", function()
    vim.cmd("botright split | resize 10 | terminal")
    vim.cmd("startinsert")
end, { desc = "open terminal" })

