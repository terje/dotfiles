local M = {
  "Wansmer/treesj",
  -- keys = { "<space>m", "<space>j", "<space>s" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  require("treesj").setup {
    use_default_keymaps = false
  }
end

return M
