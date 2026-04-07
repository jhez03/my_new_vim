-- Ensure Treesitter parsers for `twig` and `html` are installed so that
-- syntax highlighting and indentation work inside *.twig files.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "twig", "html" })
    end,
  },
}
