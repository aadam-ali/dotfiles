-- Easier Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Above Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

-- Easier Buffer Navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

-- Lazy
vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy" })

vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del("x", "gra")
