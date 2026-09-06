-- Run from the repository root: nvim --headless -u NONE -l tests/config_spec.lua
local calls = {}
local lint = { linters = { sqlfluff = {}, pylint = {} }, try_lint = function(names)
  table.insert(calls, vim.deepcopy(names))
end }
package.loaded.lint = lint
dofile("lua/Jack/plugins/linting.lua").config()
local temp = vim.fn.tempname()
vim.fn.mkdir(temp .. "/configured/src", "p")
vim.fn.mkdir(temp .. "/plain", "p")
vim.fn.mkdir(temp .. "/unrelated", "p")
local original_cwd = vim.uv.cwd()
vim.cmd.cd(temp .. "/unrelated")
local function check(path, filetype, expected)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_name(buf, path)
  vim.bo[buf].filetype = filetype
  calls = {}
  vim.api.nvim_exec_autocmds("InsertLeave", { buffer = buf })
  assert(vim.deep_equal(calls, expected), vim.inspect({ path = path, calls = calls, expected = expected }))
  assert(vim.deep_equal(lint.linters_by_ft.javascript, { "eslint_d" }), "Shared linter list mutated")
  vim.api.nvim_buf_delete(buf, { force = true })
end
local ok, err = pcall(function()
  check(temp .. "/plain/a.js", "javascript", {})
  for _, filename in ipairs({"eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
    "eslint.config.ts", "eslint.config.mts", "eslint.config.cts", ".eslintrc.json", ".eslintrc.yml"}) do
    local config = temp .. "/configured/" .. filename
    vim.fn.writefile({"{}"}, config)
    check(temp .. "/configured/src/a.js", "javascript", {{ "eslint_d" }})
    check(temp .. "/plain/b.js", "javascript", {})
    check(temp .. "/configured/src/b.js", "javascript", {{ "eslint_d" }})
    vim.fn.delete(config)
  end
  local manifest = temp .. "/configured/package.json"
  vim.fn.writefile({'{"eslintConfig":{}}'}, manifest)
  check(temp .. "/configured/src/c.js", "javascript", {{ "eslint_d" }})
  vim.fn.writefile({'{"name":"no-eslint"}'}, manifest)
  check(temp .. "/configured/src/d.js", "javascript", {})
  vim.fn.writefile({'invalid json'}, manifest)
  check(temp .. "/configured/src/e.js", "javascript", {})
  check(temp .. "/plain/a.py", "python", {{ "pylint" }})
  check(temp .. "/plain/a.txt", "text", {})
end)
vim.cmd.cd(original_cwd)
vim.fn.delete(temp, "rf")
assert(ok, err)
print("ESLint: config variants, parent search, project switching, package.json and other filetypes OK")

local servers, tools
package.loaded.mason = { setup = function() end }
package.loaded["mason-lspconfig"] = { setup = function(opts) servers = opts.ensure_installed end }
package.loaded["mason-tool-installer"] = { setup = function(opts) tools = opts.ensure_installed end }
local original_uname, original_notify = vim.uv.os_uname, vim.notify
local warnings = {}
vim.notify = function(msg) table.insert(warnings, msg) end
for _, case in ipairs({
  { "Linux", "aarch64", false }, { "Linux", "arm64", false },
  { "Linux", "x86_64", true }, { "Darwin", "arm64", true }, { "Windows_NT", "x86_64", true },
}) do
  vim.uv.os_uname = function() return { sysname = case[1], machine = case[2] } end
  dofile("lua/Jack/plugins/lsp/mason.lua").config()
  assert(vim.tbl_contains(servers, "clangd") == case[3], "Incorrect clangd platform selection")
  assert(vim.tbl_contains(tools, "cpplint"), "cpplint missing")
end
vim.uv.os_uname, vim.notify = original_uname, original_notify
print("Mason: Linux ARM64 skips clangd, Linux x64/macOS ARM64/Windows retain it; cpplint included")
