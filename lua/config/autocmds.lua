-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Twig indent settings
-- Twig templates mix HTML (2-space convention) with Twig block syntax.
-- Setting shiftwidth/tabstop/expandtab ensures consistent indentation, and
-- enabling nvim-treesitter-based indentexpr gives smarter auto-indent for both
-- HTML tags and Twig blocks compared to the default filetype indent rules.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "twig",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    -- Use Treesitter-based indentation so HTML tags and Twig blocks are
    -- indented correctly.  Only set when the twig parser is actually installed;
    -- falls back to the default filetype indent rules otherwise.
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and parsers.has_parser("twig") then
      vim.bo.indentexpr = "nvim_treesitter#indent()"
    end
  end,
  desc = "Set indent settings for Twig files (HTML + Twig syntax)",
})
