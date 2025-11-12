local state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"
local default_theme = "kanagawa"

local function read_saved_theme()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if ok and lines[1] and lines[1] ~= "" then
    return lines[1]
  end
end

local function apply_theme(name)
  if not name or name == "" then
    return false
  end
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(
      ("Colorscheme '%s' unavailable: %s"):format(name, err),
      vim.log.levels.WARN
    )
    return false
  end
  return true
end

local function persist_theme(name)
  if not name or name == "" then
    return
  end
  pcall(vim.fn.writefile, { name }, state_file)
end

local function load_theme()
  if not apply_theme(read_saved_theme()) then
    apply_theme(default_theme)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("JackPersistColorscheme", { clear = true }),
  callback = function(args)
    persist_theme(args.name or vim.g.colors_name)
  end,
})

return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      transparent = true,
      theme = "wave",
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      load_theme()
    end,
  },
  { "AlexvZyl/nordic.nvim", lazy = false, opts = { transparent_bg = true } },
  { "Mofiqul/dracula.nvim", lazy = false, opts = { transparent_bg = true } },
  { "sainnhe/everforest", lazy = false },
  { "tiagovla/tokyodark.nvim", lazy = false, opts = { transparent_background = true } },
}
