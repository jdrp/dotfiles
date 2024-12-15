return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup Mason
      require("mason").setup()

      -- Automatically install LSP servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",         -- Python
          "ts_ls",        -- JavaScript/TypeScript
          "clangd",          -- C/C++
          "jdtls",           -- Java
          "html",            -- HTML
          "cssls",           -- CSS
          "r_language_server", -- R
          "texlab",          -- LaTeX (MATLAB-like syntax)
          "emmet_ls",        -- HTML/TSX snippets
        },
        automatic_installation = true,
      })

      -- Setup individual LSP configurations
      local lspconfig = require("lspconfig")
      local servers = {
        pyright = {},
        ts_ls = {},
        clangd = {},
        jdtls = {},
        html = {},
        cssls = {},
        r_language_server = {},
        texlab = {},
        emmet_ls = { filetypes = { "html", "css", "javascriptreact", "typescriptreact" } },
      }
      for server, config in pairs(servers) do
        lspconfig[server].setup(config)
      end
    end,
  },

  -- Add Completion Plugin
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for completion
    },
  },
}

