-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Use Treesitter-based indentation for Twig buffers so that HTML tags mixed
-- with Twig constructs indent correctly. Disabling smartindent prevents Vim's
-- generic indent heuristics from fighting the Treesitter indent expression.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "twig",
  callback = function()
    vim.bo.indentexpr = "nvim_treesitter#indent()"
    vim.bo.autoindent = true
    vim.bo.smartindent = false
  end,
})
