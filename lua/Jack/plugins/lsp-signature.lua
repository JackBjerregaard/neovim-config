return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  config = function()
    local lsp_signature = require("lsp_signature")

    local config = {
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
    }

    local function attach(client, bufnr)
      if vim.bo[bufnr].filetype == "fsharp" or (client and client.name == "fsautocomplete") then
        return
      end

      if client and not client:supports_method("textDocument/signatureHelp") then
        return
      end

      lsp_signature.on_attach(config, bufnr)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspSignature", {}),
      callback = function(event)
        attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
      end,
    })

    for _, client in ipairs(vim.lsp.get_clients()) do
      for bufnr in pairs(client.attached_buffers or {}) do
        attach(client, bufnr)
      end
    end
  end,
}
