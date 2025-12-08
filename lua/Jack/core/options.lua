vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 --2 spaces for tabs 
opt.shiftwidth = 2 --2 spaces for indent width 
opt.expandtab = true -- expand tabl to spaces 
opt.autoindent = true --copy indent from current line when starting new one 

opt.wrap = false 

-- Search settings 
opt.ignorecase = true --ignore case when searching 
opt.smartcase = true --if you incldue mixed case in your seacrh, assumes you want case-senseitive 

opt.cursorline = false

-- enable true color support for modern themes
-- (have to use iterm2 or any other true color terminal) 

opt.termguicolors = true
-- opt.background = "dark" -- Commented out to allow light themes to work properly
opt.signcolumn = "yes" --show sign column so that text doesn't shift 

--backspace 
opt.backspace = "indent,eol,start" --allow backspace on indent, end of line or inster mode start position 

--clipboard 
opt.clipboard:append("unnamedplus") --use system clipboard as default register 

local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local is_wsl = vim.fn.has("wsl") == 1
if is_windows or is_wsl then
  local win32yank = vim.fn.stdpath("config") .. "/bin/win32yank.exe"
  if vim.fn.executable(win32yank) == 1 then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = win32yank .. " -i --crlf",
        ["*"] = win32yank .. " -i --crlf",
      },
      paste = {
        ["+"] = win32yank .. " -o --lf",
        ["*"] = win32yank .. " -o --lf",
      },
      cache_enabled = 0,
    }
  end
end

--split windows 
opt.splitright = true --split vertical window to the right 
opt.splitbelow = true --split horizontal window to the bottom 

-- disable swap files
vim.opt.swapfile = false

-- allow switching buffers with unsaved changes
opt.hidden = true

-- disable automatic comment continuation
opt.formatoptions:remove({ "r", "o" })
