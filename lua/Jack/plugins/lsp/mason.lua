return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- 🌐 Language Servers (intelligence)
    mason_lspconfig.setup({
      ensure_installed = {
        -- Python
        "pyright",
        -- Web
        "ts_ls",
        "html",
        "cssls",
        "emmet_ls",
        "tailwindcss",
        -- C / C++
        "clangd",
        -- C# / F#
        "omnisharp",
        "fsautocomplete",
        -- Lua
        "lua_ls",
      },
      automatic_enable = true,
    })

    -- 🧰 Formatters / Linters / Misc Tools
    mason_tool_installer.setup({
      ensure_installed = {
        -- Python
        "black",
        "isort",
        "pylint",
        -- Web
        "prettier",
        "eslint_d",
        -- C / C++
        "clang-format",
        -- C# / F#
        "csharpier",
        "fantomas",
        -- Lua
        "stylua",
      },
    })
  end,
}
