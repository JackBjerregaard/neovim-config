# Neovim Configuration Documentation

**Author:** Jack
**Config Location:** `/home/jack/.config/nvim/`
**Last Updated:** 2025-10-10

---

## Table of Contents

- [Overview](#overview)
- [File Structure](#file-structure)
- [Editor Settings](#editor-settings)
- [Plugin Manager](#plugin-manager)
- [Installed Plugins](#installed-plugins)
- [Language Server Protocol (LSP)](#language-server-protocol-lsp)
- [Formatters & Linters](#formatters--linters)
- [Color Scheme](#color-scheme)
- [Troubleshooting](#troubleshooting)

---

## Overview

This Neovim configuration is built with modern Lua-based plugins and focuses on providing a complete IDE-like experience for multiple programming languages including:

- **Web Development:** JavaScript, TypeScript, React, HTML, CSS, Tailwind
- **Python:** Full LSP support with formatting and linting
- **Systems Programming:** C/C++
- **.NET Development:** C#, F#
- **Configuration:** Lua

**Leader Key:** `<Space>` (Spacebar)

---

## File Structure

```
~/.config/nvim/
├── init.lua                          # Main entry point
├── lua/Jack/
│   ├── core/
│   │   ├── init.lua                  # Core initialization
│   │   ├── keymaps.lua               # General keybindings
│   │   └── options.lua               # Editor options/settings
│   ├── lazy.lua                      # Lazy.nvim plugin manager setup
│   └── plugins/
│       ├── init.lua                  # Utility plugins
│       ├── lsp/
│       │   ├── lspconfig.lua         # LSP server configurations
│       │   └── mason.lua             # LSP/tool installer
│       ├── alpha.lua                 # Startup dashboard
│       ├── auto-session.lua          # Session management
│       ├── autopairs.lua             # Auto-close brackets/quotes
│       ├── colourscheme.lua          # Theme configuration
│       ├── comment.lua               # Commenting plugin
│       ├── dressing.lua              # Better UI
│       ├── formatting.lua            # Code formatting
│       ├── gitsigns.lua              # Git integration
│       ├── indent-blankline.lua      # Indent guides
│       ├── linting.lua               # Linting configuration
│       ├── lualine.lua               # Status line
│       ├── nvim-cmp.lua              # Autocompletion
│       ├── nvim-tree.lua             # File explorer
│       ├── substitute.lua            # Substitute operator
│       ├── surround.lua              # Surround text
│       ├── telescope.lua             # Fuzzy finder
│       ├── todo-comments.lua         # Todo highlighting
│       ├── treesitter.lua            # Syntax highlighting
│       ├── trouble.lua               # Diagnostics viewer
│       ├── vim-maximizer.lua         # Split maximizer
│       └── which-key.lua             # Keybind helper
├── KEYBINDS_CHEATSHEET.md           # Quick keybind reference
└── DOCUMENTATION.md                  # This file
```

---

## Editor Settings

### Display Settings

| Setting | Value | Description |
|---------|-------|-------------|
| `relativenumber` | true | Show relative line numbers |
| `number` | true | Show absolute line number on cursor line |
| `cursorline` | false | Don't highlight current line |
| `signcolumn` | "yes" | Always show sign column (prevents text shifting) |
| `termguicolors` | true | Enable 24-bit RGB colors |
| `background` | "dark" | Dark background |
| `wrap` | false | Don't wrap long lines |

**File:** `lua/Jack/core/options.lua:5-27`

### Indentation

| Setting | Value | Description |
|---------|-------|-------------|
| `tabstop` | 2 | Tab width = 2 spaces |
| `shiftwidth` | 2 | Indent width = 2 spaces |
| `expandtab` | true | Convert tabs to spaces |
| `autoindent` | true | Copy indent from current line |

**File:** `lua/Jack/core/options.lua:9-12`

### Search Settings

| Setting | Value | Description |
|---------|-------|-------------|
| `ignorecase` | true | Ignore case in searches |
| `smartcase` | true | Case-sensitive if uppercase used |

**File:** `lua/Jack/core/options.lua:17-18`

### System Integration

| Setting | Value | Description |
|---------|-------|-------------|
| `clipboard` | "unnamedplus" | Use system clipboard |
| `backspace` | "indent,eol,start" | Backspace works everywhere |
| `swapfile` | false | Disable swap files |

**File:** `lua/Jack/core/options.lua:33-40`

### Window Splitting

| Setting | Value | Description |
|---------|-------|-------------|
| `splitright` | true | Vertical splits open right |
| `splitbelow` | true | Horizontal splits open below |

**File:** `lua/Jack/core/options.lua:36-37`

### File Browser (Netrw)

| Setting | Value | Description |
|---------|-------|-------------|
| `netrw_liststyle` | 3 | Tree view style |
| `loaded_netrw` | 1 (disabled) | Using nvim-tree instead |

**File:** `lua/Jack/core/options.lua:1`

---

## Plugin Manager

### Lazy.nvim

**Repository:** https://github.com/folke/lazy.nvim
**Installation Path:** `~/.local/share/nvim/lazy/lazy.nvim`

#### Features Enabled
- **Auto-update checking:** Enabled (no notifications)
- **Change detection:** Enabled (no notifications)
- **Automatic installation:** Plugins auto-install on first launch

#### Plugin Loading
Plugins are organized in two directories:
- `lua/Jack/plugins/` - General plugins
- `lua/Jack/plugins/lsp/` - LSP-specific plugins

**File:** `lua/Jack/lazy.lua`

---

## Installed Plugins

### Core Functionality

#### plenary.nvim
**Purpose:** Lua utility library required by many plugins
**Repository:** nvim-lua/plenary.nvim
**File:** `lua/Jack/plugins/init.lua:4`

#### which-key.nvim
**Purpose:** Shows popup with available keybindings
**Repository:** folke/which-key.nvim
**Timeout:** 500ms
**File:** `lua/Jack/plugins/which-key.lua`

---

### UI & Appearance

#### tokyonight.nvim
**Purpose:** Color scheme
**Repository:** folke/tokyonight.nvim
**Style:** Night theme with transparency
**Custom Colors:** Custom blue/teal palette
**File:** `lua/Jack/plugins/colourscheme.lua`

#### lualine.nvim
**Purpose:** Status line
**Repository:** nvim-lualine/lualine.nvim
**Theme:** Custom theme matching tokyonight
**Extra Features:** Shows pending Lazy.nvim updates
**File:** `lua/Jack/plugins/lualine.lua`

#### indent-blankline.nvim
**Purpose:** Show indent guides
**Repository:** lukas-reineke/indent-blankline.nvim
**Character:** `┊`
**File:** `lua/Jack/plugins/indent-blankline.lua`

#### dressing.nvim
**Purpose:** Better UI for vim.ui.select and vim.ui.input
**Repository:** stevearc/dressing.nvim
**File:** `lua/Jack/plugins/dressing.lua`

#### alpha-nvim
**Purpose:** Startup dashboard/greeter
**Repository:** goolord/alpha-nvim
**Header:** ASCII "NEOVIM" logo
**Menu Items:**
- New file
- Toggle file explorer
- Find file
- Find word
- Restore session
- Quit

**File:** `lua/Jack/plugins/alpha.lua`

#### nvim-web-devicons
**Purpose:** File icons support
**Repository:** nvim-tree/nvim-web-devicons
**Used by:** nvim-tree, telescope, lualine

---

### File Management

#### nvim-tree.lua
**Purpose:** File explorer
**Repository:** nvim-tree/nvim-tree.lua
**Width:** 50 columns
**Features:**
- Relative line numbers
- Custom folder arrows (  )
- Indent markers
- Git integration
- Filters out `.DS_Store`

**File:** `lua/Jack/plugins/nvim-tree.lua`

#### telescope.nvim
**Purpose:** Fuzzy finder for files, text, and more
**Repository:** nvim-telescope/telescope.nvim
**Extensions:**
- **fzf-native:** Fast native sorting
- **todo-comments:** Search todos

**Features:**
- Smart path display
- Custom navigation (Ctrl-j/k)
- Send results to quickfix (Ctrl-q)

**File:** `lua/Jack/plugins/telescope.lua`

---

### LSP & Completion

#### nvim-lspconfig
**Purpose:** LSP client configurations
**Repository:** neovim/nvim-lspconfig
**Keybinds:** Extensive LSP keybinds (see KEYBINDS_CHEATSHEET.md)
**Diagnostic Display:**
- Virtual text enabled
- Custom signs (   󰠠  )
- Severity sorting

**File:** `lua/Jack/plugins/lsp/lspconfig.lua`

#### mason.nvim
**Purpose:** LSP/formatter/linter installer
**Repository:** williamboman/mason.nvim
**UI:** Terminal UI for managing tools
**Dependencies:**
- mason-lspconfig.nvim
- mason-tool-installer.nvim

**File:** `lua/Jack/plugins/lsp/mason.lua`

#### nvim-cmp
**Purpose:** Autocompletion engine
**Repository:** hrsh7th/nvim-cmp
**Sources:**
1. LSP completions
2. Snippets (LuaSnip)
3. Buffer text
4. File paths

**Features:**
- VS Code-like icons (lspkind)
- Preview window
- Snippet expansion

**Dependencies:**
- cmp-nvim-lsp
- cmp-buffer
- cmp-path
- cmp_luasnip
- LuaSnip
- friendly-snippets
- lspkind.nvim

**File:** `lua/Jack/plugins/nvim-cmp.lua`

#### neodev.nvim
**Purpose:** Neovim Lua API completion and docs
**Repository:** folke/neodev.nvim
**File:** `lua/Jack/plugins/lsp/lspconfig.lua:7`

#### nvim-lsp-file-operations
**Purpose:** File operation support for LSP
**Repository:** antosha417/nvim-lsp-file-operations
**File:** `lua/Jack/plugins/lsp/lspconfig.lua:6`

---

### Formatting & Linting

#### conform.nvim
**Purpose:** Code formatting
**Repository:** stevearc/conform.nvim
**Format on Save:** Disabled (manual formatting only)
**Timeout:** 1000ms

See [Formatters & Linters](#formatters--linters) section for full list.

**File:** `lua/Jack/plugins/formatting.lua`

#### nvim-lint
**Purpose:** Linting
**Repository:** mfussenegger/nvim-lint
**Auto-lint Events:**
- Buffer enter
- After save
- Leave insert mode

**Smart Features:**
- Only runs eslint_d if config file exists
- Checks for .eslintrc.js, .eslintrc.json, eslint.config.js

**File:** `lua/Jack/plugins/linting.lua`

---

### Code Intelligence

#### nvim-treesitter
**Purpose:** Advanced syntax highlighting and code understanding
**Repository:** nvim-treesitter/nvim-treesitter
**Features:**
- Syntax highlighting
- Smart indentation
- Incremental selection

**Parsers Installed:**
- Python
- C, C++
- C#
- HTML, CSS, JavaScript, TypeScript
- Lua, Bash, JSON, YAML, Markdown, Vim

**File:** `lua/Jack/plugins/treesitter.lua`

#### nvim-ts-context-commentstring
**Purpose:** Context-aware commenting (for JSX, Vue, etc.)
**Repository:** JoosepAlviste/nvim-ts-context-commentstring
**Integration:** Used by Comment.nvim
**File:** `lua/Jack/plugins/comment.lua:5`

---

### Editing Enhancements

#### Comment.nvim
**Purpose:** Easy commenting
**Repository:** numToStr/Comment.nvim
**Features:**
- Line comments (gcc)
- Block comments (gbc)
- Context-aware (JSX/TSX support)

**File:** `lua/Jack/plugins/comment.lua`

#### nvim-surround
**Purpose:** Surround text with quotes, brackets, tags, etc.
**Repository:** kylechui/nvim-surround
**Examples:**
- `ysiw"` - Surround word with quotes
- `ds"` - Delete surrounding quotes
- `cs"'` - Change quotes to apostrophes

**File:** `lua/Jack/plugins/surround.lua`

#### substitute.nvim
**Purpose:** Enhanced substitute operator
**Repository:** gbprod/substitute.nvim
**File:** `lua/Jack/plugins/substitute.lua`

#### nvim-autopairs
**Purpose:** Auto-close brackets, quotes, etc.
**Repository:** windwp/nvim-autopairs
**Features:**
- Treesitter integration
- Works with nvim-cmp
- Language-specific rules

**File:** `lua/Jack/plugins/autopairs.lua`

#### vim-maximizer
**Purpose:** Maximize/restore splits
**Repository:** szw/vim-maximizer
**File:** `lua/Jack/plugins/vim-maximizer.lua`

---

### Git Integration

#### gitsigns.nvim
**Purpose:** Git decorations and hunks
**Repository:** lewis6991/gitsigns.nvim
**Features:**
- Git signs in gutter
- Hunk preview/navigation
- Stage/reset hunks
- Blame information
- Diff view

**File:** `lua/Jack/plugins/gitsigns.lua`

---

### Diagnostics & Todo

#### trouble.nvim
**Purpose:** Pretty list for diagnostics, quickfix, etc.
**Repository:** folke/trouble.nvim
**Features:**
- Workspace/document diagnostics
- Quickfix list viewer
- Location list viewer
- Todo list
- Auto-focus on open

**File:** `lua/Jack/plugins/trouble.lua`

#### todo-comments.nvim
**Purpose:** Highlight and search TODO comments
**Repository:** folke/todo-comments.nvim
**Keywords:** TODO, HACK, WARN, PERF, NOTE, FIX
**Integration:** Works with Telescope and Trouble
**File:** `lua/Jack/plugins/todo-comments.lua`

---

### Session Management

#### auto-session
**Purpose:** Automatic session save/restore
**Repository:** rmagatti/auto-session
**Settings:**
- **Auto-restore:** Disabled (manual restore)
- **Auto-save:** Enabled
- **Suppressed dirs:** Home, Dev, Downloads, Documents, Desktop

**File:** `lua/Jack/plugins/auto-session.lua`

---

### Navigation

#### vim-tmux-navigator
**Purpose:** Seamless navigation between tmux panes and vim splits
**Repository:** christoomey/vim-tmux-navigator
**File:** `lua/Jack/plugins/init.lua:5`

---

## Language Server Protocol (LSP)

### Installed LSP Servers

#### Web Development
| Server | Languages | File Location |
|--------|-----------|---------------|
| **ts_ls** | TypeScript, JavaScript | lspconfig.lua:88 |
| **html** | HTML | lspconfig.lua:89 |
| **cssls** | CSS | lspconfig.lua:90 |
| **tailwindcss** | Tailwind CSS | lspconfig.lua:91 |
| **emmet_ls** | HTML, JSX, TSX, CSS, SCSS, etc. | lspconfig.lua:93 |

#### Python
| Server | Languages | File Location |
|--------|-----------|---------------|
| **pyright** | Python | lspconfig.lua:98 |

#### Systems Programming
| Server | Languages | File Location |
|--------|-----------|---------------|
| **clangd** | C, C++ | lspconfig.lua:101 |

#### .NET Development
| Server | Languages | File Location |
|--------|-----------|---------------|
| **omnisharp** | C# | lspconfig.lua:104 |
| **fsautocomplete** | F# | lspconfig.lua:107 |

#### Configuration
| Server | Languages | File Location |
|--------|-----------|---------------|
| **lua_ls** | Lua | lspconfig.lua:110 |

### LSP Configuration

All servers share the following configuration:
- **Autocompletion:** Enabled via nvim-cmp
- **Keybinds:** Auto-attach on buffer open
- **Diagnostics:** Virtual text, custom signs, severity sorting

**Special Configurations:**
- **emmet_ls:** Only active in web files (HTML, JSX, CSS)
- **lua_ls:** Recognizes `vim` as global variable

**File:** `lua/Jack/plugins/lsp/lspconfig.lua`

---

## Formatters & Linters

### Formatters (conform.nvim)

#### Web Development
| Formatter | Languages |
|-----------|-----------|
| **prettier** | JavaScript, TypeScript, React, HTML, CSS, JSON, YAML, Markdown |

#### Python
| Formatter | Languages | Purpose |
|-----------|-----------|---------|
| **isort** | Python | Import sorting |
| **black** | Python | Code formatting |

#### Systems Programming
| Formatter | Languages |
|-----------|-----------|
| **clang-format** | C, C++ |

#### .NET Development
| Formatter | Languages |
|-----------|-----------|
| **csharpier** | C# |
| **fantomas** | F# |

#### Configuration
| Formatter | Languages |
|-----------|-----------|
| **stylua** | Lua |

**File:** `lua/Jack/plugins/formatting.lua:7-40`

---

### Linters (nvim-lint)

#### Python
| Linter | Purpose |
|--------|---------|
| **pylint** | Python linting |

#### Web Development
| Linter | Purpose | Note |
|--------|---------|------|
| **eslint_d** | JavaScript/TypeScript linting | Only runs if config file exists |

#### Systems Programming
| Linter | Purpose |
|--------|---------|
| **cpplint** | C/C++ linting |

**Note:** C#, F#, and Lua use their LSP servers for diagnostics instead of separate linters.

**File:** `lua/Jack/plugins/linting.lua:7-23`

---

## Color Scheme

### Tokyo Night

**Theme:** Tokyo Night (Night variant)
**Repository:** folke/tokyonight.nvim
**Transparency:** Enabled

#### Custom Colors
- **Background:** `#011628` (custom dark blue)
- **Foreground:** `#CBE0F0` (light blue-white)
- **Highlights:** Custom blue/teal palette
- **Sidebars/Floats:** Transparent

**File:** `lua/Jack/plugins/colourscheme.lua`

---

## Troubleshooting

### LSP Not Starting
1. Check if LSP is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart LSP: `<leader>rs`
4. Check logs: `~/.local/state/nvim/lsp.log`

### Formatter Not Working
1. Check if formatter is installed: `:Mason`
2. Manually trigger: `<leader>mp`
3. Check conform status: `:ConformInfo`

### Telescope Not Finding Files
1. Ensure you're in a valid directory
2. Try `:Telescope find_files hidden=true` for hidden files
3. Check if ripgrep is installed for live_grep

### Plugin Not Loading
1. Check lazy status: `:Lazy`
2. Update plugins: `:Lazy update`
3. Check for errors: `:messages`

### Keybind Not Working
1. Check if plugin is loaded: `:Lazy`
2. Verify keybind: `:map <keybind>`
3. Check which-key: `<Space>` (wait 500ms)

### Git Signs Not Showing
1. Ensure you're in a git repository
2. Check gitsigns status: `:Gitsigns toggle_signs`
3. Refresh: `<leader>er` (refresh file explorer)

---

## Useful Commands

### Plugin Management
- `:Lazy` - Open plugin manager
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy sync` - Install missing + clean unused + update

### LSP Management
- `:Mason` - Open Mason installer
- `:MasonUpdate` - Update Mason
- `:LspInfo` - Show LSP status
- `:LspRestart` - Restart LSP servers

### Diagnostics
- `:Trouble` - Open Trouble window
- `:TodoTelescope` - Find all todos
- `:checkhealth` - Check Neovim health

### Sessions
- `:AutoSession search` - Search sessions
- `:AutoSession restore` - Restore session
- `:AutoSession save` - Save current session
- `:AutoSession delete` - Delete session

---

## Additional Resources

- **Keybinds:** See `KEYBINDS_CHEATSHEET.md`
- **Lazy.nvim Docs:** https://github.com/folke/lazy.nvim
- **Mason Registry:** https://mason-registry.dev/
- **Neovim Docs:** `:help`

---

**End of Documentation**
