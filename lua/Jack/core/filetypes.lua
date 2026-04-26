vim.filetype.add({
  extension = {
    fs = "fsharp",
    fsi = "fsharp",
    fsx = "fsharp",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fsharp",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})
