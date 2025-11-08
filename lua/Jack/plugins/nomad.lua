return {
  "nomad/nomad",
  version = "*",
  build = function()
    ---@type nomad.neovim.build
    local build = require("nomad.neovim.build")

    build.builders.download_prebuilt():build(build.contexts.lazy())
  end,
  opts = {},
  config = function(_, opts)
    require("nomad").setup(opts)

    -- Keybindings for Nomad collaboration
    vim.keymap.set("n", "<leader>cs", "<cmd>Mad collab start<CR>", { desc = "Collab: Start session" })
    vim.keymap.set("n", "<leader>cc", "<cmd>Mad collab copy-id<CR>", { desc = "Collab: Copy session ID" })
    vim.keymap.set("n", "<leader>cj", function()
      local session_id = vim.fn.input("Session ID: ")
      if session_id ~= "" then
        vim.cmd("Mad collab join " .. session_id)
      end
    end, { desc = "Collab: Join session" })
    vim.keymap.set("n", "<leader>cl", "<cmd>Mad collab leave<CR>", { desc = "Collab: Leave session" })
  end,
}
