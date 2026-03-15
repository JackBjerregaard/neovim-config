return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Install language parsers
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

    -- Install parsers asynchronously
    require("nvim-treesitter").install(parsers)

    -- Register bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")

    -- Enable treesitter highlighting for supported filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Enable treesitter highlighting for zsh (using bash parser)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "zsh",
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Set up indentation (disable for Python as it's often inaccurate)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function(args)
        local bufnr = args.buf
        if vim.bo[bufnr].filetype ~= "python" then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
