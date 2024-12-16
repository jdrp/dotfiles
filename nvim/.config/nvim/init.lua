vim.g.mapleader = " "
require("config.lazy")

if vim.g.vscode then

  -- VSCode Neovim
  require("config.vscode_keymaps")

end
-- bootstrap lazy.nvim, LazyVim and your plugins

vim.g.loaded_perl_provider = 0

require("config.keymaps")


vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. arg)
    end
  end
})


vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*",
    command = "lua os.execute('killall lazygit')"
})


-- Set tab to 4 spaces globally
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for autoindent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.softtabstop = 4    -- Number of spaces inserted/deleted when pressing <Tab>/<BS>

-- Ensure consistency across file types
vim.cmd('filetype plugin indent on')

-- Optionally, display tabs as 4 spaces visually
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·' }
