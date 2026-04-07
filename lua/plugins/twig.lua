-- Extend LazyVim's lang.twig extra with HTML support inside Twig files.
-- The lang.twig extra handles Twig-specific formatting (twig-cs-fixer) and LSP
-- (twiggy_language_server), but does not cover the HTML elements embedded in
-- Twig templates.  These specs add:
--   1. HTML Treesitter parser – required for injection/highlighting of HTML
--      content inside .twig buffers.
--   2. conform.nvim `injected` formatter – formats injected HTML regions using
--      the HTML formatter (e.g. prettier) without disturbing the Twig formatter.
--   3. html LSP attached to twig filetypes – provides completion, hover, and
--      diagnostics for HTML tags/attributes inside .twig files.

return {
  -- 1. Ensure the HTML Treesitter parser is installed.
  --    nvim-treesitter uses it to inject HTML grammar into Twig buffers, enabling
  --    correct syntax highlighting and the injected-language formatting below.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html" })
    end,
  },

  -- 2. Add the `injected` formatter for Twig so that HTML blocks embedded in
  --    Twig templates are formatted via their own formatter (e.g. prettier).
  --    twig-cs-fixer (added by lang.twig) continues to handle Twig syntax;
  --    `injected` runs afterwards on each injected-language region independently.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local twig_fmts = opts.formatters_by_ft.twig or {}
      -- Append `injected` only once, after any Twig-specific formatter.
      if not vim.tbl_contains(twig_fmts, "injected") then
        table.insert(twig_fmts, "injected")
      end
      opts.formatters_by_ft.twig = twig_fmts
      return opts
    end,
  },

  -- 3. Extend the HTML language server's filetypes to include `twig`.
  --    This attaches vscode-html-language-server to Twig buffers alongside
  --    twiggy_language_server, giving HTML completion, hover docs, and
  --    diagnostics for the HTML portions of the template.
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.html = opts.servers.html or {}
      -- Extend whatever filetypes are already configured (e.g. "templ" added by
      -- other extras) rather than replacing them wholesale.
      local filetypes = opts.servers.html.filetypes or { "html" }
      if not vim.tbl_contains(filetypes, "twig") then
        table.insert(filetypes, "twig")
      end
      opts.servers.html.filetypes = filetypes
      return opts
    end,
  },
}
