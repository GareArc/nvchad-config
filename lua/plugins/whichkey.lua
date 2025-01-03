return {
  {
    "folke/which-key.nvim",
    keys = { "<leader>" }, -- Ensure <leader> triggers Which-Key
    cmd = "WhichKey",
    opts = function()
      require("which-key").setup({
        triggers = "auto",     -- Automatically show Which-Key on <leader>
        window = {
          border = "rounded",  -- Optional: Customize the menu border
          position = "bottom", -- Always show Which-Key at the bottom
        },
      })
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },
}
