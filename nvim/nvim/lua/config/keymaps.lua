-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


-- Keymaps for inserting a new line without entering insert mode
vim.api.nvim_set_keymap("n", "o", "o<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "O", "O<Esc>", { noremap = true, silent = true })

-- Yank to system clipboard with <leader>y
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })

-- Paste from system clipboard with <leader>p
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })

-- Remap Y to behave like yy (yank the entire line)
vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = true, silent = true })
