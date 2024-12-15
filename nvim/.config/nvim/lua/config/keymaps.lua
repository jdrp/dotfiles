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
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })

-- Remap Y to behave like yy (yank the entire line)
vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = true, silent = true })

-- Only yank with leader prefix
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D', '"_D', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', 'd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>D', 'D', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>d', 'd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', 'x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'C', '"_C', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', 'c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>C', 'C', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', 'c', { noremap = true, silent = true })
