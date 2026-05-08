# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It is a single-file config (`init.lua`) that uses `vim.pack`, the plugin manager built into Neovim (≥0.12).

Since the config lives in `~/.config/nvim-kickstart` rather than `~/.config/nvim`, it is invoked as:

```sh
NVIM_APPNAME="nvim-kickstart" nvim
```

## Lua formatting

All Lua must be formatted with **StyLua** before committing. The CI workflow (`stylua.yml`) enforces this on PRs.

```sh
stylua .          # format in-place
stylua --check .  # check without modifying (used by CI)
```

StyLua settings (`.stylua.toml`): 2-space indent, 160-column width, single quotes preferred, parentheses omitted where optional, simple statements collapsed to one line.

## Architecture

### `init.lua` structure

The file is divided into nine numbered `do … end` blocks, one per concern:

| Section | Contents |
|---------|----------|
| 1 | Options, leader (`<Space>`), basic keymaps, autocmds |
| 2 | `vim.pack` intro; `PackChanged` build hooks for `telescope-fzf-native`, `LuaSnip`, `nvim-treesitter` |
| 3 | UI plugins: guess-indent, gitsigns, which-key, tokyonight, todo-comments, mini.nvim (ai, surround, statusline) |
| 4 | Telescope + fzf-native; `<leader>s*` search keymaps; LSP picker keymaps wired on `LspAttach` |
| 5 | LSP: fidget, nvim-lspconfig, Mason, mason-lspconfig, mason-tool-installer; server table (`servers`) |
| 6 | conform.nvim formatting; `<leader>f` keymap |
| 7 | LuaSnip (pinned `2.*`) + blink.cmp (pinned `1.*`) autocomplete |
| 8 | nvim-treesitter (branch `main`); auto-install parsers on `FileType` |
| 9 | `require` calls for optional kickstart plugins and custom plugins |

### Optional plugins (`lua/kickstart/plugins/`)

Each file is a self-contained plugin spec that can be opted-in by uncommenting its `require` line in Section 9:

- `debug.lua` — DAP debugging
- `indent_line.lua` — indent guides
- `lint.lua` — nvim-lint
- `autopairs.lua` — auto-pairs
- `neo-tree.lua` — file explorer (currently **active**)
- `gitsigns.lua` — extended gitsigns keymaps (gitsigns itself is always loaded in Section 3)

### Custom plugins (`lua/custom/plugins/`)

`lua/custom/plugins/init.lua` auto-loads every `.lua` file in that directory (except itself). Add new personal plugins by creating files there.

## Plugin management

`vim.pack` is the built-in manager. Common commands run inside Neovim:

```vim
:lua vim.pack.update(nil, { offline = true })   " inspect state / pending updates
:lua vim.pack.update()                           " fetch and apply updates
:Mason                                           " manage LSP servers and tools
```

## Health check

```vim
:checkhealth kickstart
```

Checks Neovim version (≥0.12 required) and external executables (`git`, `make`, `unzip`, `rg`).

## Adding an LSP server

Edit the `servers` table in Section 5 of `init.lua`. Mason will install it automatically on next startup:

```lua
local servers = {
  gopls = {},
  -- ...
}
```

## Key keymaps (for reference when editing config)

| Keymap | Action |
|--------|--------|
| `<leader>s*` | Telescope search pickers |
| `<leader>f` | Format buffer (conform.nvim) |
| `<leader>th` | Toggle inlay hints (LSP) |
| `gr*` | LSP actions (rename, code action, references, etc.) |
| `\` | Toggle NeoTree file explorer |
| `<leader>q` | Open diagnostic quickfix list |
