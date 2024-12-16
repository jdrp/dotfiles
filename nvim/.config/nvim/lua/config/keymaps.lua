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

-- Telescope core functions
local telescope = require('telescope.builtin')

-- <leader><leader> mappings for core search options
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- File search
vim.api.nvim_set_keymap('n', '<leader><leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true }) -- Live grep
vim.api.nvim_set_keymap('n', '<leader><leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true }) -- Buffers
vim.api.nvim_set_keymap('n', '<leader><leader>h', ':Telescope help_tags<CR>', { noremap = true, silent = true }) -- Help tags
vim.api.nvim_set_keymap('n', '<leader><leader>o', ':Telescope oldfiles<CR>', { noremap = true, silent = true }) -- Old files
vim.api.nvim_set_keymap('n', '<leader><leader>s', ':Telescope grep_string<CR>', { noremap = true, silent = true }) -- String under cursor
vim.api.nvim_set_keymap('n', '<leader><leader>c', ':Telescope commands<CR>', { noremap = true, silent = true }) -- Commands
vim.api.nvim_set_keymap('n', '<leader><leader>k', ':Telescope keymaps<CR>', { noremap = true, silent = true }) -- Keymaps
vim.api.nvim_set_keymap('n', '<leader><leader>m', ':Telescope marks<CR>', { noremap = true, silent = true }) -- Marks

-- Additional functionality
vim.api.nvim_set_keymap('n', '<leader>/', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true }) -- Current buffer fuzzy find
vim.api.nvim_set_keymap('n', '<leader>r', ':Telescope lsp_references<CR>', { noremap = true, silent = true }) -- LSP references

-- Git-specific mappings
vim.api.nvim_set_keymap('n', '<leader>gb', ':Telescope git_branches<CR>', { noremap = true, silent = true }) -- Git branches
vim.api.nvim_set_keymap('n', '<leader>gs', ':Telescope git_status<CR>', { noremap = true, silent = true }) -- Git status
