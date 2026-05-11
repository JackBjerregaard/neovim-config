return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- Language parsers we care about
    local parsers = {
      "python",
      "c",
      "cpp",
      "c_sharp",
      "fsharp",
      "html",
      "css",
      "javascript",
      "typescript",
      "lua",
      "bash",
      "json",
      "xml",
      "yaml",
      "sql",
      "make",
      "vim",
      "vimdoc",
    }

    local treesitter = require("nvim-treesitter")
    treesitter.setup()
    local parser_filetypes = vim.list_extend(vim.deepcopy(parsers), { "fslex", "zsh" })

    local ok_select, textobject_select = pcall(require, "nvim-treesitter-textobjects.select")
    if ok_select and type(textobject_select.select_textobject) == "function" then
      local select_textobject = textobject_select.select_textobject
      local function map_textobject(lhs, query, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
          select_textobject(query, "textobjects")
        end, { desc = desc })
      end

      map_textobject("af", "@function.outer", "Select around function")
      map_textobject("if", "@function.inner", "Select inside function")
      map_textobject("ac", "@class.outer", "Select around class")
      map_textobject("ic", "@class.inner", "Select inside class")
    end

    -- Register bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
    vim.treesitter.language.register("fsharp", "fslex")

    -- Keep F# files highlighted even if their parser has not finished installing.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fsharp", "fslex" },
      callback = function(event)
        vim.bo[event.buf].syntax = "fsharp"
      end,
    })

    -- Markdown currently trips Neovim 0.12's Treesitter highlighter with the
    -- installed parser/query set, so keep Markdown on Vim syntax highlighting.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function(event)
        pcall(vim.treesitter.stop, event.buf)
        vim.bo[event.buf].syntax = "markdown"
      end,
    })

    -- Start highlighting via Neovim core where a parser is installed.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = parser_filetypes,
      callback = function(event)
        pcall(vim.treesitter.start, event.buf)
      end,
    })
  end,
}
