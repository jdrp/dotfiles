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
Map("n", "o", "o<Esc>", { desc = "New line below" })
Map("n", "O", "O<Esc>", { desc = "New line above" })

-- Yank to system clipboard with <leader>y
Map('n', '<leader>y', '"+y', { desc = "Copy to clipboard" })
Map('v', '<leader>y', '"+y', { desc = "Copy selection to clipboard" })

-- Yank entire file to clipboard with <leader>Y
Map('n', '<leader>Y', ':%y+<CR>', { desc = "Copy entire file to clipboard" })

-- Paste from system clipboard with <leader>p
Map('n', '<leader>P', '"+P', { desc = "Paste above" })
Map('n', '<leader>p', '"+p', { desc = "Paste below" })
Map('v', '<leader>P', '"+P', { desc = "Paste above selection" })
Map('v', '<leader>p', '"+p', { desc = "Paste below selection" })

-- Remap Y to behave like yy (yank the entire line)
Map('n', 'Y', 'yy', { desc = "Copy line" })

-- Delete mappings
Map('n', 'd', '"_d', { desc = "Delete" })
Map('n', 'D', '"_D', { desc = "Delete line" })
Map('v', 'd', '"_d', { desc = "Delete selection" })
Map('n', '<leader>d', 'd', { desc = "Cut" })
Map('n', '<leader>D', 'D', { desc = "Cut line" })
Map('v', '<leader>d', 'd', { desc = "Cut selection" })

-- Cut single character
Map('n', 'x', '"_x', { desc = "Delete character" })
Map('n', '<leader>x', 'x', { desc = "Cut character" })

-- Change mappings
Map('n', 'c', '"_c', { desc = "Change" })
Map('n', 'C', '"_C', { desc = "Change line" })
Map('v', 'c', '"_c', { desc = "Change selection" })
Map('n', '<leader>c', 'c', { desc = "Cut and insert" })
Map('n', '<leader>C', 'C', { desc = "Cut line and insert" })
Map('v', '<leader>c', 'c', { desc = "Cut selection and insert" })

-- Telescope core functions
Map('n', '<leader>f', ':Telescope find_files<CR>', { desc = "Find files" })
Map('n', '<leader><leader>g', ':Telescope live_grep<CR>', { desc = "Search text" })
Map('n', '<leader><leader>b', ':Telescope buffers<CR>', { desc = "List buffers" })
Map('n', '<leader><leader>h', ':Telescope help_tags<CR>', { desc = "Help tags" })
Map('n', '<leader><leader>o', ':Telescope oldfiles<CR>', { desc = "Recent files" })
Map('n', '<leader><leader>s', ':Telescope grep_string<CR>', { desc = "Search word under cursor" })
Map('n', '<leader><leader>c', ':Telescope commands<CR>', { desc = "Find commands" })
Map('n', '<leader><leader>k', ':Telescope keymaps<CR>', { desc = "Show keymaps" })
Map('n', '<leader><leader>m', ':Telescope marks<CR>', { desc = "List marks" })

-- Additional functionality
Map('n', '<leader>/', ':Telescope current_buffer_fuzzy_find<CR>', { desc = "Fuzzy find in buffer" })
Map('n', '<leader>r', ':Telescope lsp_references<CR>', { desc = "Find references" })

-- Substitute in line
Map('v', '<leader>s', '"zy:keepjumps %s/<C-r>z//g<Left><Left>', { desc = "Replace selection globally" })
Map('n', '<leader>s', '"zyiw:keepjumps %s/<C-r>z//g<Left><Left>', { desc = "Replace word globally" })

-- Window navigation
Map('n', '<C-h>', '<C-w>h', { desc = "Change window (left)" })
Map('n', '<C-j>', '<C-w>j', { desc = "Change window (down)" })
Map('n', '<C-k>', '<C-w>k', { desc = "Change window (up)" })
Map('n', '<C-l>', '<C-w>l', { desc = "Change window (right)" })

-- Window creation
Map('n', '<C-s>', '<C-w>s', { desc = "Split window (horizontal)" })
Map('n', '<C-v>', '<C-w>v', { desc = "Split window (vertical)" })
