function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end


-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

-- Keymaps for inserting a new line without entering insert mode
vim.api.nvim_set_keymap("n", "o", "o<Esc>", { noremap = true, silent = true, desc = "New line below" })
vim.api.nvim_set_keymap("n", "O", "O<Esc>", { noremap = true, silent = true, desc = "New line above" })

-- Yank to system clipboard with <leader>y
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Copy to clipboard" })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Copy selection to clipboard" })

-- Yank entire file to clipboard with <leader>Y
vim.api.nvim_set_keymap('n', '<leader>Y', ':%y+<CR>', { noremap = true, silent = true, desc = "Copy entire file to clipboard" })

-- Paste from system clipboard with <leader>p
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true, desc = "Paste above" })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste below" })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true, silent = true, desc = "Paste above selection" })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste below selection" })

-- Remap Y to behave like yy (yank the entire line)
vim.api.nvim_set_keymap('n', 'Y', 'yy', { noremap = true, silent = true, desc = "Copy line" })

-- Delete mappings
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true, desc = "Delete" })
vim.api.nvim_set_keymap('n', 'D', '"_D', { noremap = true, silent = true, desc = "Delete line" })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true, desc = "Delete selection" })
vim.api.nvim_set_keymap('n', '<leader>d', 'd', { noremap = true, silent = true, desc = "Cut" })
vim.api.nvim_set_keymap('n', '<leader>D', 'D', { noremap = true, silent = true, desc = "Cut line" })
vim.api.nvim_set_keymap('v', '<leader>d', 'd', { noremap = true, silent = true, desc = "Cut selection" })

-- Cut single character
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true, desc = "Delete character" })
vim.api.nvim_set_keymap('n', '<leader>x', 'x', { noremap = true, silent = true, desc = "Cut character" })

-- Change mappings
vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true, desc = "Change" })
vim.api.nvim_set_keymap('n', 'C', '"_C', { noremap = true, silent = true, desc = "Change line" })
vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true, silent = true, desc = "Change selection" })
vim.api.nvim_set_keymap('n', '<leader>c', 'c', { noremap = true, silent = true, desc = "Cut and insert" })
vim.api.nvim_set_keymap('n', '<leader>C', 'C', { noremap = true, silent = true, desc = "Cut line and insert" })
vim.api.nvim_set_keymap('v', '<leader>c', 'c', { noremap = true, silent = true, desc = "Cut selection and insert" })

-- Telescope core functions
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = "Find files" })
vim.api.nvim_set_keymap('n', '<leader><leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Search text" })
vim.api.nvim_set_keymap('n', '<leader><leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = "List buffers" })
vim.api.nvim_set_keymap('n', '<leader><leader>h', ':Telescope help_tags<CR>', { noremap = true, silent = true, desc = "Help tags" })
vim.api.nvim_set_keymap('n', '<leader><leader>o', ':Telescope oldfiles<CR>', { noremap = true, silent = true, desc = "Recent files" })
vim.api.nvim_set_keymap('n', '<leader><leader>s', ':Telescope grep_string<CR>', { noremap = true, silent = true, desc = "Search word under cursor" })
vim.api.nvim_set_keymap('n', '<leader><leader>c', ':Telescope commands<CR>', { noremap = true, silent = true, desc = "Find commands" })
vim.api.nvim_set_keymap('n', '<leader><leader>k', ':Telescope keymaps<CR>', { noremap = true, silent = true, desc = "Show keymaps" })
vim.api.nvim_set_keymap('n', '<leader><leader>m', ':Telescope marks<CR>', { noremap = true, silent = true, desc = "List marks" })

-- Additional functionality
vim.api.nvim_set_keymap('n', '<leader>/', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true, desc = "Fuzzy find in buffer" })
vim.api.nvim_set_keymap('n', '<leader>r', ':Telescope lsp_references<CR>', { noremap = true, silent = true, desc = "Find references" })

-- Substitute in line
vim.api.nvim_set_keymap('v', '<leader>s', '"zy:s/<C-r>z//g<Left><Left>', { noremap = true, silent = true, desc = "Replace selection globally" })
vim.api.nvim_set_keymap('n', '<leader>s', '"zyiw:s/<C-r>z//g<Left><Left>', { noremap = true, silent = true, desc = "Replace word globally" })
