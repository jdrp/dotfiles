return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = { "smart" }, -- Use relative paths
          file_ignore_patterns = { "**/mnt/shared/Documents/OneDrive/**" }, -- Example to ignore OneDrive files
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
}

