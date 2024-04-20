local M = {
  "Wansmer/treesj",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "VeryLazy",
}

function M.config()
  require("treesj").setup {
    use_default_keymaps = false,
  }
end

return M
