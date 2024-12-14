local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Import/override with your plugins
    { import = "plugins" },
    -- Telescope setup
    {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('telescope').setup({
          defaults = {
            path_display = { "smart" }, -- Ensure relative paths where possible
            file_ignore_patterns = { "**/mnt/shared/Documents/OneDrive/**" }, -- Adjust if needed
          },
          pickers = {
            find_files = {
              hidden = true, -- Show hidden files
              no_ignore = false, -- Respect .gitignore
            },
          },
        })
      end,
    },
    {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({
          -- Add your configurations here
          plugins = {
            spelling = {
              enabled = true, -- Enable spelling suggestions
              suggestions = 20, -- Number of suggestions
            },
          },
          -- Customize popup appearance and keybinding behavior
          window = {
            border = "rounded", -- Use rounded borders
            position = "bottom", -- Position at the bottom
          },
        })
      end,
    },

  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot of the plugins that support versioning
    -- have outdated releases, which may break your Neovim install.
    version = false, -- Always use the latest git commit
    -- version = "*", -- Try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- Check for plugin updates periodically
    notify = false, -- Notify on update
  }, -- Automatically check for plugin updates
  performance = {
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Automatically set the working directory to the project root
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local project_root = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')
    if project_root ~= '' then
      vim.cmd('cd ' .. vim.fn.fnamemodify(project_root, ':h'))
    end
  end,
})

-- Normalize paths before opening files to avoid duplicate buffers
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local abs_path = vim.fn.expand('%:p') -- Absolute path of the current file
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= vim.api.nvim_get_current_buf() then
        local buf_path = vim.fn.expand(vim.api.nvim_buf_get_name(buf))
        if abs_path == buf_path then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end
  end,
})
