return {
  "chentoast/marks.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local marks = require("marks")

    marks.setup({
      default_mappings = false,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = true,
      refresh_interval = 200,
      sign_priority = {
        lower = 10,
        upper = 15,
        builtin = 8,
        bookmark = 20,
      },
      mappings = {
        set_next = "m,",
        next = "m]",
        prev = "m[",
        preview = "m;",
        delete_line = "m-",
        delete_buf = "m_",
      },
    })

    vim.keymap.set("n", "<leader>km", "<cmd>MarksListBuf<cr>", { desc = "Marks (buffer)" })
    vim.keymap.set("n", "<leader>kM", "<cmd>MarksListAll<cr>", { desc = "Marks (all files)" })
    vim.keymap.set("n", "<leader>kt", "<cmd>MarksToggleSigns<cr>", { desc = "Toggle mark signs" })
  end,
}
