
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
