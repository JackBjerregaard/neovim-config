return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gv", "<cmd>CodeDiff<CR>", desc = "CodeDiff changed files" },
    { "<leader>gV", "<cmd>CodeDiff file HEAD<CR>", desc = "CodeDiff current file" },
    { "<leader>gh", "<cmd>CodeDiff history<CR>", desc = "CodeDiff history" },
  },
  opts = {
    highlights = {
      line_insert = "DiffAdd",
      line_delete = "DiffDelete",
      char_insert = nil,
      char_delete = nil,
      char_brightness = nil,
    },
    diff = {
      layout = "side-by-side",
      disable_inlay_hints = true,
      ignore_trim_whitespace = false,
      hide_merge_artifacts = true,
      original_position = "left",
      cycle_next_hunk = true,
      cycle_next_file = true,
      jump_to_first_change = true,
      highlight_priority = 100,
      compute_moves = false,
    },
    explorer = {
      position = "left",
      width = 40,
      indent_markers = true,
      initial_focus = "explorer",
      view_mode = "tree",
      flatten_dirs = true,
      file_filter = {
        ignore = { ".git/**", ".jj/**" },
      },
      focus_on_select = false,
      visible_groups = {
        staged = true,
        unstaged = true,
        conflicts = true,
      },
    },
    history = {
      position = "bottom",
      height = 15,
      initial_focus = "history",
      view_mode = "tree",
    },
    keymaps = {
      view = {
        quit = "q",
        toggle_explorer = "<leader>b",
        focus_explorer = "<leader>e",
        next_hunk = "]c",
        prev_hunk = "[c",
        next_file = "]f",
        prev_file = "[f",
        diff_get = "do",
        diff_put = "dp",
        open_in_prev_tab = "gf",
        toggle_stage = "-",
        stage_hunk = "<leader>hs",
        unstage_hunk = "<leader>hu",
        discard_hunk = "<leader>hr",
        hunk_textobject = "ih",
        show_help = "g?",
        align_move = "gm",
        toggle_layout = "t",
      },
      explorer = {
        select = "<CR>",
        hover = "K",
        refresh = "R",
        toggle_view_mode = "i",
        stage_all = "S",
        unstage_all = "U",
        restore = "X",
        toggle_changes = "gu",
        toggle_staged = "gs",
        fold_open = "zo",
        fold_open_recursive = "zO",
        fold_close = "zc",
        fold_close_recursive = "zC",
        fold_toggle = "za",
        fold_toggle_recursive = "zA",
        fold_open_all = "zR",
        fold_close_all = "zM",
      },
      history = {
        select = "<CR>",
        toggle_view_mode = "i",
        refresh = "R",
        fold_open = "zo",
        fold_open_recursive = "zO",
        fold_close = "zc",
        fold_close_recursive = "zC",
        fold_toggle = "za",
        fold_toggle_recursive = "zA",
        fold_open_all = "zR",
        fold_close_all = "zM",
      },
      conflict = {
        accept_incoming = "<leader>ct",
        accept_current = "<leader>co",
        accept_both = "<leader>cb",
        discard = "<leader>cx",
        accept_all_incoming = "<leader>cT",
        accept_all_current = "<leader>cO",
        accept_all_both = "<leader>cB",
        discard_all = "<leader>cX",
        next_conflict = "]x",
        prev_conflict = "[x",
        diffget_incoming = "2do",
        diffget_current = "3do",
      },
    },
  },
  config = function(_, opts)
    require("codediff").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffOpen",
      group = vim.api.nvim_create_augroup("JackCodeDiffPanelToggle", { clear = true }),
      callback = function(args)
        if not args.data then
          return
        end

        local tabpage = args.data.tabpage or vim.api.nvim_get_current_tabpage()
        local mode = args.data.mode
        local lifecycle = require("codediff.ui.lifecycle")

        lifecycle.set_tab_keymap(tabpage, "n", opts.keymaps.view.toggle_explorer, function()
          local panel = lifecycle.get_explorer(tabpage)
          if panel and panel.split then
            if mode == "history" then
              require("codediff.ui.history").toggle_visibility(panel)
            else
              require("codediff.ui.explorer").toggle_visibility(panel)
            end

            if not panel.is_hidden and panel.winid and vim.api.nvim_win_is_valid(panel.winid) then
              vim.api.nvim_set_current_win(panel.winid)
            end
            return
          end

          if mode == "history" then
            vim.cmd("CodeDiff history")
          else
            vim.cmd("CodeDiff")
          end
        end, { desc = "Toggle CodeDiff explorer/history panel" })
      end,
    })
  end,
}
