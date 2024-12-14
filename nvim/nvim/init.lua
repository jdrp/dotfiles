if vim.g.vscode then

  -- VSCode Neovim
  require("config.vscode_keymaps")

end
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.loaded_perl_provider = 0

require("config.keymaps")
