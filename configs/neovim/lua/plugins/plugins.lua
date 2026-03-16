
-----------------------------
--- Plugin Configurations ---
-----------------------------
-- Bufferline --
require("bufferline").setup{
    options = {
        diagnostics = "nvim_lsp",
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

-- Lualine --
require('lualine').setup {
    options = { theme = 'codedark' },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filesize', 'fileformat', 'filetype'},
        lualine_y = {'lsp_status'},
        lualine_z = {'progress', 'location'}
    }
}

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
