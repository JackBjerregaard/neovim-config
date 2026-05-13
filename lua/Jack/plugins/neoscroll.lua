return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")

    local function native_scroll(lhs)
      local count = vim.v.count > 0 and tostring(vim.v.count) or ""
      local keys = vim.api.nvim_replace_termcodes(count .. lhs, true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)
    end

    local function smooth_scroll(lhs, rhs)
      return function()
        if vim.wo.scrollbind or vim.wo.diff or vim.w.codediff_restore then
          native_scroll(lhs)
          return
        end

        rhs()
      end
    end

    neoscroll.setup({
      mappings = {},
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = true,
      easing = "quadratic",
      ignored_events = { "WinScrolled", "CursorMoved" },
    })

    local keymap = {
      ["<C-u>"] = smooth_scroll("<C-u>", function()
        neoscroll.ctrl_u({ duration = 250, easing = "sine" })
      end),
      ["<C-d>"] = smooth_scroll("<C-d>", function()
        neoscroll.ctrl_d({ duration = 250, easing = "sine" })
      end),
      ["<C-b>"] = smooth_scroll("<C-b>", function()
        neoscroll.ctrl_b({ duration = 450, easing = "circular" })
      end),
      ["<C-f>"] = smooth_scroll("<C-f>", function()
        neoscroll.ctrl_f({ duration = 450, easing = "circular" })
      end),
      ["<C-y>"] = smooth_scroll("<C-y>", function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
      end),
      ["<C-e>"] = smooth_scroll("<C-e>", function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
      end),
      zt = smooth_scroll("zt", function()
        neoscroll.zt({ half_win_duration = 250 })
      end),
      zz = smooth_scroll("zz", function()
        neoscroll.zz({ half_win_duration = 250 })
      end),
      zb = smooth_scroll("zb", function()
        neoscroll.zb({ half_win_duration = 250 })
      end),
    }

    for lhs, rhs in pairs(keymap) do
      vim.keymap.set({ "n", "v", "x" }, lhs, rhs, { desc = "Smooth scroll" })
    end
  end,
}
