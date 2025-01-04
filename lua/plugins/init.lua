return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python", "go",
        "javascript", "cpp",
      },
      auto_install = true,
      indent = { enable = true },
      highlight = { enable = true },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "configs.cmp"
    end,
  },
}
