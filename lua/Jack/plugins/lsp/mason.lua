return {
  "williamboman/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "+",
          package_pending = ">",
          package_uninstalled = "x",
        },
      },
    })

    local servers = {
      "pyright",
      "ts_ls",
      "html",
      "cssls",
      "emmet_ls",
      "tailwindcss",
      "sqlls",
      "omnisharp",
      "fsautocomplete",
      "lua_ls",
    }

    -- Mason's clangd release has no Linux ARM64 build. Keep using an external
    -- clangd there, while retaining automatic installation on other platforms.
    local uname = vim.uv.os_uname()
    local linux_arm64 = uname.sysname == "Linux"
      and (uname.machine == "aarch64" or uname.machine == "arm64")
    if not linux_arm64 then
      table.insert(servers, "clangd")
    elseif vim.fn.executable("clangd") == 0 then
      vim.notify("Install clangd separately on Linux ARM64; see README.md", vim.log.levels.WARN)
    end

    mason_lspconfig.setup({
      ensure_installed = servers,
      automatic_enable = false,
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
        "stylelint",
        -- SQL
        "sqlfluff",
        -- C / C++
        "clang-format",
        "cpplint",

        -- C# / F#
        "csharpier",
        "fantomas",
        -- Lua
        "stylua",
      },
    })
  end,
}
