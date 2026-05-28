return {
  "chentoast/marks.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local marks = require("marks")
    local mark_utils = require("marks.utils")

    marks.setup({
      default_mappings = false,
      builtin_marks = {},
      cyclic = true,
      force_write_shada = true,
      refresh_interval = 200,
      sign_priority = {
        lower = 10,
        upper = 15,
        builtin = 8,
        bookmark = 20,
      },
      mappings = {
        set_next = "m,",
        next = "m]",
        prev = "m[",
        preview = "m;",
        delete_line = "m-",
        delete_buf = "m_",
      },
    })

    local function list_get_line(bufnr, line)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return nil
      end

      local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, line - 1, line, false)
      if not ok or not lines[1] then
        return nil
      end

      return lines[1]
    end

    local function list_fn(list_type)
      return mark_utils.choose_list(list_type or "loclist")
    end

    local function reset_buffer_state(bufnr)
      mark_utils.remove_buf_signs(bufnr)
      marks.mark_state.buffers[bufnr] = {
        placed_marks = {},
        marks_by_line = {},
        lowest_available_mark = "a",
      }
    end

    local function delete_buffer_marks(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        marks.mark_state.buffers[bufnr] = nil
        return
      end

      for byte = string.byte("a"), string.byte("z") do
        pcall(vim.api.nvim_buf_del_mark, bufnr, string.char(byte))
      end

      reset_buffer_state(bufnr)

      if marks.mark_state.opt.force_write_shada then
        pcall(vim.cmd, "wshada!")
      end
    end

    local function delete_all_marks()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
          delete_buffer_marks(bufnr)
        end
      end

      pcall(vim.cmd, "delmarks A-Z")
      marks.mark_state.buffers = {}

      if marks.mark_state.opt.force_write_shada then
        pcall(vim.cmd, "wshada!")
      end
    end

    function marks.delete_buf()
      delete_buffer_marks()
    end

    function marks.mark_state:buffer_to_list(list_type, bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      if not vim.api.nvim_buf_is_valid(bufnr) then
        self.buffers[bufnr] = nil
        return
      end

      if not self.buffers[bufnr] then
        return
      end

      local items = {}
      for mark, data in pairs(self.buffers[bufnr].placed_marks) do
        local text = list_get_line(bufnr, data.line)
        if text then
          table.insert(items, {
            bufnr = bufnr,
            lnum = data.line,
            col = data.col + 1,
            text = "mark " .. mark .. ": " .. text,
          })
        end
      end

      list_fn(list_type)(items, "r")
    end

    function marks.mark_state:all_to_list(list_type)
      local items = {}
      for bufnr, buffer_state in pairs(self.buffers) do
        if not vim.api.nvim_buf_is_valid(bufnr) then
          self.buffers[bufnr] = nil
        else
          for mark, data in pairs(buffer_state.placed_marks) do
            local text = list_get_line(bufnr, data.line)
            if text then
              table.insert(items, {
                bufnr = bufnr,
                lnum = data.line,
                col = data.col + 1,
                text = "mark " .. mark .. ": " .. text,
              })
            end
          end
        end
      end

      list_fn(list_type)(items, "r")
    end

    function marks.mark_state:global_to_list(list_type)
      local items = {}
      for bufnr, buffer_state in pairs(self.buffers) do
        if not vim.api.nvim_buf_is_valid(bufnr) then
          self.buffers[bufnr] = nil
        else
          for mark, data in pairs(buffer_state.placed_marks) do
            if mark_utils.is_upper(mark) then
              local text = list_get_line(bufnr, data.line)
              if text then
                table.insert(items, {
                  bufnr = bufnr,
                  lnum = data.line,
                  col = data.col + 1,
                  text = "mark " .. mark .. ": " .. text,
                })
              end
            end
          end
        end
      end

      list_fn(list_type)(items, "r")
    end

    function marks.bookmark_state:all_to_list(list_type)
      local items = {}
      for group_nr, group in pairs(self.groups) do
        for bufnr, buffer_marks in pairs(group.marks) do
          if not vim.api.nvim_buf_is_valid(bufnr) then
            group.marks[bufnr] = nil
          else
            for line, mark in pairs(buffer_marks) do
              local text = list_get_line(bufnr, line)
              if text then
                table.insert(items, {
                  bufnr = bufnr,
                  lnum = line,
                  col = mark.col + 1,
                  text = "bookmark group " .. group_nr .. ": " .. text,
                })
              end
            end
          end
        end
      end

      list_fn(list_type)(items, "r")
    end

    function marks.mark_state:preview_mark()
      vim.api.nvim_echo({ { "press letter mark to preview, or press <esc> to quit" } }, true, {})

      local ok, input = pcall(vim.fn.getchar)
      if not ok or input == 27 then
        return
      end

      local mark = string.char(input)
      local pos = vim.fn.getpos("'" .. mark)
      if pos[2] == 0 then
        return
      end

      vim.defer_fn(function()
        vim.api.nvim_echo({ { "" } }, false, {})
      end, 100)

      local bufnr = pos[1] ~= 0 and pos[1] or vim.api.nvim_get_current_buf()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      local width = vim.api.nvim_win_get_width(0)
      local height = vim.api.nvim_win_get_height(0)
      local win = vim.api.nvim_open_win(bufnr, true, {
        relative = "win",
        win = 0,
        width = math.floor(width / 2),
        height = math.floor(height / 2),
        col = math.floor(width / 4),
        row = math.floor(height / 8),
        border = "single",
      })

      vim.api.nvim_win_set_cursor(win, { pos[2], math.max(pos[3] - 1, 0) })
      vim.cmd("normal! zz")

      local function close_preview()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
        pcall(vim.keymap.del, "n", "q", { buffer = bufnr })
      end

      vim.keymap.set("n", "q", close_preview, { buffer = bufnr, silent = true, desc = "Close marks preview" })
      vim.api.nvim_create_autocmd("WinClosed", {
        once = true,
        callback = function(event)
          if tonumber(event.match) == win then
            pcall(vim.keymap.del, "n", "q", { buffer = bufnr })
          end
        end,
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("JackMarksCloseWithQ", { clear = true }),
      pattern = "qf",
      callback = function(event)
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close list" })
      end,
    })

    vim.keymap.set("n", "m_", delete_buffer_marks, { desc = "Delete marks in buffer" })
    vim.keymap.set("n", "<leader>kD", delete_all_marks, { desc = "Delete all marks" })
    vim.keymap.set("n", "<leader>km", "<cmd>MarksListBuf<cr>", { desc = "Marks (buffer)" })
    vim.keymap.set("n", "<leader>kM", "<cmd>MarksListAll<cr>", { desc = "Marks (all files)" })
    vim.keymap.set("n", "<leader>kt", "<cmd>MarksToggleSigns<cr>", { desc = "Toggle mark signs" })
  end,
}
