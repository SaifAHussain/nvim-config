-- ============================================
-- Writer Deck mode — follows LIFE.md anywhere
-- ============================================
if vim.fn.expand("%:t") ~= "LIFE.md" then
    return
end

-- Writing Experience
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_gb"

-- Distraction-free visuals
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"

-- Notion-Style Journal Folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "JournalFold()"
vim.opt_local.foldtext = "getline(v:foldstart)"
