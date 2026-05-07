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
        keymap.set("n", "gR", function() Snacks.picker.lsp_references() end, opts)

        opts.desc = "Jump to declaration of symbol"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Jump to definition of symbol"
        keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)

        opts.desc = "Show implementations of interface/abstract class"
        keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)

        opts.desc = "Jump to type definition"
        keymap.set("n", "gt", function() Snacks.picker.lsp_type_definitions() end, opts)
        
        -- Code action keybinds
        opts.desc = "Show available code actions (quick fixes/refactors)"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        
        opts.desc = "Rename symbol across entire project"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        
        -- Diagnostic keybinds
        opts.desc = "Show all diagnostics in current buffer"
        keymap.set("n", "<leader>D", function() Snacks.picker.diagnostics_buffer() end, opts)
        
        opts.desc = "Show diagnostic for current line in floating window"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        
        opts.desc = "Jump to previous diagnostic (error/warning/hint)"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        
        opts.desc = "Jump to next diagnostic (error/warning/hint)"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Toggle all diagnostics on/off"
        keymap.set("n", "<leader>td", function()
          vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end, opts)

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
    
    local warnings_visible = false

    local function apply_diagnostic_config()
      local severity_filter = warnings_visible and nil or { min = vim.diagnostic.severity.ERROR }

      vim.diagnostic.config({
        virtual_text = warnings_visible and true or { severity = severity_filter },
        underline = warnings_visible and true or { severity = severity_filter },
        signs = warnings_visible and {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
          },
        } or {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
          },
          severity = severity_filter,
        },
        update_in_insert = false,  -- Don't show diagnostics while typing
        severity_sort = true,      -- Sort by severity (errors first)
      })
    end

    -- Configure diagnostic display (warnings off by default)
    apply_diagnostic_config()

    -- Toggle warnings (keep errors visible)
    vim.keymap.set("n", "<leader>tw", function()
      warnings_visible = not warnings_visible
      apply_diagnostic_config()
    end, { desc = "Toggle warning diagnostics (keep errors)" })

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

    -- 🗄️ SQL
    vim.lsp.enable("sqlls")
    
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
