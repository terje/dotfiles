return {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nordic").setup({
      swap_backgrounds = true,
    })
    require("nordic").load()
  end,
}
