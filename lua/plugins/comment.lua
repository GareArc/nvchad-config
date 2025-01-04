return {
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb", "<C-_>" }, -- Specify the keys that trigger the plugin
    config = function()
      require("Comment").setup({
        -- Additional configuration if needed
      })

      -- Map Ctrl+/ in insert mode to toggle line comments
      vim.keymap.set('i', '<C-_>', function()
        require('Comment.api').toggle.linewise.current()
      end, { desc = 'Toggle comment on current line' })

      -- Map Ctrl+/ in normal mode to toggle line comments
      vim.keymap.set('n', '<C-_>', function()
        require('Comment.api').toggle.linewise.current()
      end, { desc = 'Toggle comment on current line' })

      -- Map Ctrl+/ in visual mode to toggle block comments
      vim.keymap.set('x', '<C-_>', function()
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
      end, { desc = 'Toggle comment on selected lines' })

      -- Map Ctrl+Shift+/ in visual mode to toggle block comments
      vim.keymap.set('x', '<C-S-_>', function()
        require('Comment.api').toggle.blockwise(vim.fn.visualmode())
      end, { desc = 'Toggle block comment on selected lines' })

    end,
  },
}
