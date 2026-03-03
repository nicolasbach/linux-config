-- General Settings
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

-- Java --
vim.keymap.set("n", "<leader>jr", ":JavaRunnerRunMain<CR>", { desc = "Run main method"})
vim.keymap.set("n", "<leader>js", ":JavaRunnerStopMain<CR>", { desc = "Run main method"})

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
