return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  config = function()
    require("lsp_signature").setup({
      bind = true,
      handler_opts = {
        border = "rounded"
      },
      hint_enable = false, -- Disable virtual text hints (can be noisy)
      floating_window = true, -- Show signature in floating window
      floating_window_above_cur_line = true, -- Position above current line
      toggle_key = "<C-k>", -- Press Ctrl-k to toggle signature on/off
      select_signature_key = "<M-n>", -- Cycle through multiple signatures if available
      transparency = 10, -- Slight transparency
      max_width = 80, -- Max width of signature window
      max_height = 12, -- Max height of signature window
    })
  end,
}
