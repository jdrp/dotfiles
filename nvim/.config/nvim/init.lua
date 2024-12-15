vim.g.mapleader = " "
require("config.lazy")

if vim.g.vscode then

  -- VSCode Neovim
  require("config.vscode_keymaps")

end
-- bootstrap lazy.nvim, LazyVim and your plugins

vim.g.loaded_perl_provider = 0

require("config.keymaps")


