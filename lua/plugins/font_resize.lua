return {
  {
    "ktunprasert/gui-font-resize.nvim",
    lazy = false,
    config = function()
      require("gui-font-resize").setup({
        default_size = 16, -- Set your preferred default font size
        change_by = 1,     -- Increment/Decrement step for resizing
        bounds = {
          maximum = 24,    -- Maximum font size
          minimum = 8,     -- Minimum font size
        },
      })
    end,
  }
}
