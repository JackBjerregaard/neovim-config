return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    
    lint.linters_by_ft = {
      python = { "pylint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      css = { "stylelint" },
      scss = { "stylelint" },
      sass = { "stylelint" },
      less = { "stylelint" },
      sql = { "sqlfluff" },
      c = { "cpplint" },
      cpp = { "cpplint" },
    }

    lint.linters.sqlfluff.args = {
      "lint",
      "--dialect",
      "postgres",
      "--format=json",
      "-",
    }

    local function find_python_site_packages(root_dir)
      local candidates = { ".venv", "venv", "env" }
      for _, name in ipairs(candidates) do
        local lib_dir = vim.fs.joinpath(root_dir, name, "lib")
        if vim.uv.fs_stat(lib_dir) then
          for python_dir in vim.fs.dir(lib_dir) do
            if vim.startswith(python_dir, "python") then
              local site_packages = vim.fs.joinpath(lib_dir, python_dir, "site-packages")
              if vim.uv.fs_stat(site_packages) then
                return site_packages
              end
            end
          end
        end
      end
      return nil
    end

    lint.linters.pylint.args = function()
      local buffer_path = vim.api.nvim_buf_get_name(0)
      local root_dir = vim.fs.root(buffer_path, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }) or vim.uv.cwd()
      local site_packages = find_python_site_packages(root_dir)
      local args = { "-f", "json", "--persistent=no", "--from-stdin", buffer_path }

      if site_packages then
        table.insert(args, 1, "--init-hook=import sys; sys.path.insert(0, " .. string.format("%q", site_packages) .. ")")
      end

      return args
    end
    
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    
    local eslint_configs = {
      "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
      "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
      ".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
      ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml",
    }

    local function has_eslint_config()
      local name = vim.api.nvim_buf_get_name(0)
      local path = name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
      -- Search relative to the buffer, including monorepo parents, not :pwd.
      return vim.fs.find(function(filename, directory)
        if vim.tbl_contains(eslint_configs, filename) then
          return true
        end
        if filename == "package.json" then
          local ok, package = pcall(function()
            return vim.json.decode(table.concat(vim.fn.readfile(vim.fs.joinpath(directory, filename)), "\n"))
          end)
          return ok and type(package) == "table" and type(package.eslintConfig) == "table"
        end
        return false
      end, { path = path, upward = true, type = "file" })[1] ~= nil
    end

    local function try_linting()
      local configured = lint.linters_by_ft[vim.bo.filetype]
      if not configured then
        return
      end
      -- Filtering must not mutate the shared list when switching projects.
      local linters = vim.tbl_filter(function(name)
        return name ~= "eslint_d" or has_eslint_config()
      end, configured)
      if #linters > 0 then
        lint.try_lint(linters)
      end
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        try_linting()
      end,
    })
    
    vim.keymap.set("n", "<leader>l", function()
      try_linting()
    end, { desc = "Trigger linting for current file" })
  end,
}
