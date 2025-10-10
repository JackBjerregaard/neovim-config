return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      auto_restore = false,  -- <-- new name
      auto_save = true,
      auto_session_suppress_dirs = {
        "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/"
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
    keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>",    { desc = "Save session for cwd" })
    keymap.set("n", "<leader>wd", "<cmd>AutoSession delete<CR>",  { desc = "Delete session for cwd" })
  end,
}
