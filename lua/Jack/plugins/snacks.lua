local function git_status_finder(opts, ctx)
  opts = opts or {}
  local git_source = require("snacks.picker.source.git")
  local proc = require("snacks.picker.source.proc")
  local args = git_source.git("status", "-unormal", "--porcelain=v1", "-z", { args = { "--no-pager" } }, opts)
  if opts.ignored then
    table.insert(args, "--ignored=matching")
  end

  local cwd = ctx:git_root()
  ctx.picker:set_cwd(cwd)

  local prev ---@type snacks.picker.finder.Item?
  return proc.proc(
    ctx:opts({
      sep = "\0",
      cwd = cwd,
      cmd = "git",
      args = args,
      ---@param item snacks.picker.finder.Item
      transform = function(item)
        local status, file = item.text:match("^(..) (.+)$")
        if status then
          item.cwd = cwd
          item.status = status
          item.file = file
          prev = item
        elseif prev and prev.status:find("R") then
          prev.rename = item.text
          return false
        else
          return false
        end
      end,
    }),
    ctx
  )
end

local curated_colorschemes = {
  ["kanagawa"] = true,
  ["tokyonight"] = true,
  ["nordic"] = true,
  ["dracula-soft"] = true,
  ["catppuccin"] = true,
  ["catppuccin-mocha"] = true,
  ["catppuccin-macchiato"] = true,
  ["catppuccin-frappe"] = true,
  ["rose-pine"] = true,
  ["rose-pine-main"] = true,
  ["rose-pine-moon"] = true,
  ["gruvbox"] = true,
  ["everforest"] = true,
  ["tokyodark"] = true,
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = {
      enabled = true,
      scope = {
        enabled = false,
        treesitter = { enabled = false },
      },
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      sources = {
        colorschemes = {
          transform = function(item)
            return curated_colorschemes[item.text] and item or false
          end,
        },
        git_status = {
          finder = git_status_finder, -- ensure git_status always sets cmd when spawning git
        },
      },
    },
    quickfile = { enabled = false },
    scope = {
      enabled = false,
      treesitter = { enabled = false },
    },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        position = "bottom",
        height = 0.32, -- roughly VS Code terminal height
      },
    },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- ============================================================================
    -- FILE EXPLORER (replaces nvim-tree)
    -- ============================================================================
    { "<leader>ee", function() Snacks.explorer() end, desc = "Toggle file explorer" },
    { "<leader>ef", function() Snacks.explorer({ opts = { find_file = true } }) end, desc = "Toggle file explorer on current file" },
    -- Note: snacks.explorer doesn't have direct collapse/refresh commands
    -- These are handled internally or via keybindings within the explorer window

    -- ============================================================================
    -- FILE FINDING (replaces telescope file finding)
    -- ============================================================================
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Fuzzy find files in cwd" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Fuzzy find recent files" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Find keymaps" },

    -- ============================================================================
    -- SEARCH/GREP (replaces telescope grep)
    -- ============================================================================
    { "<leader>fs", function() Snacks.picker.grep() end, desc = "Find string in cwd" },
    { "<leader>fc", function() Snacks.picker.grep_word() end, desc = "Find string under cursor" },
    { "<leader>ft", function() Snacks.picker.grep({ search = "TODO|HACK|WARN|PERF|NOTE|FIX" }) end, desc = "Find todos" },

    -- ============================================================================
    -- LSP (replaces telescope LSP pickers)
    -- ============================================================================
    { "gR", function() Snacks.picker.lsp_references() end, desc = "Show LSP references" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Show LSP definitions" },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Show LSP implementations" },
    { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Show LSP type definitions" },
    { "<leader>D", function() Snacks.picker.diagnostics_buffer() end, desc = "Show buffer diagnostics" },

    -- ============================================================================
    -- GIT (new features from snacks)
    -- ============================================================================
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git commits" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gf", function() Snacks.gitbrowse() end, desc = "Git browse (open in browser)", mode = { "n", "v" } },

    -- ============================================================================
    -- TERMINAL (new feature)
    -- ============================================================================
    { "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal" },

    -- ============================================================================
    -- BUFFER MANAGEMENT
    -- ============================================================================
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Find buffers" },

    -- ============================================================================
    -- NOTIFICATIONS
    -- ============================================================================
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>hn", function() Snacks.notifier.show_history() end, desc = "Notification History" },

    -- ============================================================================
    -- FILE OPERATIONS
    -- ============================================================================
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

    -- ============================================================================
    -- ZEN & FOCUS MODES (new features)
    -- ============================================================================
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

    -- ============================================================================
    -- SCRATCH BUFFERS (new feature)
    -- ============================================================================
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    -- ============================================================================
    -- WORD REFERENCES (highlights word under cursor)
    -- ============================================================================
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

    -- ============================================================================
    -- ADDITIONAL SEARCH/PICKERS
    -- ============================================================================
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>th", function() Snacks.picker.colorschemes() end, desc = "Pick Theme" },

    -- ============================================================================
    -- NEOVIM NEWS
    -- ============================================================================
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        vim._print = function(_, ...)
          dd(...)
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
