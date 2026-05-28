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
    
    local function file_in_cwd(file_name)
      return vim.fs.find(file_name, {
        upward = true,
        stop = vim.uv.cwd():match("(.+)/"),
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        type = "file",
      })[1]
    end
    
    local function remove_linter(linters, linter_name)
      for k, v in pairs(linters) do
        if v == linter_name then
          linters[k] = nil
          break
        end
      end
    end
    
    local function linter_in_linters(linters, linter_name)
      for k, v in pairs(linters) do
        if v == linter_name then
          return true
        end
      end
      return false
    end
    
    local function remove_linter_if_missing_config_file(linters, linter_name, config_file_name)
      if linter_in_linters(linters, linter_name) and not file_in_cwd(config_file_name) then
        remove_linter(linters, linter_name)
      end
    end
    
    local function try_linting()
      local linters = lint.linters_by_ft[vim.bo.filetype]
      if linters then
        -- Only run eslint_d if config file exists
        remove_linter_if_missing_config_file(linters, "eslint_d", "eslint.config.js")
        remove_linter_if_missing_config_file(linters, "eslint_d", ".eslintrc.js")
        remove_linter_if_missing_config_file(linters, "eslint_d", ".eslintrc.json")
      end
      lint.try_lint(linters)
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
