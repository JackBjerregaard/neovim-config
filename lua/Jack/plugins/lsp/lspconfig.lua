return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap
    
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        
        -- Navigation keybinds
        opts.desc = "Show all references to symbol under cursor"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        
        opts.desc = "Jump to declaration of symbol"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        
        opts.desc = "Jump to definition of symbol"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        
        opts.desc = "Show implementations of interface/abstract class"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        
        opts.desc = "Jump to type definition"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        
        -- Code action keybinds
        opts.desc = "Show available code actions (quick fixes/refactors)"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        
        opts.desc = "Rename symbol across entire project"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        
        -- Diagnostic keybinds
        opts.desc = "Show all diagnostics in current buffer"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        
        opts.desc = "Show diagnostic for current line in floating window"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        
        opts.desc = "Jump to previous diagnostic (error/warning/hint)"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        
        opts.desc = "Jump to next diagnostic (error/warning/hint)"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        
        -- Documentation keybind
        opts.desc = "Show documentation/signature help for symbol under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        
        -- Utility keybind
        opts.desc = "Restart LSP server for current buffer"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })
    
    -- Enable autocompletion capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()
    
    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = true,  -- Show inline error messages
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      update_in_insert = false,  -- Don't show diagnostics while typing
      severity_sort = true,       -- Sort by severity (errors first)
    })
    
    -- Apply default configuration to all LSP servers
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
    
    -- 🌐 Web Development
    vim.lsp.enable("ts_ls")        -- TypeScript/JavaScript
    vim.lsp.enable("html")         -- HTML
    vim.lsp.enable("cssls")        -- CSS
    vim.lsp.enable("tailwindcss")  -- Tailwind CSS
    
    vim.lsp.config("emmet_ls", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    })
    
    -- 🐍 Python
    vim.lsp.enable("pyright")
    
    -- 🔧 C / C++
    vim.lsp.enable("clangd")
    
    -- 🟦 C#
    vim.lsp.enable("omnisharp")
    
    -- 🔷 F#
    vim.lsp.enable("fsautocomplete")
    
    -- 🌙 Lua (Neovim configuration files)
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },  -- Recognize 'vim' as a global
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
}
