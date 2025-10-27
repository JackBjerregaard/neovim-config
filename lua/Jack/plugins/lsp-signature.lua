return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  config = function()
    require("lsp_signature").setup({
      bind = true,
      handler_opts = {
        border = "rounded"
      },
      hint_enable = false,
      floating_window = true,
      floating_window_above_cur_line = true,
      toggle_key = "<C-k>",
      select_signature_key = "<M-n>",
      transparency = 10,
      max_width = 80,
      max_height = 12,
    })
  end,
}
