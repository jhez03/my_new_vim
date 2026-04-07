-- Configure conform.nvim to format *.twig buffers.
--
-- Formatter chain (run in order, all formatters that succeed are applied):
--   1. twig-cs-fixer  — handles Twig constructs/tags (already set up by
--                       LazyVim's twig extra; install via Composer globally:
--                       `composer global require vincentlanglet/twig-cs-fixer`)
--   2. djlint         — formats the HTML portions of Twig templates without
--                       requiring a Node project.
--                       Install globally (recommended via pipx):
--                         pipx install djlint
--                       or: pip install --user djlint
--
-- Both formatters are optional: conform.nvim skips a formatter that is not
-- found on $PATH, so you can enable either or both independently.
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- Run twig-cs-fixer first (handles Twig syntax), then djlint (handles
      -- HTML indentation/formatting). `stop_after_first = false` is the
      -- default, so both will run when available.
      opts.formatters_by_ft.twig = { "twig-cs-fixer", "djlint" }

      -- djlint formatter configuration: pass --profile=jinja so it treats
      -- Twig/Jinja-style tags as known constructs instead of errors.
      opts.formatters = opts.formatters or {}
      opts.formatters.djlint = {
        prepend_args = { "--profile", "jinja" },
      }
    end,
  },
}
