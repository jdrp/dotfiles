local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Load all plugin files from the plugins directory
  },
  defaults = { lazy = false }, -- Eagerly load plugins by default
  install = { colorscheme = { "tokyonight", "habamax" } }, -- Example colorschemes
  checker = { enabled = true }, -- Periodically check for updates
})

