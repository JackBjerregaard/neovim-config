return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Install parsers
    require("nvim-treesitter").install({
      "python",
      "c", "cpp",
      "c_sharp",
      "html", "css", "javascript", "typescript",
      "lua", "bash", "json", "yaml", "markdown", "vim", "vimdoc",
    })

    -- Enable treesitter highlighting for all filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        local ok = pcall(vim.treesitter.start)
        if not ok then
          -- Fallback to syntax highlighting if treesitter fails
          vim.cmd("syntax on")
        end
      end,
    })

    -- Enable treesitter-based indentation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "c", "cpp", "javascript", "typescript", "lua", "html", "css", "json", "yaml" },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- Register bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
