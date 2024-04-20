local M = {
  dir = "/Users/terje/Development/NeoVim/simctl.nvim",
  -- "terje/simctl.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  require("simctl").setup()
end

return M
