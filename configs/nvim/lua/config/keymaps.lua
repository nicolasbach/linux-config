-- General Settings
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "toggle neovim"})
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "save file without quitting"})
vim.keymap.set("n", "ö", ":", { desc = "map ö to command mode"})
vim.keymap.set("v", ">", ">gv", { desc = "reselect in visual mode for right indentation"})
vim.keymap.set("v", "<", "<gv", { desc = "reselect in visual mode for left indentation"})

-- Buffer related bindings --
vim.keymap.set("n", "<leader>db", ":bd<CR>", { desc = "delete current buffer"})
for i = 1, 9 do
    vim.keymap.set("n", string.format("<leader>%d", i), string.format("<cmd>BufferLineGoToBuffer%d<CR>", i), { desc = "Go to buffer " .. i })
end

-- Fuzzy finding with Telescope --
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })

-- Markdown --
vim.keymap.set("n", "<leader>rm", ":RenderMarkdown toggle<CR>", { desc = "Turn Markdown rendering on and off"})

-- Sessions --
vim.keymap.set("n", "<leader>ss", ":mksession! ~/.local/state/nvim/sessions/session.vim<CR>")
vim.keymap.set("n", "<leader>sl", ":source ~/.local/state/nvim/sessions/session.vim<CR>")

-- Special Bindings --
vim.keymap.set("n", "<leader>W", [[/\s\+$<CR>]], { desc = "Show trailing whitespaces"}) -- Shows trailing whitespaces (happens a lot)
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "map esc in terminal mode"}) -- makes it easier to get to normal mode in the terminal (for example for yanking)
vim.keymap.set("n", "<leader>yy", [["+yy]])
vim.keymap.set("n", "<leader>t", function()
    vim.cmd("botright split | resize 10 | terminal")
    vim.cmd("startinsert")
end, { desc = "open terminal" })
