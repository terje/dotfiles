local M = {
  "echasnovski/mini.nvim",
  version = "*",
}

function M.config()
  require("mini.bufremove").setup()
  require("mini.surround").setup()
end

return M
