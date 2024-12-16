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
