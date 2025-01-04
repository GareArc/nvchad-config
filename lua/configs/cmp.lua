local cmp = require("cmp")

cmp.setup({
  mapping = {
    -- Map Down and Up for navigation
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
    ["<C-e>"] = cmp.mapping.abort(), -- Abort completion
    -- Do not include Tab and Shift-Tab mappings
  },
  -- Other cmp configurations (sources, formatting, etc.)
})

