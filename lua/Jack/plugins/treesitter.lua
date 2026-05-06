return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
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
      "markdown",
      "make",
      "vim",
      "vimdoc",
    }

    configs.setup({
      ensure_installed = parsers,
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        -- Keep F# highlighted even before the parser finishes installing.
        additional_vim_regex_highlighting = { "fsharp" },
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
    })

    local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
    local function map_textobject(lhs, query, desc)
      vim.keymap.set({ "x", "o" }, lhs, function()
        select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    map_textobject("af", "@function.outer", "Select around function")
    map_textobject("if", "@function.inner", "Select inside function")
    map_textobject("ac", "@class.outer", "Select around class")
    map_textobject("ic", "@class.inner", "Select inside class")

    -- Register bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
    vim.treesitter.language.register("fsharp", "fslex")

    -- Ensure treesitter is started for zsh (uses bash parser)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "zsh", "fslex" },
      callback = function()
        vim.treesitter.start()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fsharp",
      callback = function(event)
        vim.bo[event.buf].syntax = "fsharp"
      end,
    })
  end,
}
