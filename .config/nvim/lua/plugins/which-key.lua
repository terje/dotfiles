return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.icons = {
      rules = {
        { pattern = "device", icon = " ", color = "teal" },
      },
    }
  end,
}
