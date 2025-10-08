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

--turn on termiguicolours for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal) 

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" --show sign column so that text doesn't shift 

--backspace 
opt.backspace = "indent,eol,start" --allow backspace on indent, end of line or inster mode start position 

--clipboard 
opt.clipboard:append("unnamedplus") --use system clipboard as default register 

--split windows 
opt.splitright = true --split vertical window to the right 
opt.splitbelow = true --split horizontal window to the bottom 

-- disable swap files 
vim.opt.swapfile = false
