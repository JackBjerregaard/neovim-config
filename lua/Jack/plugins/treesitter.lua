return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      configs = require("nvim-treesitter.config")
    end

    -- Language parsers we care about
    local parsers = {
      "python",
      "c",
      "cpp",
      "c_sharp",
      "html",
      "css",
      "javascript",
      "typescript",
      "lua",
      "bash",
      "json",
      "yaml",
      "markdown",
      "vim",
      "vimdoc",
    }

    configs.setup({
      ensure_installed = parsers,
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { "python" },
      },
    })

    -- Register bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")

    -- Ensure treesitter is started for zsh (uses bash parser)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "zsh",
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
