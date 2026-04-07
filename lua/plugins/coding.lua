return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap.preset = "none"
      opts.keymap["<C-l>"] = { "accept" }
      opts.keymap["<CR>"] = { "fallback" }
      opts.keymap["<C-n>"] = { "select_next" } -- Ctrl-n moves down
      opts.keymap["<C-p>"] = { "select_prev" } -- Ctrl-p moves up
      return opts
    end,
  },
  -- copilot
}
