return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gv", "<cmd>CodeDiff<CR>", desc = "CodeDiff changed files" },
    { "<leader>gV", "<cmd>CodeDiff file HEAD<CR>", desc = "CodeDiff current file" },
    { "<leader>gh", "<cmd>CodeDiff history<CR>", desc = "CodeDiff history" },
    {
      "<leader>gI",
      function()
        local root = vim.fn.trim(vim.fn.system("git rev-list --max-parents=0 HEAD"))
        if vim.v.shell_error ~= 0 or root == "" then
          vim.notify("Could not find initial git commit", vim.log.levels.ERROR)
          return
        end

        vim.cmd("CodeDiff file " .. root)
      end,
      desc = "CodeDiff current file against initial commit",
    },
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
        toggle_explorer = "<leader>gp",
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

    local set_codediff_scroll_keymaps

    local function apply_codediff_window_options(tabpage)
      if not tabpage or not vim.api.nvim_tabpage_is_valid(tabpage) then
        return
      end

      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
        if vim.api.nvim_win_is_valid(win) then
          local bufnr = vim.api.nvim_win_get_buf(win)

          vim.wo[win].wrap = true
          vim.wo[win].linebreak = true
          vim.wo[win].breakindent = true
          vim.wo[win].list = false
          vim.wo[win].sidescrolloff = 0

          if vim.api.nvim_buf_is_valid(bufnr) then
            set_codediff_scroll_keymaps(bufnr)
          end
        end
      end
    end

    local function codediff_native_scroll(lhs)
      local tabpage = vim.api.nvim_get_current_tabpage()

      apply_codediff_window_options(tabpage)

      local count = vim.v.count > 0 and tostring(vim.v.count) or ""
      local keys = vim.api.nvim_replace_termcodes(count .. lhs, true, false, true)
      vim.api.nvim_feedkeys(keys, "nx", false)

      vim.schedule(function()
        apply_codediff_window_options(tabpage)
        vim.cmd("redraw!")
      end)
    end

    set_codediff_scroll_keymaps = function(bufnr)
      local keymap_opts = { buffer = bufnr, silent = true, desc = "CodeDiff native scroll" }

      for _, lhs in ipairs({ "<C-u>", "<C-d>", "<C-b>", "<C-f>" }) do
        vim.keymap.set("n", lhs, function()
          codediff_native_scroll(lhs)
        end, keymap_opts)
      end
    end

    local function schedule_codediff_window_options(tabpage)
      vim.schedule(function()
        apply_codediff_window_options(tabpage)
      end)

      for _, delay in ipairs({ 50, 250, 750 }) do
        vim.defer_fn(function()
          apply_codediff_window_options(tabpage)
        end, delay)
      end
    end

    local function patch_codediff_render_options()
      local ok, render = pcall(require, "codediff.ui.view.render")
      if not ok or render.__jack_window_options_patched then
        return
      end

      local compute_and_render = render.compute_and_render
      render.compute_and_render = function(...)
        local result = compute_and_render(...)
        local original_win = select(7, ...)
        local modified_win = select(8, ...)

        for _, win in ipairs({ original_win, modified_win }) do
          if win and vim.api.nvim_win_is_valid(win) then
            apply_codediff_window_options(vim.api.nvim_win_get_tabpage(win))
          end
        end

        return result
      end

      local compute_and_render_conflict = render.compute_and_render_conflict
      render.compute_and_render_conflict = function(...)
        local result = compute_and_render_conflict(...)
        local original_win = select(6, ...)
        local modified_win = select(7, ...)

        for _, win in ipairs({ original_win, modified_win }) do
          if win and vim.api.nvim_win_is_valid(win) then
            apply_codediff_window_options(vim.api.nvim_win_get_tabpage(win))
          end
        end

        return result
      end

      render.__jack_window_options_patched = true
    end

    patch_codediff_render_options()

    local window_group = vim.api.nvim_create_augroup("JackCodeDiffWindowOptions", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      pattern = { "CodeDiffOpen", "CodeDiffFileSelect" },
      group = window_group,
      callback = function(args)
        local tabpage = args.data and args.data.tabpage or vim.api.nvim_get_current_tabpage()
        schedule_codediff_window_options(tabpage)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffOpen",
      group = vim.api.nvim_create_augroup("JackCodeDiffHistoryPanel", { clear = true }),
      callback = function(args)
        local tabpage = args.data and args.data.tabpage or vim.api.nvim_get_current_tabpage()

        if not args.data or args.data.mode ~= "history" then
          return
        end

        local lifecycle = require("codediff.ui.lifecycle")

        lifecycle.set_tab_keymap(tabpage, "n", opts.keymaps.view.toggle_explorer, function()
          local history_panel = lifecycle.get_explorer(tabpage)
          if history_panel and history_panel.split then
            require("codediff.ui.history").toggle_visibility(history_panel)

            if not history_panel.is_hidden and history_panel.winid and vim.api.nvim_win_is_valid(history_panel.winid) then
              vim.api.nvim_set_current_win(history_panel.winid)
            end
            return
          end

          vim.cmd("CodeDiff history")
        end, { desc = "Toggle CodeDiff history panel" })
      end,
    })
  end,
}
