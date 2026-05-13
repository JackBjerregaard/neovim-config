# Neovim Keybinds Cheatsheet

**Leader Key:** `<Space>`

---

## General Keybinds

| Mode | Keybind | Description |
|------|---------|-------------|
| Insert | `jk` | Exit insert mode |
| Normal | `<leader>nh` | Clear search highlights |
| Normal | `<leader>+` | Increment number under cursor |
| Normal | `<leader>-` | Decrement number under cursor |

---

## Window Management

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>sv` | Split window vertically |
| Normal | `<leader>sh` | Split window horizontally |
| Normal | `<leader>se` | Make splits equal size |
| Normal | `<leader>sx` | Close current split window |

### Window Navigation

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<C-h>` | Move to left window |
| Normal | `<C-j>` | Move to window below |
| Normal | `<C-k>` | Move to window above |
| Normal | `<C-l>` | Move to right window |

---

## Tab Management

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>to` | Open new tab |
| Normal | `<leader>tx` | Close current tab |
| Normal | `<leader>tn` | Go to next tab |
| Normal | `<leader>tp` | Go to previous tab |
| Normal | `<leader>tf` | Open current buffer in new tab |

---

## Quickfix List

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `]q` | Next quickfix item |
| Normal | `[q` | Previous quickfix item |
| Normal | `<leader>qo` | Open quickfix list |
| Normal | `<leader>qc` | Close quickfix list |
| Normal | `<leader>qq` | Toggle quickfix list |
| Normal | `<leader>qf` | Jump to first quickfix item |
| Normal | `<leader>ql` | Jump to last quickfix item |
| Insert (Telescope) | `<C-q>` | Send selected to quickfix |

---

## File Explorer (snacks.explorer)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>ee` | Toggle file explorer |
| Normal | `<leader>ef` | Toggle explorer on current file |

---

## File Finding & Pickers (snacks.picker)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>ff` | Find files in cwd |
| Normal | `<leader>fr` | Find recent files |
| Normal | `<leader>fs` | Find string in cwd (live grep) |
| Normal | `<leader>fc` | Find string under cursor |
| Normal | `<leader>ft` | Find todos |
| Normal | `<leader>fk` | Find keymaps |
| Normal | `<leader>bb` | Find buffers |

---

## Additional Pickers (snacks.picker)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>sa` | Search autocmds |
| Normal | `<leader>sb` | Search buffer lines |
| Normal | `<leader>sc` | Search commands |
| Normal | `<leader>sd` | Search diagnostics |
| Normal | `<leader>sh` | Search help pages |
| Normal | `<leader>sH` | Search highlights |
| Normal | `<leader>sj` | Search jumps |
| Normal | `<leader>sk` | Search keymaps |
| Normal | `<leader>sm` | Search marks |
| Normal | `<leader>sM` | Search man pages |
| Normal | `<leader>sq` | Search quickfix list |
| Normal | `<leader>sR` | Resume last picker |
| Normal | `<leader>su` | Search undo history |
| Normal | `<leader>uC` | Search colorschemes |
| Normal | `<leader>s"` | Search registers |

---

## Marks (marks.nvim)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `m,` | Set next available mark |
| Normal | `m]` | Jump to next mark in buffer |
| Normal | `m[` | Jump to previous mark in buffer |
| Normal | `m;` | Preview nearest mark |
| Normal | `m-` | Delete mark on current line |
| Normal | `m_` | Delete all buffer-local marks |
| Normal | `<leader>km` | List marks in current buffer |
| Normal | `<leader>kM` | List all marks in project |
| Normal | `<leader>kt` | Toggle gutter signs for marks |

---

## Git (snacks.nvim)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>gb` | Git branches picker |
| Normal | `<leader>gc` | Git commits/log picker |
| Normal | `<leader>gs` | Git status picker |
| Normal | `<leader>gg` | Open Lazygit |
| Normal/Visual | `<leader>gf` | Git browse (open in browser) |
| Normal | `<leader>gv` | CodeDiff changed-files explorer |
| Normal | `<leader>gV` | CodeDiff current file against HEAD |
| Normal | `<leader>gh` | CodeDiff commit history |

### CodeDiff Commands

| Command | Description |
|---------|-------------|
| `:CodeDiff @{u}` | Compare working tree against upstream branch; use after `git fetch` for latest remote changes |
| `:CodeDiff file @{u}` | Compare current file against upstream branch |
| `:CodeDiff HEAD` | Compare working tree against latest local commit |
| `:CodeDiff HEAD~1 HEAD` | Compare latest local commit against its parent |
| `:CodeDiff main...HEAD` | PR-style diff for changes since branching from `main` |

### Inside CodeDiff

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `q` | Close CodeDiff |
| Normal | `<leader>b` | Toggle CodeDiff explorer/history panel |
| Normal | `]c` | Next diff hunk |
| Normal | `[c` | Previous diff hunk |
| Normal | `]f` | Next changed file |
| Normal | `[f` | Previous changed file |
| Normal | `t` | Toggle side-by-side/inline layout |
| Normal | `g?` | Show CodeDiff help |

---

## Smooth Scrolling (neoscroll.nvim)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal/Visual/Select | `<C-u>` | Smooth half-page up |
| Normal/Visual/Select | `<C-d>` | Smooth half-page down |
| Normal/Visual/Select | `<C-b>` | Smooth full-page up |
| Normal/Visual/Select | `<C-f>` | Smooth full-page down |
| Normal/Visual/Select | `<C-y>` | Smooth line scroll up without moving cursor |
| Normal/Visual/Select | `<C-e>` | Smooth line scroll down without moving cursor |
| Normal/Visual/Select | `zt` | Smooth scroll cursor line to top |
| Normal/Visual/Select | `zz` | Smooth scroll cursor line to center |
| Normal/Visual/Select | `zb` | Smooth scroll cursor line to bottom |

Note: these mappings use native Vim scrolling in diff/CodeDiff windows so synchronized panes stay aligned.

---

## Terminal (snacks.terminal)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>tt` | Toggle floating terminal |
| Terminal | `jk` | Exit terminal mode (back to normal mode) |

**Note:** After exiting terminal mode with `jk`, use `<C-h/j/k/l>` to navigate between windows.

---

## Zen & Focus Modes (snacks.nvim)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>z` | Toggle zen mode (distraction-free) |
| Normal | `<leader>Z` | Toggle zoom (maximize current window - replaces vim-maximizer) |

---

## Scratch Buffers (snacks.scratch)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>.` | Toggle scratch buffer |
| Normal | `<leader>S` | Select scratch buffer |

---

## Buffer Management (snacks.nvim)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>bd` | Delete buffer (smart) |
| Normal | `<leader>bb` | Find buffers |

---

## Word References (snacks.words)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal/Terminal | `]]` | Jump to next word reference |
| Normal/Terminal | `[[` | Jump to previous word reference |

---

## Notifications (snacks.notifier)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>hn` | Show notification history |
| Normal | `<leader>un` | Dismiss all notifications |

---

## Theme & Info

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>th` | Browse and apply colorschemes (Snacks picker) |
| Normal | `<leader>N` | Open the built-in Neovim news buffer |

---

## Toggle Options (snacks.toggle)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>us` | Toggle spelling |
| Normal | `<leader>uw` | Toggle line wrap |
| Normal | `<leader>uL` | Toggle relative numbers |
| Normal | `<leader>ud` | Toggle diagnostics |
| Normal | `<leader>ul` | Toggle line numbers |
| Normal | `<leader>uc` | Toggle conceallevel |
| Normal | `<leader>uT` | Toggle treesitter |
| Normal | `<leader>ub` | Toggle dark/light background |
| Normal | `<leader>uh` | Toggle inlay hints |
| Normal | `<leader>ug` | Toggle indent guides |
| Normal | `<leader>uD` | Toggle dim |

---

## LSP Navigation

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `gR` | Show all references |
| Normal | `gD` | Go to declaration |
| Normal | `gd` | Go to definition |
| Normal | `gi` | Show implementations |
| Normal | `gt` | Go to type definition |
| Normal | `K` | Show documentation/hover |

---

## LSP Code Actions

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal/Visual | `<leader>ca` | Show code actions |
| Normal | `<leader>rn` | **Rename symbol (changes ALL instances project-wide)** |
| Normal | `<leader>cR` | Rename file (with LSP updates) |
| Normal | `<leader>rs` | Restart LSP server |
| Insert | `<C-k>` | Toggle signature help |
| Insert | `<M-n>` | Cycle through signatures |

---

## LSP Diagnostics

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>D` | Show all buffer diagnostics |
| Normal | `<leader>d` | Show line diagnostic |
| Normal | `[d` | Previous diagnostic |
| Normal | `]d` | Next diagnostic |
| Normal | `<leader>td` | Toggle all diagnostics on/off |
| Normal | `<leader>tw` | Toggle warnings (keep errors) |

---

## Git (Gitsigns)

### Navigation

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `]h` | Next git hunk |
| Normal | `[h` | Previous git hunk |

### Hunk Actions

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>hs` | Stage hunk |
| Normal | `<leader>hr` | Reset hunk |
| Visual | `<leader>hs` | Stage selected hunk |
| Visual | `<leader>hr` | Reset selected hunk |
| Normal | `<leader>hS` | Stage entire buffer |
| Normal | `<leader>hR` | Reset entire buffer |
| Normal | `<leader>hu` | Undo stage hunk |

### Preview & Blame

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>hp` | Preview hunk |
| Normal | `<leader>hb` | Show blame for line |
| Normal | `<leader>hB` | Toggle inline blame |

### Diff

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>hd` | Diff current file |
| Normal | `<leader>hD` | Diff against last commit |

### Text Objects

| Mode | Keybind | Description |
|------|---------|-------------|
| Operator/Visual | `ih` | Select git hunk |

---

## Code Completion (Insert Mode)

| Mode | Keybind | Description |
|------|---------|-------------|
| Insert | `<C-k>` | Previous suggestion |
| Insert | `<C-j>` | Next suggestion |
| Insert | `<C-b>` | Scroll docs up |
| Insert | `<C-f>` | Scroll docs down |
| Insert | `<C-Space>` | Show completions |
| Insert | `<C-e>` | Close completion menu |
| Insert | `<CR>` | Confirm selection |

---

## Treesitter Selection

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<C-space>` | Start selection |
| Visual | `<C-space>` | Expand selection |
| Visual | `<C-s>` | Expand to scope |
| Visual | `<BS>` | Shrink selection |

---

## Commenting

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `gcc` | Toggle line comment |
| Normal | `gc{motion}` | Comment with motion |
| Visual | `gc` | Toggle comment on selection |
| Normal | `gbc` | Toggle block comment |
| Normal | `gb{motion}` | Block comment with motion |
| Visual | `gb` | Toggle block comment |

---

## Surround

| Mode | Keybind | Description | Example |
|------|---------|-------------|---------|
| Normal | `ys{motion}{char}` | Add surrounding | `ysiw"` - surround word |
| Normal | `ds{char}` | Delete surrounding | `ds"` - delete quotes |
| Normal | `cs{old}{new}` | Change surrounding | `cs"'` - change " to ' |
| Visual | `S{char}` | Surround selection | Select + `S"` |

---

## Substitute

**Workflow:** Yank text first, then use substitute to replace target without affecting register.

| Mode | Keybind | Description | Example |
|------|---------|-------------|---------|
| Normal | `<leader>r{motion}` | Substitute with motion | `yiw` → `<leader>riw` (replace word) |
| Normal | `<leader>rr` | Substitute entire line | `yy` → move → `<leader>rr` |
| Normal | `<leader>R` | Substitute to end of line | `yiw` → position → `<leader>R` |
| Visual | `<leader>r` | Substitute selection | `yiw` → `viw` → `<leader>r` |

**Flash Integration:** Use `<leader>r` + `r` (flash remote) to substitute at any visible location with labels.

---

## Formatting & Linting

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal/Visual | `<leader>fm` | Format current buffer or visual selection |
| Normal | `<leader>l` | Trigger linting |

---

## Diagnostics (Trouble)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>xw` | Workspace diagnostics |
| Normal | `<leader>xd` | Document diagnostics |
| Normal | `<leader>xq` | Quickfix in Trouble |
| Normal | `<leader>xl` | Location list in Trouble |
| Normal | `<leader>xt` | Todos in Trouble |

---

## Session Management

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>wr` | Restore session |
| Normal | `<leader>ws` | Save session |
| Normal | `<leader>wd` | Delete session |

---

## Todo Comments

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `]t` | Next todo comment |
| Normal | `[t` | Previous todo comment |

---

## File Navigation (Grapple)

### Tag Management

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>m` | Toggle tag on current file |
| Normal | `<leader>M` | Untag current file |
| Normal | `<leader>a` | Open tags window |

### Quick Select (Jump to Tagged Files)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>1-9` | Jump to tag 1-9 |
| Normal | `]g` | Next grapple tag |
| Normal | `[g` | Previous grapple tag |

### Scope Management

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>as` | Open scopes window |
| Normal | `<leader>al` | Open loaded scopes window |
| Normal | `<leader>ar` | Reset all tags in the current scope |

---

## Flash Navigation

### Jump Commands

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal/Visual/Operator | `s` | Flash jump (search and label) |
| Normal/Visual/Operator | `S` | Flash treesitter (jump to code structures) |
| Operator | `r` | Remote flash (operate on remote location) |
| Operator/Visual | `R` | Treesitter search with flash labels |
| Command (in search) | `<C-s>` | Toggle flash search labels |

---

## Live Development Server

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>ls` | Toggle the npm `live-server` for the current project |

**Prerequisite:** Install `live-server` globally (`npm install -g live-server`).

---

## Quick Reference: Most Used

| Category | Keybind | Action |
|----------|---------|--------|
| **Files** | `<Space>ee` | Toggle file explorer |
| **Files** | `<Space>ff` | Find files |
| **Files** | `<Space>fs` | Search in files |
| **Files** | `<Space>m` | Tag file (grapple) |
| **Files** | `<Space>a` | View tags (grapple) |
| **Files** | `<Space>1-9` | Jump to tag 1-9 |
| **Code** | `gd` | Go to definition |
| **Code** | `K` | Show docs |
| **Code** | `<Space>ca` | Code actions |
| **Code** | `<Space>rn` | Rename (all instances) |
| **Code** | `<Space>fm` | Format |
| **Edit** | `jk` | Exit insert mode |
| **Edit** | `gcc` | Comment line |
| **Edit** | `s` | Flash jump |
| **Edit** | `<leader>r{motion}` | Substitute with motion |
| **Git** | `]h` / `[h` | Next/prev hunk |
| **Git** | `<Space>hs` | Stage hunk |
| **Git** | `<Space>hp` | Preview hunk |
| **Git** | `<Space>gg` | Open Lazygit |
| **Terminal** | `<leader>tt` | Toggle terminal |
| **Terminal** | `jk` (in terminal) | Exit terminal mode |
| **Navigation** | `<C-h/j/k/l>` | Navigate between windows |
| **Navigation** | `]g` / `[g` | Next/prev grapple tag |
| **Errors** | `]d` / `[d` | Next/prev diagnostic |
| **Errors** | `<Space>d` | Show diagnostic |
| **Errors** | `<Space>xw` | Open Trouble |
| **Dev** | `<Space>ls` | Toggle live server |

---

**Config Location:** `/home/jack/.config/nvim/`
