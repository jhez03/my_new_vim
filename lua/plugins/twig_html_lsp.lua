-- Attach the HTML language server to Twig buffers so that HTML completion,
-- hover, and diagnostics work inside *.twig files.
--
-- Requirements:
--   vscode-html-language-server is installed via Mason (add "html-lsp" to
--   mason.nvim ensure_installed, or let mason-lspconfig handle it).
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Extend the html server config so it also attaches to twig buffers.
      opts.servers.html = vim.tbl_deep_extend("force", opts.servers.html or {}, {
        filetypes = { "html", "twig" },
      })
    end,
  },
  -- Ensure vscode-html-language-server is installed by Mason.
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html-lsp" })
    end,
  },
}
