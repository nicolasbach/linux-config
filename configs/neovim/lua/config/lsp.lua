
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

-- Python Auto Completion --
vim.lsp.config('pyright', {
    capabilities = capabilities
})

-- Html Auto Completion --
vim.lsp.config('htmlls', {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = {'html'},
})

-- Json --
vim.lsp.config('jsonls', {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = {'json'},
})

-- Yaml --
vim.lsp.config('yamlls', {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = {'yml', 'yaml'},
})

-- Bash Autocompletion --
vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' }
})

-- Lua Auto Completion --
vim.lsp.config('lua_ls', {
    capabilities = capabilities,
})

vim.lsp.enable('bashls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('pyright')
vim.lsp.enable('htmlls')
vim.lsp.enable('jsonls')
vim.lsp.enable('yamlls')
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

