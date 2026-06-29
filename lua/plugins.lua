vim.pack.add({
    { src = "https://github.com/EdenEast/nightfox.nvim" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

})


-- Adding autocomplete
vim.o.autocomplete = true
vim.o.pumborder = "rounded"

-- nightfox + transparency
require("nightfox").setup({
    options = { transparent = true },
})
vim.cmd.colorscheme("nordfox")

-- nvim surround addition
require("nvim-surround").setup({})


-- mini.clue — show next key hints for built-in keys
local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "z" },
        { mode = "n",          keys = "[" },
        { mode = "n",          keys = "]" },
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },
        { mode = { "n", "x" }, keys = '"' },
        { mode = "n",          keys = "<C-w>" },
        { mode = "i",          keys = "<C-x>" },  -- built-in completion
	{ mode = { "i", "c" }, keys = "<C-r>" },
    },
    clues = {
        miniclue.gen_clues.g(),
        miniclue.gen_clues.z(),
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.builtin_completion(),
    },
    window = {
        delay = 400,   -- ms before popup appears
    },
})


-- mini.snippets 

require("mini.snippets").setup({
  snippets = {
    require("mini.snippets").gen_loader.from_lang(),
  },
  mappings = {
    expand    = "<Tab>",
    jump_next = "<Tab>",
    jump_prev = "<S-Tab>",
  }
})


require("mini.ai").setup({})
require("mini.pairs").setup({})
require("mini.bracketed").setup({})
require("mini.trailspace").setup({})


require("nvim-ts-autotag").setup({})


-- ============================================
-- MJML
-- ============================================

vim.pack.add({
    { src = "https://github.com/amadeus/vim-mjml" },
    { src = "https://github.com/enochchau/mjml-preview.nvim" },
})

-- Keymap: <leader>mp to toggle live preview (only in .mjml buffers)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "mjml",
    callback = function()
        vim.keymap.set("n", "<leader>mp", "<cmd>MjmlPreviewToggle<cr>", {
            buffer = true,
            desc = "Toggle MJML preview",
        })
    end,
})
