# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It is a single-file config (`init.lua`) that uses `vim.pack`, the plugin manager built into Neovim (≥0.12).

The config lives at `~/.config/nvim` and is invoked normally as `nvim`.

## Lua formatting

All Lua must be formatted with **StyLua** before committing. The CI workflow (`stylua.yml`) enforces this on PRs.

```sh
stylua .          # format in-place
stylua --check .  # check without modifying (used by CI)
```

StyLua settings (`.stylua.toml`): 2-space indent, 160-column width, single quotes preferred, parentheses omitted where optional, simple statements collapsed to one line.

Note: the CI workflow (`stylua.yml`) contains a guard `if: github.repository == 'nvim-lua/kickstart.nvim'` and will not run on this fork — run `stylua --check .` locally before committing.

## Architecture

### `init.lua` structure

The file is divided into nine numbered `do … end` blocks, one per concern:

| Section | Name | Contents |
|---------|------|----------|
| 1 | FOUNDATION | Options, leader (`<Space>`), basic keymaps, autocmds |
| 2 | PLUGIN MANAGER INTRO | `vim.pack` intro; `PackChanged` build hooks for `telescope-fzf-native`, `LuaSnip`, `nvim-treesitter` |
| 3 | UI / CORE UX PLUGINS | guess-indent, gitsigns, which-key, tokyonight, todo-comments, mini.nvim (ai, surround, statusline) |
| 4 | SEARCH & NAVIGATION | Telescope + fzf-native; `<leader>s*` search keymaps; LSP picker keymaps wired on `LspAttach` |
| 5 | LSP | fidget, nvim-lspconfig, Mason, mason-lspconfig, mason-tool-installer; server table (`servers`) |
| 6 | FORMATTING | conform.nvim formatting; `<leader>f` keymap |
| 7 | AUTOCOMPLETE & SNIPPETS | LuaSnip (pinned `2.*`) + blink.cmp (pinned `1.*`) |
| 8 | TREESITTER | nvim-treesitter (branch `main`); auto-install parsers on `FileType` |
| 9 | OPTIONAL EXAMPLES / NEXT STEPS | `require` calls for optional kickstart plugins and custom plugins |

### Optional plugins (`lua/kickstart/plugins/`)

Each file is a self-contained plugin spec toggled by its `require` line in Section 9. Currently **active** (uncommented):

- `debug.lua` — DAP debugging
- `indent_line.lua` — indent guides
- `autopairs.lua` — auto-pairs
- `neo-tree.lua` — file explorer
- `gitsigns.lua` — extended gitsigns keymaps (gitsigns itself is always loaded in Section 3)

Currently **inactive** (commented out):

- `lint.lua` — nvim-lint

### Custom plugins (`lua/custom/plugins/`)

`lua/custom/plugins/init.lua` auto-loads every `.lua` file in that directory (except itself). Add new personal plugins by creating files there — the pattern is `vim.pack.add { 'https://github.com/…' }` followed by plugin setup in the same file.

Currently active custom plugins:

- `metals.lua` — Scala/SBT/Java LSP via [nvim-metals](https://github.com/scalameta/nvim-metals); attaches on `FileType scala,sbt,java` and sets up DAP
- `better-escape.lua` — maps `jj` to `<C-\><C-n>` in terminal mode (insert-mode escape uses plugin defaults)
- `vimwiki.lua` — [VimWiki](https://github.com/vimwiki/vimwiki) with markdown syntax; wiki stored at `~/vimwiki/`

## Plugin management

`vim.pack` is the built-in manager. Pinned versions are tracked in `nvim-pack-lock.json`. Common commands run inside Neovim:

```vim
:lua vim.pack.update(nil, { offline = true })   " inspect state / pending updates
:lua vim.pack.update()                           " fetch and apply updates
:Mason                                           " manage LSP servers and tools
```

## Health check

```vim
:checkhealth kickstart
:help kickstart
```

`:checkhealth kickstart` (defined in `lua/kickstart/health.lua`) verifies Neovim version (≥0.12 required) and external executables (`git`, `make`, `unzip`, `rg`). `:help kickstart` opens the bundled help at `doc/kickstart.txt`.

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
