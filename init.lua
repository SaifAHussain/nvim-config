-- My minimal Writer Deck Config

-- ============================================
-- Global defaults (apply to ALL files / code)
-- ============================================
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative numbers
vim.opt.signcolumn = "no"      -- Hide left gutter
vim.opt.termguicolors = true   -- Enable pretty colours

-- Code-friendly defaults (writer-deck stuff lives in ftplugin/markdown.lua)
vim.opt.spell = false

vim.opt.wrap = true
vim.opt.linebreak = true
-- Arabic Support
vim.opt.arabicshape = true     -- Forces neovim to connect Arabic letters visually

-- ==========================================
-- Custom Notion-Style Journal Folding
-- (Defined globally; only ACTIVATED in ftplugin/markdown.lua)
-- ==========================================
vim.cmd([[
function! JournalFold()
  let line = getline(v:lnum)

    " Level 1 Fold: Matches the Year (e.g., '- 2016' or ' - 2024')
    if line =~ '^\s*-\s*\d\{4}'
      return ">1"

    " Level 2 Fold: Matches the Date (e.g., '  ## 20/12/16')
    elseif line =~ '^\s*##\s'
      return ">2"

    " Level 3 Fold: Matches the sections
    elseif line =~ '^\s*###\s'
      return ">3"

    " Everything else stays inside the fold above it
    else
      return "="
    endif

endfunction
]])

-- ============================================
-- Plugins (loaded from lua/plugins.lua)
-- ============================================
require("plugins")

-- ============================================
-- LSP
-- ============================================
vim.lsp.enable("ruff")
vim.lsp.enable("tinymist")

-- ============================================
-- Clipboard
-- ============================================
vim.opt.clipboard = "unnamedplus"


-- Setting up Prettier LSP for HTML/CSS
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.html", "*.css" },
    callback = function()
        local file = vim.fn.expand("%:p")
        vim.fn.system({ "prettier", "--write", file })
        vim.cmd("edit!")
    end,
})

-- Auto-write on exiting insert mode for Typst:

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*.typ",
    command = "silent! write"
})
