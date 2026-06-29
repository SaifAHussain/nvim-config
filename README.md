# Neovim Config

Minimal, native-first setup. No plugin manager — uses Neovim 0.12's built-in `vim.pack`.

## Structure

```
~/.config/nvim/
├── init.lua          # Global options, LSP, auto-saves
├── lua/
│   └── plugins.lua   # All plugins + their setups (mini.nvim modules, colorscheme)
├── lsp/
│   ├── ruff.lua      # Ruff LSP config (Python)
│   └── tinymist.lua  # Tinymist LSP config (Typst)
├── snippets/
│   └── typst.lua     # Raw math & markup snippets for Typst
└── ftplugin/
    └── markdown.lua  # Writer-deck mode 
```

## Plugins

| Plugin          | Purpose                                           |
| --------------- | ------------------------------------------------- |
| `nightfox.nvim` | Colourscheme (`nordfox` + transparent background) |
| `nvim-surround` | Surround actions (`ys`, `ds`, `cs`)               |
| `mini.nvim`     | Suite of lightweight modules (see below)          |

### mini.nvim modules in use

| Module            | Purpose                                  |
| ----------------- | ---------------------------------------- |
| `mini.clue`       | Helix-style key hint popups              |
| `mini.ai`         | Extended text objects (`a`/`i`)          |
| `mini.pairs`      | Auto-close brackets and quotes           |
| `mini.snippets`   | Lightweight template & snippet expansion |
| `mini.bracketed`  | Extended `[`/`]` navigation              |
| `mini.trailspace` | Highlight and remove trailing whitespace |

*Note: Autocomplete is handled by Neovim 0.12's native `vim.o.autocomplete = true`.*

## LSP

Configured natively via `vim.lsp` — no `nvim-lspconfig`, no Mason.

| Server     | Language               | Install                | Config File         |
| ---------- | ---------------------- | ---------------------- | ------------------- |
| `ruff`     | Python (lint + format) | `uv tool install ruff` | `lsp/ruff.lua`      |
| `tinymist` | Typst (preview + compilation) | `cargo install tinymist` | `lsp/tinymist.lua`  |

To add a new server: create `lsp/<name>.lua` returning a config table, then add `vim.lsp.enable("<name>")` in `init.lua`.

## Key bindings

### Surround (`nvim-surround`)

| Key                | Action              | Example                       |
| ------------------ | ------------------- | ----------------------------- |
| `ys{motion}{char}` | Add surround        | `ysiw"` → wrap word in quotes |
| `ds{char}`         | Delete surround     | `ds"` → remove quotes         |
| `cs{old}{new}`     | Replace surround    | `cs"'` → change `"` to `'`    |
| `yss{char}`        | Surround whole line | `yss(` → wrap line in parens  |

### mini.clue triggers (press and wait)

| Key                  | Shows                 |
| -------------------- | --------------------- |
| `g`                  | `g`-prefixed commands |
| `z`                  | Fold commands         |
| `[` / `]`            | Prev/next navigation  |
| `'` / `` ` ``        | Marks                 |
| `"`                  | Registers             |
| `<C-w>`              | Window commands       |
| `<C-x>` (insert)     | Built-in completion   |
| `<C-r>` (insert/cmd) | Paste from register   |

### Snippets (`mini.snippets`)

| Key       | Action                  |
| --------- | ----------------------- |
| `<Tab>`   | Expand or jump forward  |
| `<S-Tab>` | Jump backward           |

## Filetype behaviour

### All files (global defaults)

- Line numbers and relative line numbers on
- Soft wrap + linebreak on
- No spell check by default
- Clipboard synchronized to system clipboard (`unnamedplus`)
- **Typst auto-save:** Files auto-save on exiting Insert mode (`InsertLeave`) to trigger live-preview renders.

### Writer-Deck Mode

Triggered by filename match in `ftplugin/markdown.lua`.

- Soft wrap + linebreak
- British English spell check
- Line numbers hidden
- Notion-style journal folding (`JournalFold()`)
  - Level 1: year lines (`- 2024`)
  - Level 2: date headings (`## dd/mm/yy`)
  - Level 3: section headings (`### ...`)

## Transparency

Ghostty handles window transparency (`background-opacity`). Neovim respects it via `nightfox`'s `transparent = true` option, which clears the `Normal` background so the terminal shows through.
