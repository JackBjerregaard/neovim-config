-- Live server functionality using npm's live-server package
-- Install with: npm install -g live-server

-- Variable to track the live server job
local live_server_job = nil

-- Start live server in current directory
vim.api.nvim_create_user_command("LiveServerStart", function()
  if live_server_job then
    vim.notify("Live server is already running!", vim.log.levels.WARN)
    return
  end

  -- Get the directory of the current file, or use cwd if no file is open
  local dir = vim.fn.expand("%:p:h")
  if dir == "" or dir == "." then
    dir = vim.fn.getcwd()
  end

  -- Start live server in background with --no-browser flag
  -- We'll manually open with wslview for WSL compatibility
  live_server_job = vim.fn.jobstart("cd " .. vim.fn.shellescape(dir) .. " && live-server --no-browser", {
    on_exit = function()
      live_server_job = nil
      vim.notify("Live server stopped", vim.log.levels.INFO)
    end,
    on_stdout = function(_, data)
      if data and #data > 0 then
        for _, line in ipairs(data) do
          if line:match("Serving") then
            vim.notify("Live server started: " .. line, vim.log.levels.INFO)
          end
        end
      end
    end,
  })

  if live_server_job > 0 then
    vim.notify("Starting live server in: " .. dir, vim.log.levels.INFO)
    -- Open browser using wslview after a short delay
    vim.defer_fn(function()
      vim.fn.jobstart("wslview http://localhost:8080", { detach = true })
    end, 1000)
  else
    vim.notify("Failed to start live server. Is it installed? (npm install -g live-server)", vim.log.levels.ERROR)
    live_server_job = nil
  end
end, {})

-- Stop live server
vim.api.nvim_create_user_command("LiveServerStop", function()
  if live_server_job then
    vim.fn.jobstop(live_server_job)
    live_server_job = nil
    vim.notify("Stopping live server...", vim.log.levels.INFO)
  else
    vim.notify("No live server is running", vim.log.levels.WARN)
  end
end, {})

-- Toggle live server
vim.api.nvim_create_user_command("LiveServerToggle", function()
  if live_server_job then
    vim.cmd("LiveServerStop")
  else
    vim.cmd("LiveServerStart")
  end
end, {})

-- Keybindings
vim.keymap.set("n", "<leader>ls", ":LiveServerToggle<CR>", {
  desc = "Toggle live server",
  silent = true
})
