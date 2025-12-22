return {
  "nvim-treesitter/nvim-treesitter",
  commit = "4e230137097fc04b8cf61108e80ecd8f41665afe", -- Pin to last stable version with configs API
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "python",
        "c", "cpp",
        "c_sharp",
        "html", "css", "javascript", "typescript",
        "lua", "bash", "json", "yaml", "markdown", "vim", "vimdoc",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<bs>",
        },
      },
    })

    vim.treesitter.language.register("bash", "zsh")
  end,
}
