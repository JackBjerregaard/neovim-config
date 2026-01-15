return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "c", "cpp",
        "c_sharp",
        "html", "css", "javascript", "typescript",
        "lua", "bash", "json", "yaml", "markdown", "vim", "vimdoc",
      },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      -- Treesitter indent is often inaccurate for Python; keep it disabled there
      indent = { enable = true, disable = { "python" } },
    })

    -- Register bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
