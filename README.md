# Jack's Neovim config

Lua configuration for web development, Python, C/C++, C#, F#, SQL, and Lua.
Space is the leader key. See the [keybind cheatsheet](KEYBINDS_CHEATSHEET.md)
and [configuration reference](DOCUMENTATION.md).

## Requirements

The current lockfile was tested on Ubuntu 22.04 ARM64 with Neovim **0.12.5**.
Use a recent stable Neovim; Ubuntu 22.04's packaged Neovim 0.6.1 cannot run this config.

| Dependency | Used for |
| --- | --- |
| Git, curl, tar, unzip, a C compiler | Plugin downloads and parser builds |
| Node.js and npm (tested with Node 24) | Web language servers, formatters, linters |
| Python with working `venv` and pip (tested with Python 3.13) | Python tools and clang-format |
| .NET SDK (tested with SDK 10) | C#/F# language servers and formatters |
| Tree-sitter CLI **0.26.1+** | Building the configured syntax parsers |
| ripgrep (`rg`) and `fd` | Text search and file pickers |
| Nerd Font | Icons; select it in your terminal |
| Platform clipboard tool | For example xclip on X11 or wl-clipboard on Wayland |

Make these tools available in the PATH inherited by Neovim. On Debian/Ubuntu,
`python3-venv` provides the missing virtual-environment support. A uv-managed
Python is another option. Install .NET from Microsoft's instructions for your platform.

Optional: `live-server` for `:LiveServerToggle`, `lazygit` for the Git UI, and
ImageMagick for image previews. Unused Ruby, Perl, Go, or other provider warnings
in `:checkhealth` do not require installing those languages.

## Install

Back up any existing Neovim config before cloning. These commands assume the
standard Linux/macOS config location; adjust it if using `XDG_CONFIG_HOME`.
On Windows, use Neovim's `stdpath("config")` location instead.

```sh
git clone https://github.com/JackBjerregaard/neovim-config.git ~/.config/nvim
nvim
```

Let the initial plugin installation finish. Run `:Lazy restore` to use the
committed plugin versions, then restart Neovim. Mason installs the configured
language servers automatically; run `:MasonToolsInstallSync` for formatters and
linters and check `:Mason` for failures. Parser installation also runs at startup;
keep Neovim open until it finishes.

`lazy-lock.json` is tracked to make plugin versions reproducible. Deliberate
updates use `:Lazy update`; test and commit the resulting lockfile change.
The lockfile does not pin Mason packages, npm dependencies, or system tools.
See [Lazy's lockfile documentation](https://lazy.folke.io/usage/lockfile).

## Linux ARM64 and older Ubuntu

Mason's clangd package currently has no Linux ARM64 build. This config skips
Mason installation on Linux ARM64 but still enables clangd from PATH. For example,
with [uv](https://docs.astral.sh/uv/) installed:

```sh
uv tool install --python 3.13 clangd
clangd --version
```

Mason still installs clangd on other platforms. macOS ARM64 is not excluded.

If a Tree-sitter CLI binary fails with `GLIBC_2.39 not found` on Ubuntu 22.04,
build a compatible CLI locally. With Rust/Cargo, a C compiler, and libclang
including its development headers installed:

```sh
cargo install tree-sitter-cli --version 0.26.6 --locked --no-default-features
tree-sitter --version
```

This build uses Node.js for grammar generation. Ensure Cargo's bin directory
is on PATH. If using a nonstandard libclang installation, set `LIBCLANG_PATH`
and provide the appropriate headers to bindgen. Do not downgrade the CLI below
the plugin's required version just to avoid the glibc error.

## Machine-specific settings

An optional, Git-ignored `local.lua` in the config directory is loaded **before**
the shared configuration. Use it for local executable paths or provider settings:

```lua
-- Example for Unix systems; use your actual tools directory.
local tools = vim.fn.expand("~/.local/opt/nvim-tools/bin")
if vim.fn.isdirectory(tools) == 1 then
  vim.env.PATH = tools .. ":" .. vim.fn.expand("~/.local/bin") .. ":" .. vim.env.PATH
end
```

Desktop clipboard detection is automatic. In terminals without a desktop display,
OSC 52 can be opted into with `vim.g.clipboard = "osc52"` in `local.lua`.
Support, especially reading the clipboard, depends on the terminal; test copying
and pasting interactively. The config does not force that fallback on every machine.

## Verify

Inside Neovim:

```vim
:checkhealth nvim-treesitter mason-lspconfig
:Mason
:checkhealth vim.lsp
:ConformInfo
```

Open a source file inside a project and confirm its server attaches; test `gd`
and `K`, then `Space fm` for formatting. Some servers need project/root markers.
The initial setup verified Lua, Python, C, TypeScript, SQL server attachment,
all 18 configured parsers, and CodeDiff's native diff engine. C#/F# formatters
were checked, but project-level C#/F# server behavior still needs a real project.

ESLint runs when the buffer has a configuration file in its directory or an
ancestor, independently of Neovim's current directory. Switching to an
unconfigured project does not disable linting in other projects. Flat configs
include the [JS and TS filename variants supported by ESLint](https://eslint.org/docs/latest/use/configure/configuration-files).
Legacy `.eslintrc` files and `package.json`'s `eslintConfig` are detected too;
the project's ESLint version must support that format. TypeScript configs may
require extra setup described in the ESLint docs.

## SQL server dependency workaround

With `sql-language-server` 1.7.1, startup can fail with
`ERR_PACKAGE_PATH_NOT_EXPORTED` for `vscode-languageserver-protocol/lib/common/protocol`.
The tested repair pins that dependency to 3.17.5 inside Mason's package directory.
Find your data directory with `:echo stdpath('data')`; on a default Linux install:

```sh
cd ~/.local/share/nvim/mason/packages/sqlls
npm pkg set 'overrides.sql-language-server.vscode-languageserver-protocol=3.17.5'
npm pkg set --json 'allowScripts.sqlite3=true'
npm install
./node_modules/.bin/sql-language-server --version
```

The `allowScripts` setting permits SQLite's native installation step with npm
versions that require explicit build-script approval. A Mason reinstall or update
can replace this repair; reapply it only if the same startup error returns.
Restart the server with `Space rs` afterward.

## Quick keys

| Key | Action |
| --- | --- |
| `Space ee` | File explorer |
| `Space ff` | Find files |
| `Space fm` | Format buffer or selection |
| `gd` / `K` | Definition / hover documentation |
| `jk` in insert mode | Return to normal mode |

## Regression checks

These checks use Neovim's Lua runtime and stub plugin services; they do not
download plugins or install language tools:

```sh
nvim --headless -u NONE -l tests/config_spec.lua
```
