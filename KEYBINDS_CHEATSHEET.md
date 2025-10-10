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
| Normal | `<leader>sm` | Maximize/minimize a split |

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

## File Explorer (nvim-tree)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>ee` | Toggle file explorer |
| Normal | `<leader>ef` | Toggle explorer on current file |
| Normal | `<leader>ec` | Collapse file explorer |
| Normal | `<leader>er` | Refresh file explorer |

---

## Fuzzy Finding (Telescope)

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>ff` | Find files in cwd |
| Normal | `<leader>fr` | Find recent files |
| Normal | `<leader>fs` | Find string in cwd (live grep) |
| Normal | `<leader>fc` | Find string under cursor |
| Normal | `<leader>ft` | Find todos |
| Insert (Telescope) | `<C-k>` | Move selection up |
| Insert (Telescope) | `<C-j>` | Move selection down |
| Insert (Telescope) | `<C-q>` | Send to quickfix list |

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
| Normal | `<leader>rn` | Rename symbol |
| Normal | `<leader>rs` | Restart LSP server |

---

## LSP Diagnostics

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>D` | Show all buffer diagnostics |
| Normal | `<leader>d` | Show line diagnostic |
| Normal | `[d` | Previous diagnostic |
| Normal | `]d` | Next diagnostic |

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

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal | `<leader>r` | Substitute with motion |
| Normal | `<leader>rr` | Substitute line |
| Normal | `<leader>R` | Substitute to end of line |
| Visual | `<leader>r` | Substitute selection |

---

## Formatting & Linting

| Mode | Keybind | Description |
|------|---------|-------------|
| Normal/Visual | `<leader>mp` | Format file/range |
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

## Quick Reference: Most Used

| Category | Keybind | Action |
|----------|---------|--------|
| **Files** | `<Space>ee` | Toggle file explorer |
| **Files** | `<Space>ff` | Find files |
| **Files** | `<Space>fs` | Search in files |
| **Code** | `gd` | Go to definition |
| **Code** | `K` | Show docs |
| **Code** | `<Space>ca` | Code actions |
| **Code** | `<Space>rn` | Rename |
| **Code** | `<Space>mp` | Format |
| **Edit** | `jk` | Exit insert mode |
| **Edit** | `gcc` | Comment line |
| **Git** | `]h` / `[h` | Next/prev hunk |
| **Git** | `<Space>hs` | Stage hunk |
| **Git** | `<Space>hp` | Preview hunk |
| **Errors** | `]d` / `[d` | Next/prev diagnostic |
| **Errors** | `<Space>d` | Show diagnostic |
| **Errors** | `<Space>xw` | Open Trouble |

---

**Config Location:** `/home/jack/.config/nvim/`
