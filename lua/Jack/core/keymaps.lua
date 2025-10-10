vim.g.mapleader= " " --to toggle custom keymaps just press space

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})

keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear search highlights"})

-- increment/decrement numbers 
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number"}) --increment 
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number"}) --decrement 

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- QUICKFIX 
-- Navigate (most important)
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Next quickfix' })
vim.keymap.set('n', '[q', ':cprevious<CR>', { desc = 'Previous quickfix' })

-- Open/close
vim.keymap.set('n', '<leader>qo', ':copen<CR>', { desc = 'Open quickfix' })
vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = 'Close quickfix' })

-- Toggle (optional but nice)
vim.keymap.set('n', '<leader>qq', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd('cclose')
  else
    vim.cmd('copen')
  end
end, { desc = 'Toggle quickfix' })

-- First/last
vim.keymap.set('n', '<leader>qf', ':cfirst<CR>', { desc = 'First quickfix' })
vim.keymap.set('n', '<leader>ql', ':clast<CR>', { desc = 'Last quickfix' })
