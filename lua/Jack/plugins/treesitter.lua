return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        -- 🐍 Python
        "python",

        -- ⚙️ Systems languages
        "c", "cpp",

        -- 💻 .NET languages
        "c_sharp",
        -- "fsharp", -- uncomment later if parser becomes available

        -- 🌐 Web stack
        "html", "css", "javascript", "typescript",

        -- 🧩 Config / Utility
        "lua", "bash", "json", "yaml", "markdown", "vim", "vimdoc",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",     -- start selecting
          node_incremental = "<C-space>",   -- expand selection
          scope_incremental = "<C-s>",      -- expand to scope (optional)
          node_decremental = "<bs>",        -- shrink selection
        },
      },
    })

    -- Use bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
