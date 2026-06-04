
-- General
vim.keymap.set("n", "<leader>rv", ":source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "ö", ":")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Buffers
for i = 1, 9 do
    vim.keymap.set("n", string.format("<leader>%d", i), string.format("<cmd>BufferLineGoToBuffer%d<CR>", i))
end

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")

-- Sessions
vim.keymap.set("n", "<leader>ss", ":mksession! ~/.local/state/nvim/sessions/sessions.nvim<CR>")
vim.keymap.set("n", "<leader>sl", ":source ~/.local/state/nvim/sessions/sessions.nvim<CR>")

-- Special stuff
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>yy", [["+yy"]])
vim.keymap.set("n", "<leader>t", function()
    vim.cmd("botright split | resize 10 | terminal")
    vim.cmd("startinsert")
end)
